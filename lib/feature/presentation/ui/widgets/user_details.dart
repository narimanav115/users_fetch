import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_parse/common/app_colors.dart';
import 'package:github_parse/core/widgets/indicators.dart';
import 'package:github_parse/feature/domain/entities/user_entity.dart';
import 'package:github_parse/feature/presentation/bloc/fetch_user_cubit/user_fetch_cubit.dart';
import 'package:github_parse/feature/presentation/bloc/fetch_user_cubit/user_fetch_state.dart';

class UserDetails extends StatelessWidget {
  final UserEntity? user;

  UserDetails({this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${user!.login}'),
      ),
      body: UserDetailsWidget(userModel: user),
    );
  }
}

class UserDetailsWidget extends StatelessWidget {
  const UserDetailsWidget({
    Key? key,
    required this.userModel,
  }) : super(key: key);

  final UserEntity? userModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserFetchState>(
        builder: (context, state) {
          var user;
          context.read<UserCubit>().loadUser(userModel!.id!);
          if (state is UserLoading) {
            return loadingIndicator();
          } else if (state is UserLoaded) {
            user = state.character;
          } else if (state is UserError) {
            return Center(
              child: Text(
                '${state.message}',
                style: AppColors.userNameTextStyle,
              ),
            );
          }
          return UserPage(
            user: user,
          );
        }
    );
  }
}
class UserPage extends StatelessWidget {
  final UserEntity? user;

  const UserPage({Key? key, this.user}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return
     user!=null? DecoratedBox(
        decoration: AppColors.userBoxDecoration,
        child: SizedBox(
          width: 400,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 30),
                child: DecoratedBox(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage('${user!.image}'),
                      ),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.teal, width: 5)),
                  child: SizedBox(
                    height: 250,
                    width: 250,
                  ),
                ),
              ),
              Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'id: ${user!.id}',
                          style: AppColors.userIdTextStyleBig,
                        ),
                        Text(
                          '@${user!.login}',
                          style: AppColors.userNameTextStyleBig,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Text(
                                        '${user!.followers}',
                                        style: AppColors.userNameTextStyleBig,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Text(
                                        'Followers',
                                        style: AppColors.userIdTextStyle,
                                      )),

                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(top: 20),

                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Text(
                                        '${user!.following}',
                                        style: AppColors.userNameTextStyleBig,
                                      )),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      child: Text(
                                        'Following',
                                        style: AppColors.userIdTextStyle,
                                      )),
                                ],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20,),
                        if(user!.email!=null)Text(
                          'Email: ${user!.email}',
                          style: AppColors.userIdTextStyle,
                        ),
                        if(user!.organization!=null)Text(
                          'Organization: ${user!.organization}',
                          style: AppColors.userIdTextStyle,
                        ),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      )
     : loadingIndicator();
  }
}
