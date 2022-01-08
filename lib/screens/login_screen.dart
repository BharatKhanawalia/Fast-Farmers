import 'package:fast_farmers/bloc/sign_in_form_bloc.dart';
import 'package:fast_farmers/screens/home_screen.dart';
// import 'package:fast_farmers/screens/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:fast_farmers/widgets/background.dart';
import 'package:fast_farmers/constants.dart';
import 'package:fast_farmers/widgets/rounded_input_field.dart';
import 'package:fast_farmers/widgets/rounded_password_field.dart';
import 'package:fast_farmers/widgets/rounded_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:formz/formz.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final _formKey = GlobalKey<FormState>();
  final _emailFocusNode = FocusNode();
  final _passwordFocusNode = FocusNode();
  // String _email = '';
  // String _password = '';
  // var _isLoading = false;
  // void _trySubmit() {
  //   final isValid = _formKey.currentState!.validate();
  //   FocusScope.of(context).unfocus();
  //   if (isValid) {
  //     _formKey.currentState!.save();
  //     _login();
  //   }
  // }

  // void _login() {
  //   if (_email == 'tanmay@fastfarmers.in' && _password == 'tanmay@321') {
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => HomeScreen(
  //                   farmer: true,
  //                   loggedIn: true,
  //                   email: 'tanmay@fastfarmers.in',
  //                 )),
  //         (route) => false);
  //   } else if (_email == 'naveen@gmail.com' && _password == 'naveen@321') {
  //     Navigator.pushAndRemoveUntil(
  //         context,
  //         MaterialPageRoute(
  //             builder: (context) => HomeScreen(
  //                   farmer: false,
  //                   loggedIn: true,
  //                   email: 'naveen@gmail.com',
  //                 )),
  //         (route) => false);
  //   } else {
  //     ScaffoldMessenger.of(context)
  //         .showSnackBar(SnackBar(content: const Text('Wrong Password')));
  //   }
  // }
  void initState() {
    super.initState();
    _emailFocusNode.addListener(() {
      if (!_emailFocusNode.hasFocus) {
        context.read<SignInFormBloc>().add(EmailUnfocused());
        FocusScope.of(context).requestFocus(_passwordFocusNode);
      }
    });
    _passwordFocusNode.addListener(() {
      if (!_passwordFocusNode.hasFocus) {
        context.read<SignInFormBloc>().add(PasswordUnfocused());
      }
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text(loginScreenTitle),
        backgroundColor: kPrimaryColor,
      ),
      body: BlocProvider(
        create: (context) => SignInFormBloc(),
        child: BlocListener<SignInFormBloc, SignInFormState>(
          listener: (context, state) {
            if (state.status.isSubmissionSuccess) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        farmer: true,
                        loggedIn: true,
                        email: 'tanmay@fastfarmers.in',
                      ));
            }
            if (state.status.isSubmissionInProgress) {
              ScaffoldMessenger.of(context)
                ..hideCurrentSnackBar()
                ..showSnackBar(
                  const SnackBar(content: Text('Submitting...')),
                );
            }
          },
          child: Background(
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
                  Column(
                    children: [
                      EmailInput(focusNode: _emailFocusNode),
                      PassInput(focusNode: _passwordFocusNode),
                    ],
                  ),
                  // if (_isLoading) CircularProgressIndicator(),
                  // if (!_isLoading)
                  SubmitButton()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class EmailInput extends StatelessWidget {
  const EmailInput({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInFormBloc, SignInFormState>(
      builder: (context, state) {
        return RoundedInputField(
          initialValue: state.email.value,
          focusNode: focusNode,
          backgroundColor: kPrimaryLightColor,
          borderColor: kPrimaryColor,
          icon: Icon(
            Icons.person,
            color: kPrimaryColor,
          ),
          errorText:
              state.email.invalid ? 'Please enter a valid email address' : null,
          onChanged: (value) {
            context.read<SignInFormBloc>().add(EmailChanged(email: value!));
          },
          hintText: 'Email Address',
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
          // validator: (value) {
          //   if (!RegExp(
          //           r'^(([^<>()[\]\.,;:\s@\"]+(\.[^<>()[\]\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
          //       .hasMatch(value)) {
          //     return 'Please enter a valid email address';
          //   } else if (value.isEmpty || value == null) {
          //     return 'Please enter an email address';
          //   } else if (value != 'tanmay@fastfarmers.in' &&
          //       value != 'naveen@gmail.com') {
          //     return 'No account found for this email address';
          //   }
          //   return null;
          // },
          // onSaved: (value) {
          //   _email = value;
          // },
        );
      },
    );
  }
}

class PassInput extends StatelessWidget {
  const PassInput({Key? key, required this.focusNode}) : super(key: key);
  final FocusNode focusNode;
  //  bool isHidden;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignInFormBloc, SignInFormState>(
      builder: (context, state) {
        return RoundedPasswordField(
          initialValue: state.password.value,
          borderColor: kPrimaryColor,
          backgroundColor: kPrimaryLightColor,
          hintText: 'Password',
          focusNode: focusNode,
          errorText: state.password.invalid
              ? '''Password must be at least 8 characters and contain at least one letter and number'''
              : null,
          obscureText: true,
          onChanged: (value) {
            context
                .read<SignInFormBloc>()
                .add(PasswordChanged(password: value!));
          },
          textInputAction: TextInputAction.done,
          // obscureText: widget.isHidden ? true : false,
          // suffixIcon: IconButton(
          //   splashColor: Colors.transparent,
          //   icon:
          //       widget.isHidden ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
          //   color: kPrimaryColor,
          //   onPressed: () {
          //     setState(() {
          //       widget.isHidden = !widget.isHidden;
          //     });
          //   },
          // ),
          // validator: (value) {
          //   if (value!.isEmpty) {
          //     return 'Please enter a password.';
          //   }
          //   return null;
          // },
          // onSaved: (value) {
          //   _password = value!;
          // },
        );
      },
    );
  }
}

class SubmitButton extends StatelessWidget {
  const SubmitButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return BlocBuilder<SignInFormBloc, SignInFormState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return RoundedButton(
          vertical: 20,
          horizontal: 20,
          width: size.width * 0.8,
          text: "LOGIN",
          textColor: Colors.white,
          press: state.status.isValidated
              ? () => context.read<SignInFormBloc>().add(FormSubmitted())
              : null,
        );
      },
    );
  }
}
