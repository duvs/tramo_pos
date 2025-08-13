import 'package:dartz/dartz.dart';
import 'package:tramo_pos/core/error/failure.dart';

typedef Result<T> = Either<Failure, T>;
