import 'package:leadstudy/component/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AccountService {
  Future<String?> signIn(String email, String password) async {
    try {
      await supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );
      return null;
    } on AuthException catch (error) {
      return error.message;
    } catch (error) {
      return "";
    }
  }

  Future<String?> signUp(String email, String password) async {
    try {
      await supabase.auth.signUp(
        email: email,
        password: password,
      );
      return null;
    } on AuthException catch (error) {
      return error.message;
    } catch (error) {
      return "";
    }
  }

  Future futureLoginCheck() async {
    await Future.delayed(Duration.zero);
    final session = supabase.auth.currentSession;
    return Future.value(session != null);
  }
}
