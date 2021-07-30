import 'dart:convert';
import 'package:github_parse/core/error/exception.dart';
import 'package:github_parse/feature/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meta/meta.dart';
abstract class UserLocalDataSource{

  //Вытаскивает из кэша последних персонажей когда нет подключения к интернету
  //Кидает [CacheException]

  Future<List<UserModel>> getLastUsersFromCache();

  Future<void> usersToCache(List<UserModel> users);
}

class UserLocalDataSourceImplementation implements UserLocalDataSource{
  final SharedPreferences? sharedPreferences;

  UserLocalDataSourceImplementation({@required this.sharedPreferences});

  @override
  Future<void> usersToCache(List<UserModel> characters) async{
    final List<String> usersJson = characters.map((user) => jsonEncode(user.toJson())).toList();
    
    sharedPreferences!.setStringList('CACHED_USERS', usersJson);
    return Future.value(usersJson);
  }

  @override
  Future<List<UserModel>> getLastUsersFromCache() async{
    final usersJson = sharedPreferences!.getStringList('CACHED_USERS');
    if(usersJson!.isNotEmpty){
      return Future.value(usersJson.map((user) => UserModel.fromJson(jsonDecode(user))).toList());
    }else{
      throw CacheException();
    }
  }
  
}