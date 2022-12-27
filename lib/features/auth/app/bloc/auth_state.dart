part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();
  
  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

//* Signin States
class SigninLoaded extends AuthState {
  final AuthUser authUser;
  const SigninLoaded(this.authUser);
}
class SigninLoading extends AuthState {}
class SigninError extends AuthState {
  final Failure failure;
  const SigninError(this.failure);
}

//* Signup States
class SignupLoaded extends AuthState {
  final AuthUser authUser;
  const SignupLoaded(this.authUser);
}
class SignupLoading extends AuthState {}
class SignupError extends AuthState {
  final Failure failure;
  const SignupError(this.failure);
}

//* VerifyPhone States
class VerifyPhoneLoaded extends AuthState {
  final AuthUser authUser;
  const VerifyPhoneLoaded(this.authUser);
}
class VerifyPhoneLoading extends AuthState {}
class VerifyPhoneError extends AuthState {
  final Failure failure;
  const VerifyPhoneError(this.failure);
}

//* SendPhoneOtp States
class SendPhoneOtpLoaded extends AuthState {
  final bool status;
  const SendPhoneOtpLoaded(this.status);
}
class SendPhoneOtpLoading extends AuthState {}
class SendPhoneOtpError extends AuthState {
  final Failure failure;
  const SendPhoneOtpError(this.failure);
}

//* Signout States
class SignoutLoaded extends AuthState {
  final bool status;
  const SignoutLoaded(this.status);
}
class SignoutLoading extends AuthState {}
class SignoutError extends AuthState {
  final Failure failure;
  const SignoutError(this.failure);
}