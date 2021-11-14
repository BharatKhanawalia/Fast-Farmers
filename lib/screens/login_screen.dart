import 'package:fast_farmers/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fast_farmers/widgets/background.dart';
import 'package:fast_farmers/constants.dart';
import 'package:fast_farmers/widgets/rounded_input_field.dart';
import 'package:fast_farmers/widgets/rounded_password_field.dart';
import 'package:fast_farmers/widgets/rounded_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  String _email = '';
  String _password = '';
  bool _isHidden = true;
  var _isLoading = false;
  void _trySubmit() {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
      _login();
    }
  }

  void _login() {
    if (_email == 'tanmay@fastfarmers.in' && _password == 'tanmay@321') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    farmer: true,
                    loggedIn: true,
                    email: 'tanmay@fastfarmers.in',
                  )),
          (route) => false);
    } else if (_email == 'naveen@gmail.com' && _password == 'naveen@321') {
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
              builder: (context) => HomeScreen(
                    farmer: false,
                    loggedIn: true,
                    email: 'naveen@gmail.com',
                  )),
          (route) => false);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: const Text('Wrong Password')));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(loginScreenTitle),
      ),
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                "LOGIN",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    RoundedInputField(
                      backgroundColor: kPrimaryLightColor,
                      borderColor: kPrimaryColor,
                      icon: Icon(
                        Icons.person,
                        color: kPrimaryColor,
                      ),
                      hintText: 'Email Address',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (!RegExp(
                                r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
                            .hasMatch(value)) {
                          return 'Please enter a valid email address';
                        } else if (value.isEmpty || value == null) {
                          return 'Please enter an email address';
                        } else if (value != 'tanmay@fastfarmers.in' &&
                            value != 'naveen@gmail.com') {
                          return 'No account found for this email address';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _email = value;
                      },
                    ),
                    RoundedPasswordField(
                      borderColor: kPrimaryColor,
                      backgroundColor: kPrimaryLightColor,
                      hintText: 'Password',
                      obscureText: _isHidden ? true : false,
                      suffixIcon: IconButton(
                        splashColor: Colors.transparent,
                        icon: _isHidden
                            ? Icon(Icons.visibility)
                            : Icon(Icons.visibility_off),
                        color: kPrimaryColor,
                        onPressed: () {
                          setState(() {
                            _isHidden = !_isHidden;
                          });
                        },
                      ),
                      validator: (value) {
                        if (value.isEmpty || value == null) {
                          return 'Please enter a password.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _password = value;
                      },
                    ),
                  ],
                ),
              ),
              if (_isLoading) CircularProgressIndicator(),
              if (!_isLoading)
                RoundedButton(
                  vertical: 20,
                  horizontal: 20,
                  width: size.width * 0.8,
                  text: "LOGIN",
                  textColor: Colors.white,
                  press: () {
                    _trySubmit();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
