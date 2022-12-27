import 'package:docki/core/cache_manager/cache_manager.dart';
import 'package:docki/features/auth/app/pages/login_page.dart';
import 'package:docki/root.dart';
import 'package:firedart/firedart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  FirebaseAuth.initialize(
    'AIzaSyDnzu1cY_CZmpUzO2cXIqJccypDmz2PFFg',
    VolatileStore(),
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Docki',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.black,
        backgroundColor: Colors.black,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.black,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          elevation: 0.0,
          centerTitle: false,
        ),
        textSelectionTheme: const TextSelectionThemeData(
          cursorColor: Colors.orange,
          selectionHandleColor: Colors.orange,
          selectionColor: Colors.orange,
        ),
      ),
      home: FutureBuilder<dynamic>(
          future: CachManager.instance.getPref('auth_user'),
          builder: (context, snapshot) {
            //At waiting state
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const SizedBox(
                width: 20.0,
                height: 20.0,
                child: CircularProgressIndicator(),
              );
            }

            //On Error
            if (snapshot.hasError) {
              return Material(
                color: Colors.black,
                child: Center(
                  child: Text('${snapshot.error}'),
                ),
              );
            }

            //Has Data
            if (snapshot.hasData) {
              return const RootWidget();
            } else {
              return const LoginPage();
            }
          }),
    );
  }
}
