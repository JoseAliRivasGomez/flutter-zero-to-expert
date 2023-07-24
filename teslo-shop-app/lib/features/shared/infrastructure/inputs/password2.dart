import 'package:formz/formz.dart';
import 'package:teslo_shop/features/shared/shared.dart';

// Define input validation errors
enum Password2Error { empty, length, format, match }

// Extend FormzInput and provide the input type and error type.
class Password2 extends FormzInput<String, Password2Error> {
  static final RegExp passwordRegExp = RegExp(
    r'(?:(?=.*\d)|(?=.*\W+))(?![.\n])(?=.*[A-Z])(?=.*[a-z]).*$',
  );

  final Password password1;

  // Call super.pure to represent an unmodified form input.
  const Password2.pure()
      : password1 = const Password.pure(),
        super.pure('');

  // Call super.dirty to represent a modified form input.
  const Password2.dirty(String value, {required this.password1})
      : super.dirty(value);

  String? get errorMessage {
    if (isValid || isPure) return null;

    if (displayError == Password2Error.empty) return 'El campo es requerido';
    if (displayError == Password2Error.length) return 'Mínimo 8 caracteres';
    if (displayError == Password2Error.format) return 'Mayúsculas, minúsculas y números';
    if (displayError == Password2Error.match) return 'Las 2 contraseñas deben ser iguales';

    return null;
  }

  // Override validator to handle validating a given input value.
  @override
  Password2Error? validator(String value) {
    if (value.isEmpty || value.trim().isEmpty) return Password2Error.empty;
    if (value.length < 8) return Password2Error.length;
    if (!passwordRegExp.hasMatch(value)) return Password2Error.format;
    if (value != password1.value) return Password2Error.match;

    return null;
  }
}
