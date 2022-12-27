import 'dart:convert';

import 'package:docki/core/exceptions/exception.dart';
import 'package:docki/features/auth/data/model/auth_user_model.dart';
import 'package:docki/features/auth/domain/usecases/send_sms_otp.dart';
import 'package:docki/features/auth/domain/usecases/signin.dart';
import 'package:firedart/firedart.dart';
import 'package:http/http.dart' as http;

import '../../domain/usecases/signup.dart';
import '../../domain/usecases/verify_phone.dart';

abstract class AuthRemoteSource {
  Future<AuthUserModel> signin(SigninParams params);
  Future<AuthUserModel> signup(SignupParams params);
  Future<bool> signout();
  Future<AuthUserModel> verifyPhone(VerifyPhoneParams params);
  Future<bool> sendSmsOtp(SendSmsOtpParams params);
}

class AuthRemoteSourceImpl implements AuthRemoteSource {
  final http.Client client;

  AuthRemoteSourceImpl(this.client);

  @override
  Future<AuthUserModel> signin(SigninParams params) async {
    return await FirebaseAuth.instance
        .signIn(
      params.email,
      params.password,
    )
        .then((user) async {
      return AuthUserModel(
        id: user.id,
        name: user.displayName!,
        email: user.email!,
      );
    }, onError: (e) {
      throw ServerException('message');
    });

    // throw UnimplementedError();
  }

  @override
  Future<bool> signout() async {
    FirebaseAuth.instance.signOut();

    return true;
  }

  @override
  Future<AuthUserModel> signup(SignupParams params) async {
    return FirebaseAuth.instance
        .signUp(params.email, params.password)
        .then((user) async {
      return await FirebaseAuth.instance
          .updateProfile(
        displayName: params.name,
      )
          .then(
        (nothing) {
          return AuthUserModel(
            id: user.id,
            name: user.displayName!,
            email: user.email!,
          );
        },
      );
    });
  }

  @override
  Future<AuthUserModel> verifyPhone(VerifyPhoneParams params) async {
    throw UnimplementedError();
  }

  @override
  Future<bool> sendSmsOtp(SendSmsOtpParams params) async {
    const String apiKey =
        'Apikey eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJqdGkiOiJiMzRjMGEzMC02OTE4LTExZWQtYTVmNi1jMzA4N2I0Zjc3YWQiLCJzdWIiOiJTSE9VVE9VVF9BUElfVVNFUiIsImlhdCI6MTY2ODk3OTAzMiwiZXhwIjoxOTg0NTk4MjMyLCJzY29wZXMiOnsiYWN0aXZpdGllcyI6WyJyZWFkIiwid3JpdGUiXSwibWVzc2FnZXMiOlsicmVhZCIsIndyaXRlIl0sImNvbnRhY3RzIjpbInJlYWQiLCJ3cml0ZSJdfSwic29fdXNlcl9pZCI6IjgzODc5Iiwic29fdXNlcl9yb2xlIjoidXNlciIsInNvX3Byb2ZpbGUiOiJhbGwiLCJzb191c2VyX25hbWUiOiIiLCJzb19hcGlrZXkiOiJub25lIn0.kb2lZaRasv9bB-JNZVrbqB_XYPZZ5H9Yz2fSk_lvD6M';

    final response = await client.post(
      Uri.parse('https://api.getshoutout.com/otpservice/send'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': apiKey,
      },
      body: json.encode({
        "source": "ShoutDEMO",
        "destination": params.phone,
        "transport": "sms",
        "content": {"sms": "Your OTP Code is 7936"}
      }),
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      throw ServerException('Error sending sms');
    }
  }
}
