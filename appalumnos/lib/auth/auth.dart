import 'package:flutter/material.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../controlles/authenticator.dart';
import '../controlles/biometric_helper.dart';
import '../views/index.dart';

class login extends StatefulWidget {
  login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _LoginPageState();
}

class _LoginPageState extends State<login> {
  final username = TextEditingController();
  final password = TextEditingController();

  String use = "";
  String pass = "";

  bool _loading = false;

  //metdodos huella
  bool showBiometric = false;
  bool isAuthenticated = false;
  @override
  void initState() {
    isBiometricsAvailable();
    super.initState();
  }

  isBiometricsAvailable() async {
    showBiometric = await BiometricHelper().hasEnrolledBiometrics();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    //INICIALIZACION DE FIREBASE
    Firebase.initializeApp();
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color.fromARGB(255, 9, 68, 78),
                  Colors.cyan[800]!,
                ],
              ),
            ),
            child: Image.asset('assets/images/descarga.png'),
          ),
          Transform.translate(
              offset: Offset(0, -40),
              child: Center(
                child: SingleChildScrollView(
                  child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    margin: const EdgeInsets.only(
                        left: 20, right: 20, top: 260, bottom: 20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35, vertical: 20),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          TextField(
                            controller: username,
                            decoration: InputDecoration(labelText: "Usuario:"),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          TextField(
                            controller: password,
                            decoration:
                                InputDecoration(labelText: "Contraseña:"),
                            obscureText: true,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          RaisedButton(
                            color: Color.fromARGB(255, 2, 18, 53),
                            padding: const EdgeInsets.symmetric(vertical: 15),
                            textColor: Colors.white,
                            onPressed: () {},
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("Iniciar Sesión"),
                                if (_loading == true)
                                  Container(
                                    height: 20,
                                    width: 20,
                                    margin: const EdgeInsets.only(left: 20),
                                    child: CircularProgressIndicator(),
                                  ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text("¿No estas registrado?"),
                              FlatButton(
                                textColor: Theme.of(context).primaryColor,
                                child: Text("Registrarse"),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Divider(),
                              SignInButton(
                                Buttons.google,
                                onPressed: () async {
                                  User? user = await Autheticador.iniciarSesion(
                                      context: context);
                                  print(user?.displayName); Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Index(),
                                        ));

                                  return Index();
                                },
                              ),
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              if (showBiometric)
                                ElevatedButton(
                                  child: const Text(
                                    'Biometric Login',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  onPressed: () async {
                                    isAuthenticated =
                                        await BiometricHelper().authenticate();
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Index(),
                                        ));

                                    setState(() => Index());
                                  },
                                ),
                              if (isAuthenticated)
                                const Padding(
                                  padding: EdgeInsets.only(top: 50.0),
                                  child: Text(
                                    'Well done!, Authenticated',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 25),
                                  ),
                                ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
