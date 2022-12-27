import 'package:docki/core/widgets/custom_password_field.dart';
import 'package:docki/features/auth/app/pages/signup_page.dart';
import 'package:docki/injection_container.dart';
import 'package:docki/root.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/widgets/custom_route.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../bloc/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  VideoPlayerController? _playerController;
  final emailTextController = TextEditingController();
  final passwordController = TextEditingController();

  final authBloc = sl<AuthBloc>();

  bool loading = false;

  @override
  void initState() {
    super.initState();

    _playerController = VideoPlayerController.asset('assets/intro.mp4',
        videoPlayerOptions: VideoPlayerOptions())
      ..initialize().then(
        (value) {
          _playerController?.play();
          _playerController?.setLooping(true);
          setState(() {});
        },
      );
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
              if (state is SigninLoaded) {
                setState(() {
                  loading = false;
                });

                Navigator.pushReplacement(
                  context,
                  CustomRoute(child: const RootWidget()),
                );
              } else if (state is SigninLoading) {
                setState(() {
                  loading = true;
                });
              } else if (state is SigninError) {
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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Opacity(
                    opacity: 0.2,
                    child: SizedBox.expand(
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: SizedBox(
                          height: _playerController?.value.size.height,
                          width: _playerController!.value.size.width,
                          child: VideoPlayer(_playerController!),
                        ),
                      ),
                    ),
                  ),
                  SingleChildScrollView(
                    child: SizedBox(
                      width: 350.0,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            // backgroundColor: Colors.black,
                            radius: 30.0,
                            child: Icon(
                              FontAwesomeIcons.solidUser,
                              size: 50,
                              color: Colors.orange.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Login',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.orange.withOpacity(0.8)),
                          ),

                          const SizedBox(height: 70.0),

                          //!Email TextField
                          CustomTextField(
                            controller: emailTextController,
                            action: TextInputAction.next,
                            autoCorrect: false,
                            obscureText: false,
                            hintText: 'Email Address',
                            fieldName: 'email',
                            onChanged: (text) {
                              // emailTextController.text = text;
                            },
                          ),

                          //* Vertical Spacer
                          const SizedBox(height: 10.0),

                          //* Password Field
                          CustomPasswordField(
                            controller: passwordController,
                            action: TextInputAction.done,
                            autoCorrect: false,
                            obscureText: false,
                            hintText: 'Password',
                            fieldName: 'password',
                            onChanged: (text) {
                              // passwordController.text = text;
                            },
                          ),

                          //* Vertical Spacer
                          const SizedBox(height: 30.0),

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
                                      authBloc.add(SigninEvent(
                                        emailTextController.text,
                                        passwordController.text,
                                      ));
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
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
                                    'Login',
                                    style: TextStyle(fontSize: 18.0),
                                  ),
                          ),

                          //* Vertical Spacer
                          const SizedBox(height: 30.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Don\'t have an account?'),

                              //* Horizontal Spacer
                              const SizedBox(width: 10.0),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    CustomRoute(
                                      child: const SignupPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign Up',
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
                ],
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
    if (!EmailValidator.validate(emailTextController.text)) {
      return 'Invalid email address';
    } else if (passwordController.text.isEmpty) {
      return 'Enter a valid password';
    } else {
      return '';
    }
  }

  @override
  void dispose() {
    _playerController?.dispose();
    super.dispose();
  }
}
