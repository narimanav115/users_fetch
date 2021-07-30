import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:github_parse/core/error/failure.dart';
import 'package:github_parse/core/usecases/usecase.dart';
import 'package:github_parse/feature/domain/entities/user_entity.dart';
import 'package:github_parse/feature/domain/repositories/user_repository.dart';
import 'package:meta/meta.dart';

class GetUser extends UseCase<UserEntity, PageSingleUserParams>{
  final UserRepository characterRepository;

  GetUser(this.characterRepository);

  Future<Either<Failure, UserEntity>> call(PageSingleUserParams params) async{
    return characterRepository.getUser(params.page);
  }

}

class PageSingleUserParams extends Equatable{
  final int? page;

  PageSingleUserParams({@required this.page});

  @override
  List<Object?> get props => [page];

}