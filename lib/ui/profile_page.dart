import 'package:flutter/material.dart';
import 'package:leadstudy/component/constants.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("プロフィール"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(supabase.auth.currentUser!.email.toString()),
            ElevatedButton(
              onPressed: () {
                supabase.auth.signOut();
                Navigator.of(context).pushReplacementNamed('/');
              },
              child: const Text("ログアウト"),
            ),
          ],
        ),
      ),
    );
  }
}
