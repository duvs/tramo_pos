import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:tramo_pos/core/config/const/enviroment.dart';

final getIt = GetIt.instance;

Future<void> initDependencies() async {
  await dotenv.load();

  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: HydratedStorageDirectory((await getApplicationDocumentsDirectory()).path),
  );

  await Supabase.initialize(url: Enviroment.supabaseUrl, anonKey: Enviroment.supabaseAnonKey);

  getIt.registerLazySingleton<SupabaseClient>(() => Supabase.instance.client);
}
