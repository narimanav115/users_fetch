import 'dart:convert';
import 'package:github_parse/core/error/exception.dart';
import 'package:github_parse/feature/data/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';
String token = "access_token=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";

abstract class UserRemoteDataSource {
  Future<List<UserModel>> getAllUsers(int? page);
  Future<UserModel> getUser(int? id);
}

class UserRemoteDataSourceImplementation implements UserRemoteDataSource {
  final http.Client? client;

  UserRemoteDataSourceImplementation({@required this.client});
  @override
  Future<List<UserModel>> getAllUsers(int? page) async {
    return _getUsersFromJson(
        'https://api.github.com/users?per_page=10&since=$page&$token');
  }
  @override
  Future<UserModel> getUser(int? id){
    return _getUserFromJson(
        'https://api.github.com/user/$id?$token'
    );
  }
  Future<List<UserModel>> _getUsersFromJson(String url) async {
    final response = await client!
        .get(Uri.parse(url), headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/vnd.github.v3+json'
        });
    if (response.statusCode == 200) {
      return (jsonDecode(response.body) as List)
          .map((user) => UserModel.fromJson(user))
          .toList();
    } else {
      throw ServerException();
    }
  }
  Future<UserModel> _getUserFromJson(String url) async {
    final response = await client!
        .get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/vnd.github.v3+json'
    });
    if (response.statusCode == 200) {
      return UserModel.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }
}
