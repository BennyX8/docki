import 'package:docki/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinput/pinput.dart';
import '../bloc/auth_bloc.dart';

class VerificationPage extends StatefulWidget {
  final String phone;
  const VerificationPage({Key? key, required this.phone}) : super(key: key);

  @override
  State<VerificationPage> createState() => _VerificationPageState();
}

class _VerificationPageState extends State<VerificationPage> {
  final authBloc = sl<AuthBloc>();

  String otp = '';
  bool loading = false;

  @override
  void initState() {
    super.initState();

    // CachManager.instance.clearPref('auth_user');
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus?.unfocus();
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: BlocProvider(
          create: (context) => authBloc,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is VerifyPhoneLoaded) {
                setState(() {
                  loading = false;
                });
              } else if (state is VerifyPhoneLoading) {
                setState(() {
                  loading = true;
                });
              } else if (state is VerifyPhoneError) {
                setState(() {
                  loading = false;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.failure.message)),
                );
              }
            },
            child: Container(
              alignment: Alignment.center,
              child: SingleChildScrollView(
                child: SizedBox(
                  width: 350.0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.black,
                        radius: 30.0,
                        child: Icon(
                          FontAwesomeIcons.solidIdBadge,
                          size: 50,
                          color: Colors.orange.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 20.0),
                      Text(
                        'Verify Phone',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.orange.withOpacity(0.8)),
                      ),

                      const SizedBox(height: 70.0),

                      Pinput(
                        length: 4,
                        defaultPinTheme: PinTheme(
                            width: 50.0,
                            height: 50.0,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(16.0),
                              border: Border.all(color: Colors.grey),
                            )),
                        submittedPinTheme: PinTheme(
                          width: 50.0,
                          height: 50.0,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(16.0),
                            border: Border.all(color: Colors.orange),
                          ),
                        ),
                        onChanged: (value) {
                          otp = value;
                        },
                      ),

                      //* Vertical Spacer
                      const SizedBox(height: 50.0),

                      //!Login Button
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.orange.withOpacity(0.8),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 35.0,
                            vertical: 14.0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                        ),
                        onPressed: loading
                            ? () {}
                            : () {
                                final message = _authenticateUser();

                                if (message.isEmpty) {
                                  // authBloc.add();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(message)),
                                  );
                                }
                              },
                        child: loading
                            ? const SizedBox(
                                width: 20.0,
                                height: 20.0,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 1,
                                ),
                              )
                            : const Text(
                                'Verify Phone',
                                style: TextStyle(fontSize: 15.0),
                              ),
                      ),

                      //* Vertical Spacer
                      const SizedBox(height: 30.0),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Didn\'t get it?'),

                          //* Horizontal Spacer
                          const SizedBox(width: 10.0),
                          InkWell(
                            onTap: () {
                              //Resend OTP
                            },
                            child: const Text(
                              'Resend OTP',
                              style: TextStyle(color: Colors.orange),
                            ),
                          ),
                        ],
                      ),

                      //* Vertical Spacer
                      const SizedBox(height: 20.0),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _authenticateUser() {
    //Dismiss Softkeyboard
    FocusManager.instance.primaryFocus?.unfocus();

    //Autovalidate user's email
    if (otp.isEmpty || otp.length != 4) {
      return 'Enter valid OTP';
    } else {
      return '';
    }
  }
}
