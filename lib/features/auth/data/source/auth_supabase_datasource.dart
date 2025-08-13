import 'package:supabase_flutter/supabase_flutter.dart';

class AuthSupabaseDatasource {
  AuthSupabaseDatasource(this._sb);
  final SupabaseClient _sb;

  Future<void> signIn(String email, String password) async {
    await _sb.auth.signInWithPassword(email: email, password: password);
  }

  Future<void> signOut() => _sb.auth.signOut();

  String? currentUserId() => _sb.auth.currentUser?.id;
}
