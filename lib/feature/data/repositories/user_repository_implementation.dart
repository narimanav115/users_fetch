import 'package:dartz/dartz.dart';
import 'package:github_parse/core/error/exception.dart';
import 'package:github_parse/core/error/failure.dart';
import 'package:github_parse/feature/data/datasources/user_local_datasource.dart';
import 'package:github_parse/feature/data/datasources/user_remote_datasource.dart';
import 'package:github_parse/feature/data/models/user_model.dart';
import 'package:github_parse/feature/domain/entities/user_entity.dart';
import 'package:github_parse/feature/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class CharacterRepositoryImplementation implements UserRepository{
  final UserRemoteDataSource? remoteDataSource;
  final UserLocalDataSource? localDataSource;

  CharacterRepositoryImplementation({
    @required this.remoteDataSource,
    @required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<UserEntity>>> getAllUsers(int? page) async{
    return await _getUsersData(remoteDataSource!.getAllUsers(page));
  }
  @override
  Future<Either<Failure, UserEntity>> getUser(int? id) async{
    return await _getUserData(remoteDataSource!.getUser(id));
  }

  Future<Either<Failure, List<UserEntity>>> _getUsersData(Future<List<UserModel>> getCharacters) async{
      try{
        final remoteCharacters = await getCharacters;
        localDataSource!.usersToCache(remoteCharacters);
        return Right(remoteCharacters);
      } on ServerException{
        return Left(ServerFailure());
      }
  }
  Future<Either<Failure, UserEntity>> _getUserData(Future<UserModel> getUser) async{
      try{
        final remoteUser = await getUser;
        return Right(remoteUser);
      } on ServerException{
        return Left(ServerFailure());
      }
  }
}