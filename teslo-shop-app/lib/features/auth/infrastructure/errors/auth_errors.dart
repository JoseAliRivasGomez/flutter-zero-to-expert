class ConnectionTimeout implements Exception {}

class InvalidToken implements Exception {}

class WrongCredentials implements Exception {}

class EmailAlreadyExists implements Exception {}

class CustomError implements Exception {
  final String message;
  //final bool logRequired;
  // final int errorCode;

  //CustomError(this.message, [this.logRequired = false]);
  CustomError(this.message);
}
