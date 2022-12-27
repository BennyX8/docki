import 'package:docki/core/widgets/custom_password_field.dart';
import 'package:docki/features/auth/app/pages/login_page.dart';
import 'package:docki/features/auth/domain/entities/auth_user.dart';
import 'package:docki/injection_container.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';
import '../../../../core/widgets/custom_route.dart';
import '../../../../core/widgets/custom_textfield.dart';
import '../../../../root.dart';
import '../bloc/auth_bloc.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  VideoPlayerController? _playerController;
  final nameTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final passwordController = TextEditingController();
  String interest = '';

  final authBloc = sl<AuthBloc>();
  bool loading = false;

  AuthUser? authUser;

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
          elevation: 0,
          toolbarHeight: 0.0,
        ),
        body: BlocProvider(
          create: (context) => authBloc,
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is SignupLoaded) {
                authUser = state.authUser;

                Navigator.pushReplacement(
                  context,
                  CustomRoute(child: const RootWidget()),
                );
              } else if (state is SignupLoading) {
                setState(() {
                  loading = true;
                });
              } else if (state is SignupError) {
                setState(() {
                  loading = false;
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.failure.message),
                  ),
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
                            backgroundColor: Colors.black,
                            radius: 30.0,
                            child: Icon(
                              FontAwesomeIcons.userPlus,
                              size: 50,
                              color: Colors.orange.withOpacity(0.8),
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          Text(
                            'Sign Up',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.orange.withOpacity(0.8)),
                          ),

                          const SizedBox(height: 30.0),

                          //* Full Name TextField
                          CustomTextField(
                            controller: nameTextController,
                            action: TextInputAction.next,
                            autoCorrect: false,
                            obscureText: false,
                            hintText: 'Full Name',
                            fieldName: 'name',
                            onChanged: (text) {},
                          ),

                          //* Email TextField
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
                            onChanged: (text) {},
                          ),

                          //* Vertical Spacer
                          const SizedBox(height: 30.0),

                          //!Signup Button
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
                                      authBloc.add(SignupEvent(
                                        email: emailTextController.text,
                                        password: passwordController.text,
                                        name: nameTextController.text,
                                        phone: phoneTextController.text,
                                        interest: interest,
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
                                    'Sign Up',
                                    style: TextStyle(fontSize: 16.0),
                                  ),
                          ),

                          //* Vertical Spacer
                          const SizedBox(height: 30.0),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account?'),

                              //* Horizontal Spacer
                              const SizedBox(width: 10.0),
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                    context,
                                    CustomRoute(
                                      child: const LoginPage(),
                                    ),
                                  );
                                },
                                child: const Text(
                                  'Sign In',
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
