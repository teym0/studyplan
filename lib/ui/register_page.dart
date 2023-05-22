import 'package:flutter/material.dart';
import 'package:leadstudy/component/constants.dart';
import 'package:leadstudy/service/account_service.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _accountViewModel = AccountService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ユーザー登録"),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 20),
        children: [
          const Text("サインインに使用するメールアドレスを入力してください"),
          const SizedBox(
            height: 10,
          ),
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
                final String? loginResult = await _accountViewModel.signUp(
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
              child: const Text("ユーザー登録")),
        ],
      ),
    );
  }
}
