import 'package:flutter/material.dart';
import 'package:github_parse/common/app_colors.dart';
import 'package:github_parse/feature/domain/entities/user_entity.dart';
import 'package:github_parse/feature/presentation/ui/widgets/user_details.dart';

class UserListTile extends StatelessWidget {
  final UserEntity? user;

  UserListTile({this.user});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>UserDetails(user: user,)));
      },
      child: DecoratedBox(
        decoration: AppColors.userBoxDecoration,
        child: Row(
          children: [
            DecoratedBox(
              decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage('${user!.image}'),
                  )
              ),
              child: SizedBox(
                height: 160,
                width: 160,
              ),
            ),
            Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('@${user!.login}', style: AppColors.userNameTextStyle,),
                      Text('id: ${user!.id}', style: AppColors.userIdTextStyle,),
                    ],
                  ),
                )
            )
          ],
        ),
      ),
    );
  }
}
