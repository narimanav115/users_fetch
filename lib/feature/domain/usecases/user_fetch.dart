import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:github_parse/core/error/failure.dart';
import 'package:github_parse/core/usecases/usecase.dart';
import 'package:github_parse/feature/domain/entities/user_entity.dart';
import 'package:github_parse/feature/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class UserFetch extends UseCase<List<UserEntity>, PageUserParams>{
  final UserRepository characterRepository;

  UserFetch(this.characterRepository);

  Future<Either<Failure, List<UserEntity>>> call(PageUserParams params) async{
    return characterRepository.getAllUsers(params.page);
  }

}

class PageUserParams extends Equatable{
  final int? page;

  PageUserParams({@required this.page});

  @override
  List<Object?> get props => [page];

}