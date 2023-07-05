import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/service/account_service.dart';

import '../view_model/auth_view_model.dart';

class LoginPage extends ConsumerStatefulWidget {
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _accountViewModel = AccountService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ログイン"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        children: [
          AutofillGroup(
              child: Column(
            children: [
              TextFormField(
                controller: _emailController,
                autofillHints: const [AutofillHints.username],
                decoration: const InputDecoration(
                  labelText: "メールアドレス",
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                autofillHints: const [AutofillHints.password],
                decoration: const InputDecoration(
                  labelText: "パスワード",
                  border: OutlineInputBorder(),
                ),
              ),
            ],
          )),
          const SizedBox(
            height: 20,
          ),
          FilledButton(
              onPressed: () async {
                final bool authenticated = await ref
                    .read(authProvider.notifier)
                    .login(_emailController.text, _passwordController.text);
                if (!authenticated) {
                  return;
                }
                if (!mounted) {
                  return;
                }
                return;
                final String? loginResult = await _accountViewModel.signIn(
                    _emailController.text, _passwordController.text);
                if (!mounted) return;
                if (loginResult == null) {
                  await Navigator.of(context).pushReplacementNamed('/home');
                } else if (loginResult == "") {
                  context.showErrorSnackBar(message: "何らかのエラーが発生しました。");
                } else {
                  context.showErrorSnackBar(message: loginResult);
                }
              },
              child: const Text("ログイン")),
          TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/register');
              },
              child: const Text("こちらから ユーザー登録")),
        ],
      ),
    );
  }
}
