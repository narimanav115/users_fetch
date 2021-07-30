import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_parse/common/app_colors.dart';
import 'package:github_parse/core/widgets/indicators.dart';
import 'package:github_parse/feature/domain/entities/user_entity.dart';
import 'package:github_parse/feature/presentation/bloc/fetch_cubit/user_list_cubit.dart';
import 'package:github_parse/feature/presentation/bloc/fetch_cubit/user_list_state.dart';
import 'package:github_parse/feature/presentation/ui/widgets/user_list_tile.dart';

class CharactersList extends StatelessWidget {
  final scrollController = ScrollController();

  void setupScrollController(BuildContext context) {
    scrollController.addListener(() {
      if (scrollController.position.atEdge) {
        if (scrollController.position.pixels != 0) {
          context.read<UserListCubit>().loadUsers();
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    setupScrollController(context);
    return BlocBuilder<UserListCubit, UserListState>(
      builder: (context, state) {
        List<UserEntity> characters = [];
        bool isLoading = false;
        if (state is UserListLoading && state.isFirstFetch!) {
          return loadingIndicator();
        } else if (state is UserListLoading) {
          characters = state.oldCharactersList;
          isLoading = true;
        } else if (state is UserListLoaded) {
          characters = state.characterList;
        } else if (state is UserListError) {
          return Center(
            child: Text(
              '${state.message}',
              style: AppColors.userNameTextStyle,
            ),
          );
        }
        return ListView.separated(
          controller: scrollController,
          itemBuilder: (context, index) {
            if (index < characters.length) {
              return UserListTile(
                user: characters[index],
              );
            }
            Timer(Duration(milliseconds: 30),(){
              scrollController.jumpTo(scrollController.position.maxScrollExtent);
            });
            return loadingIndicator();
          },
          separatorBuilder: (context, index) => Divider(
            color: AppColors.greyColor,
          ),
          itemCount: characters.length + (isLoading ? 1 : 0),
        );
      },
    );
  }
}

