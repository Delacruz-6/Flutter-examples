import 'package:flutter/material.dart';
import 'package:flutter_redbull_2/style.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Ejercicio Redbull',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Redbull'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Stack(children: <Widget>[
              Image.asset('assets/images/logo.png',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height),
              Positioned(
                  top: 80,
                  right: 20,
                  child: RichText(
                      text: const TextSpan(
                          text: 'skip',
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold)))),
              Padding(
                padding: const EdgeInsets.only(top: 200),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        "assets/images/logoRedbull.png",
                        width: 200,
                      ),
                      Text(
                        "Sign in to get the most of",
                        style: DamStyle.textTitleCustom(
                            DamStyle.primaryColor, DamStyle.textSizeBig),
                      ),
                      Text(
                        "Red Bull",
                        style: DamStyle.textTitleCustom(
                            DamStyle.primaryColor, DamStyle.textSizeBig),
                      ),
                      Text(
                        "Create an account to save favorites and ",
                        style: DamStyle.textTitleCustom(
                            DamStyle.primaryColor, DamStyle.textSizeSmall),
                      ),
                      Text(
                        "download videos to watch anytime you want.",
                        style: DamStyle.textTitleCustom(
                            DamStyle.primaryColor, DamStyle.textSizeSmall),
                      ),
                      SizedBox(
                        height: 40,
                        child: Center(
                            child: SignInButton(
                          Buttons.Google,
                          text: "Continue with Google",
                          onPressed: () {},
                        )),
                      ),
                      SizedBox(
                        height: 40,
                        child: Center(
                            child: SignInButton(
                          Buttons.Facebook,
                          text: "Continue with Facebook",
                          onPressed: () {},
                        )),
                      ),
                      SizedBox(
                          height: 40,
                          child: Center(
                              child: SignInButton(
                            Buttons.Email,
                            text: "Continue with Email",
                            onPressed: () {},
                          )))
                    ]),
              ),
            ])
          ],
        ),
      ),
    );
  }
}
