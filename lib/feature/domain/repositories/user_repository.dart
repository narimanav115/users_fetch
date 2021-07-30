import 'package:dartz/dartz.dart';
import 'package:github_parse/core/error/failure.dart';
import 'package:github_parse/feature/domain/entities/user_entity.dart';

abstract class UserRepository{
  Future<Either<Failure, List<UserEntity>>> getAllUsers(int? page);
  Future<Either<Failure, UserEntity>> getUser(int? id);


}