import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/ui/login_page.dart';

import '../view_model/auth_view_model.dart';
import 'home_page.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    return Scaffold(
      body: auth.when(
        data: (data) {
          if (data == null) {
            return const LoginPage();
          } else {
            return HomePage();
          }
        },
        error: (error, stackTrace) => const Text("Error"),
        loading: () => const CircularProgressIndicator(),
      ),
    );
  }
}
