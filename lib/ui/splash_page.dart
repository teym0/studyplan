import 'package:flutter/material.dart';
import 'package:leadstudy/service/account_service.dart';
import 'package:leadstudy/ui/login_page.dart';

import 'home_page.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});
  @override
  Widget build(BuildContext context) {
    final accountViewModel = AccountService();
    return Scaffold(
      body: FutureBuilder(
        future: accountViewModel.futureLoginCheck(),
        builder: ((context, snapshot) {
          if (snapshot.hasData) {
            if (snapshot.data) {
              return HomePage();
            } else {
              return const LoginPage();
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        }),
      ),
    );
  }
}
