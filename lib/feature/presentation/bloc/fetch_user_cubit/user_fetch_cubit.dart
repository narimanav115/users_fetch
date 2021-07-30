import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_parse/core/error/failure.dart';
import 'package:github_parse/feature/domain/entities/user_entity.dart';
import 'package:github_parse/feature/domain/usecases/get_user.dart';
import 'package:github_parse/feature/domain/usecases/user_fetch.dart';
import 'package:github_parse/feature/presentation/bloc/fetch_cubit/user_list_state.dart';
import 'package:github_parse/feature/presentation/bloc/fetch_user_cubit/user_fetch_state.dart';
import 'package:meta/meta.dart';

class UserCubit extends Cubit<UserFetchState>{
  final GetUser? userFetch;

  UserCubit({@required this.userFetch}) : super(UserEmpty());

  void loadUser(int id) async{
    if(state is UserLoading) return;
    final currentState = state;

    var user;
    final failureOrUser = await userFetch!(PageSingleUserParams(page: id));

    failureOrUser.fold((failure) => UserError(message: _mapFailureToMessage(failure)), (user){
      user = user;
      emit(UserLoaded(user));
    });
    if(currentState is UserLoaded){
      user = currentState.character;
    }


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