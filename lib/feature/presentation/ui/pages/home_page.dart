import 'package:flutter/material.dart';
import 'package:github_parse/common/app_colors.dart';
import 'package:github_parse/feature/presentation/ui/widgets/user_list_widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GitHUB'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.search),
            color: AppColors.greyColor,
          ),
        ],
      ),
      body: CharactersList(),
    );
  }
}
