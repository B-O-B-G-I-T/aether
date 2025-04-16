abstract class Failure {
  final String errorMessage;
  const Failure({required this.errorMessage});
}

class ServerFailure extends Failure {
  ServerFailure({required super.errorMessage});
}

class CacheFailure extends Failure {
  CacheFailure({required super.errorMessage});
}

class BadRequestFailure extends Failure {
  BadRequestFailure({required super.errorMessage});
}

class NoInternetConnectionFailure extends Failure {
  NoInternetConnectionFailure({required super.errorMessage});
}


class ForgotPasswordFailure extends Failure {
  ForgotPasswordFailure({required super.errorMessage, required message}); // <- ici paramètre positionnel
}
