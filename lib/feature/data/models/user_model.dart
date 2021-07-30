import 'dart:convert';

import 'package:github_parse/feature/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

class UserModel extends UserEntity {
  UserModel(
      {@required id,
      @required login,
      @required email,
      @required organization,
      @required following,
      @required followers,
      @required origin,
      @required image,
      })
      : super(
            id: id,
            login: login,
            email: email,
            organization: organization,
            following: following,
            followers: followers,
            image: image,
          
  );

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        id: json['id'],
        login: json['login'],
        email: json['status'],
        organization: json['company'],
        following: json['following'].toString(),
        followers: json['followers'].toString(),
        image: json['avatar_url'],
    );
  }
  Map<String, dynamic> toJson(){
    return{
      'id': id,
      'login': login,
      'email': email,
      'organization': organization,
      'image': image,
      'following': following,
      'followers': followers,


    };
  }
}


