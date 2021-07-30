import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:github_parse/common/app_colors.dart';
import 'package:github_parse/feature/domain/usecases/user_fetch.dart';
import 'package:github_parse/feature/presentation/bloc/fetch_cubit/user_list_cubit.dart';
import 'package:github_parse/feature/presentation/bloc/fetch_user_cubit/user_fetch_cubit.dart';
import 'package:github_parse/feature/presentation/ui/pages/home_page.dart';
import 'service_locator.dart';
import 'package:github_parse/service_locator.dart' as di;
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserListCubit>(
            create: (context)=>sl<UserListCubit>()..loadUsers()
        ),
        BlocProvider<UserCubit>(
            create: (context)=>sl<UserCubit>()
        ),
      ],
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          backgroundColor: AppColors.mainBackground,
          scaffoldBackgroundColor: AppColors.mainBackground,
        ),
        home: HomePage(),
      ),
    );
  }
}

