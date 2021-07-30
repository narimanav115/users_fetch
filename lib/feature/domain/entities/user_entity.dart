import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class UserEntity extends Equatable {
  final int? id;
  final String? login;
  final String? email;
  final String? organization;
  final String? following;
  final String? followers;
  final String? image;

  UserEntity({
      @required this.id,
      @required this.login,
      @required this.email,
      @required this.organization,
      @required this.following,
      @required this.followers,
      @required this.image,
      });

  @override
  List<Object?> get props => [
        id,
        login,
        email,
        organization,
        following,
        followers,
        image,
      ];
}
