import 'package:equatable/equatable.dart';
import 'package:github_parse/feature/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

abstract class UserListState extends Equatable{
  const UserListState();

  @override
  List<Object> get props => [];
}

class UserListEmpty extends UserListState{
  @override
  List<Object> get props => [];
}
class UserListLoading extends UserListState{
  final List<UserEntity> oldCharactersList;
  final bool? isFirstFetch;

  UserListLoading(this.oldCharactersList, {this.isFirstFetch=false});

  @override
  List<Object> get props => [oldCharactersList,];
}

class UserListLoaded extends UserListState{
  final List<UserEntity> characterList;

  UserListLoaded(this.characterList);

  @override
  List<Object> get props => [characterList];
}
class UserListError extends UserListState{
  final String? message;

  UserListError({@required this.message});

  @override
List<Object> get props => [message!];

}