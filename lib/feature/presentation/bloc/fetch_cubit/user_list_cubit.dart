import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_parse/core/error/failure.dart';
import 'package:github_parse/feature/domain/entities/user_entity.dart';
import 'package:github_parse/feature/domain/usecases/user_fetch.dart';
import 'package:github_parse/feature/presentation/bloc/fetch_cubit/user_list_state.dart';
import 'package:meta/meta.dart';

class UserListCubit extends Cubit<UserListState>{
  final UserFetch? userFetch;

  UserListCubit({@required this.userFetch}) : super(UserListEmpty());

  int page = 1;

  void loadUsers() async{
    if(state is UserListLoading) return;
    final currentState = state;

    var oldUsers = <UserEntity>[];

    if(currentState is UserListLoaded){
      oldUsers = currentState.characterList;
    }
    emit(UserListLoading(oldUsers, isFirstFetch: page == 1));

    final failureOrUser = await userFetch!(PageUserParams(page: page));

    failureOrUser.fold((failure) => UserListError(message: _mapFailureToMessage(failure)), (users){
      page = users.last.id!;
      final usersTemp = (state as UserListLoading).oldCharactersList;
      usersTemp.addAll(users);

      emit(UserListLoaded(usersTemp));
    });

  }
  _mapFailureToMessage(Failure failure){
    switch (failure.runtimeType){
      case ServerFailure:
        return 'Server Failure';
      case CacheFailure:
        return 'Cache Failure';
      default:
        return 'Unexpected Error';
    }
  }
}