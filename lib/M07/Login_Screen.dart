import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:M07/Home.dart';
import 'package:M07/M07/AuthFirebase.dart';
import 'package:M07/M07/Home_M07.dart';
import 'package:M07/M07/Provider_M07.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late AuthFirebase auth;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    auth = AuthFirebase();
    auth.getUser().then((value) {
      MaterialPageRoute route;
      if (value != null) {
        route = MaterialPageRoute(
          builder: (context) => HomeM07(
            wid: value.uid,
            email: value.email,
          ),
        );
        Navigator.pushReplacement(context, route);
      }
    }).catchError((err) => print(err));
  }

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<ProviderM07>(context);
    return FlutterLogin(
      onLogin: _loginUser,
      onRecoverPassword: _recoverPassword,
      onSignup: _signUp,
      onSubmitAnimationCompleted: () {
        auth.getUser().then((value) {
          MaterialPageRoute route;

          if (value != null) {
            route = MaterialPageRoute(
              builder: (context) => HomeM07(
                wid: value.uid,
                email: value.email,
              ),
            );
          } else {
            route = MaterialPageRoute(
              builder: (context) => LoginScreen(),
            );
          }
          Navigator.pushReplacement(context, route);
        }).catchError((err) => print(err));
      },
      passwordValidator: (value) {
        if (value != null) {
          if (value.length < 6) {
            return 'Password Must Be 6 Characters';
          }
        }
      },
      loginProviders: [
        LoginProvider(
            callback: _loginGoogle,
            icon: FontAwesomeIcons.google,
            label: 'Google')
      ],
    );
  }

  Future<String?>? _loginUser(LoginData data) {
    return auth.Login(data.name, data.password).then((value) {
      if (value != null) {
        print(value);
        MaterialPageRoute(
          builder: (context) => HomeM07(
            wid: value,
            email: value,
          ),
        );
      } else {
        final snackbar = SnackBar(
          content: Text('Login Failed User Not Found'),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginScreen(),
        ));
      }
    });
  }

  Future<String?>? _recoverPassword(String name) {
    return null;
  }

  Future<String?>? _signUp(SignupData data) {
    return auth.SignUp(data.name!, data.password!).then((value) {
      if (value != null) {
        final snackbar = SnackBar(
          content: Text('Sign Up Successfull'),
          action: SnackBarAction(
            label: 'Ok',
            onPressed: () {},
          ),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackbar);
      }
    });
  }

  Future<String?>? _loginGoogle() async {
    return await auth.googleLogin();
  }
}
