import 'package:equatable/equatable.dart';
import 'package:github_parse/feature/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

abstract class UserFetchState extends Equatable{
  const UserFetchState();

  @override
  List<Object> get props => [];
}

class UserEmpty extends UserFetchState{
  @override
  List<Object> get props => [];
}
class UserLoading extends UserFetchState{

  UserLoading();

  @override
  List<Object> get props => [];
}

class UserLoaded extends UserFetchState{
  final UserEntity character;
  UserLoaded(this.character);

  @override
  List<Object> get props => [character];
}
class UserError extends UserFetchState{
  final String? message;

  UserError({@required this.message});

  @override
List<Object> get props => [message!];

}