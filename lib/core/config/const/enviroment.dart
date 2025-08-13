import 'package:flutter_dotenv/flutter_dotenv.dart';

class Enviroment {
  Enviroment._();
  static String? supabaseUrl = dotenv.env['SUPABASE_URL'] ?? 'There is no supabase URL defined';
  static String? supabaseAnonKey =
      dotenv.env['SUPABASE_ANON_KEY'] ?? 'There is no supabase anon key defined';
}
