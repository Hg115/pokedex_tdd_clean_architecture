import 'package:dartz/dartz.dart';

import '../error/failures.dart';

class InputConverter {
  Either<Failure, String> emptySting(String str) {
    return str.isEmpty ? Left(InvalidInputFailure()) : Right(str);
  }
}

class InvalidInputFailure extends Failure {
  @override
  List<Object> get props => [];
}
