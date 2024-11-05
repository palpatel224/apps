import 'package:dartz/dartz.dart';
import 'package:learning/1_domain/entities/advice_entity.dart';
import 'package:learning/1_domain/failures/advice_failure.dart';


abstract class AdviceRepo {
  Future<Either<Failure, AdviceEntity>> getAdviceFromDatasource();
}