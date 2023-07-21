part of 'signup_cubit.dart';

enum FormStatus { invalid, valid, validating, posting }

class SignupFormState extends Equatable {
  final FormStatus formStatus;
  final bool isValid;
  final bool neverPosted;
  final Username username;
  final Email email;
  final Password password;

  const SignupFormState({
    this.formStatus = FormStatus.invalid,
    this.isValid = false,
    this.neverPosted = true,
    this.username = const Username.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
  });

  SignupFormState copyWith({
    FormStatus? formStatus,
    bool? isValid,
    bool? neverPosted,
    Username? username,
    Email? email,
    Password? password,
  }) =>
      SignupFormState(
        formStatus: formStatus ?? this.formStatus,
        isValid: isValid ?? this.isValid,
        neverPosted: neverPosted ?? this.neverPosted,
        username: username ?? this.username,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  @override
  List<Object> get props => [formStatus, neverPosted, isValid, username, email, password];
}
