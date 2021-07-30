import 'package:get_it/get_it.dart';
import 'package:github_parse/feature/data/datasources/user_remote_datasource.dart';
import 'package:github_parse/feature/data/datasources/user_local_datasource.dart';
import 'package:github_parse/feature/data/repositories/user_repository_implementation.dart';
import 'package:github_parse/feature/domain/repositories/user_repository.dart';
import 'package:github_parse/feature/domain/usecases/get_user.dart';
import 'package:github_parse/feature/domain/usecases/user_fetch.dart';
import 'package:github_parse/feature/presentation/bloc/fetch_cubit/user_list_cubit.dart';
import 'package:github_parse/feature/presentation/bloc/fetch_user_cubit/user_fetch_cubit.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async{
  // BloC/ Cubit
  sl.registerFactory(
          () => UserListCubit(userFetch: sl()),
  );
  sl.registerFactory(
        () => UserCubit(userFetch: sl()),
  );

  // UseCases
  sl.registerLazySingleton(
          () => UserFetch(sl()),
  );
  sl.registerLazySingleton(
        () => GetUser(sl()),
  );
  // Repository
  sl.registerLazySingleton<UserRepository>(
        () => CharacterRepositoryImplementation(
            localDataSource: sl(),
            remoteDataSource: sl(),
        ),
  );

  sl.registerLazySingleton<UserRemoteDataSource>(
        () => UserRemoteDataSourceImplementation(
          client: http.Client(),
        ),
  );

  sl.registerLazySingleton<UserLocalDataSource>(
        () => UserLocalDataSourceImplementation(
              sharedPreferences: sl(),
        ),
  );
  // Core

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(()  => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());

}
