import 'package:bloc/bloc.dart';
import 'package:docki/core/usecase/usecase.dart';
import 'package:docki/features/auth/domain/entities/auth_user.dart';
import 'package:docki/features/auth/domain/usecases/signin.dart';
import 'package:docki/features/auth/domain/usecases/signout.dart';
import 'package:docki/features/auth/domain/usecases/signup.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/failures/failure.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Signin signin;
  final Signup signup;
  final Signout signout;
  AuthBloc(this.signin, this.signup, this.signout) : super(AuthInitial()) {
    on<AuthEvent>((event, emit) async {
      if (event is SigninEvent) {
        emit(SigninLoading());

        final result = await signin(SigninParams(event.email, event.password));

        emit(result.fold(
          (failure) => SigninError(failure),
          (authUser) => SigninLoaded(authUser),
        ));
      } else if (event is SignupEvent) {
        emit(SignupLoading());

        final result = await signup(
          SignupParams(
            email: event.email,
            password: event.password,
            name: event.name,
            phone: event.phone,
            interest: event.interest,
          ),
        );

        emit(result.fold(
          (failure) => SignupError(failure),
          (authUser) => SignupLoaded(authUser),
        ));
      } else if (event is SignoutEvent) {
        emit(SignoutLoading());

        final result = await signout(NoParams());

        emit(result.fold(
          (failure) => SignoutError(failure),
          (status) => SignoutLoaded(status),
        ));
      }
    });
  }
}
