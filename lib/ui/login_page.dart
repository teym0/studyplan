import 'package:flutter/material.dart';
import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/service/account_service.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
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
          TextFormField(
            controller: _emailController,
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
            decoration: const InputDecoration(
              labelText: "パスワード",
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          FilledButton(
              onPressed: () async {
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
