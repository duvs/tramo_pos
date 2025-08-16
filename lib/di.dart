import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tramo_pos/core/config/const/enviroment.dart';
import 'package:tramo_pos/features/auth/data/repository/auth_repository_impl.dart';
import 'package:tramo_pos/features/auth/data/source/auth_supabase_datasource.dart';
import 'package:tramo_pos/features/auth/domain/repository/auth_repository.dart';
import 'package:tramo_pos/features/auth/presentation/authCubit/auth_cubit.dart';
import 'package:tramo_pos/features/auth/presentation/signInCubit/sign_in_form_cubit.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await dotenv.load();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path),
  );

  await Supabase.initialize(url: Enviroment.supabaseUrl, anonKey: Enviroment.supabaseAnonKey);

  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);

  // Auth
  // Datasource and repo
  getIt.registerLazySingleton(() => AuthSupabaseDatasource(getIt<SupabaseClient>()));
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(getIt<AuthSupabaseDatasource>()),
  );

  // Bloc
  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepository>()));
  getIt.registerFactory<SignInFormCubit>(() => SignInFormCubit(getIt<AuthRepository>()));
}
