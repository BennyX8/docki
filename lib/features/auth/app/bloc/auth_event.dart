part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

//* Signin Event
class SigninEvent extends AuthEvent {
  final String email;
  final String password;

  const SigninEvent(this.email, this.password);
}

//* Signup Event
class SignupEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;
  final String interest;
  final String phone;

  const SignupEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.interest,
    required this.phone,
  });
}

//* VerifyPhone Event
class VerifyPhoneEvent extends AuthEvent {
  final String phone;
  final String otp;

  const VerifyPhoneEvent(this.phone, this.otp);
}

//* sendPhoneOtp Event
class SendPhoneOtpEvent extends AuthEvent {
  final String phone;

  const SendPhoneOtpEvent(this.phone);
}

//* Signout Event
class SignoutEvent extends AuthEvent {
}
