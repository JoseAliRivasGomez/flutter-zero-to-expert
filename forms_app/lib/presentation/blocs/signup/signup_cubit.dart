import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:forms_app/infrastructure/inputs/inputs.dart';
import 'package:formz/formz.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupFormState> {
  SignupCubit() : super(const SignupFormState());

  void onSubmit() {
    emit(
      state.copyWith(
        formStatus: FormStatus.validating,
        username: Username.dirty( state.username.value ),
        password: Password.dirty( state.password.value ),
        email: Email.dirty( state.email.value ),
        neverPosted: false,
        isValid: Formz.validate([
          state.username, 
          state.password,
          state.email
        ])
      )
    );

    //print('Cubit Submit: $state');
  }


  void usernameChanged( String value ) {
    final username = Username.dirty(value);
    emit(
      state.copyWith(
        username: username,
        isValid: Formz.validate([ username, state.password, state.email ])
      )
    );
  }

  void emailChanged( String value ) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([ email, state.password, state.username ])
      )
    );
  }

  void passwordChanged( String value ) {
    final password = Password.dirty(value);
    emit(
      state.copyWith(
        password: password,
        isValid: Formz.validate([ password, state.username, state.email ])
      )
    );
  }


}
