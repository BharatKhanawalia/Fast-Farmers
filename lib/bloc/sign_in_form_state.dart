part of 'sign_in_form_bloc.dart';

class SignInFormState extends Equatable {
  const SignInFormState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.isValidEmail = false,
    this.isValidPassword = false,
  });

  final Email email;
  final Password password;
  final FormzStatus status;
  final bool isValidEmail;
  final bool isValidPassword;

  SignInFormState copyWith({
    Email? email,
    Password? password,
    FormzStatus? status,
    bool? isValidEmail,
    bool? isValidPassword,
  }) {
    return SignInFormState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      isValidEmail: isValidEmail ?? this.isValidEmail,
      isValidPassword: isValidPassword ?? this.isValidPassword,
    );
  }

  @override
  List<Object> get props =>
      [email, password, status, isValidEmail, isValidPassword];
}
