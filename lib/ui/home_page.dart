import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/ui/profile_page.dart';
import 'package:leadstudy/view_model/home_view_model.dart';

import 'books_list_page.dart';

class HomePage extends HookConsumerWidget {
  final _views = [const BooksListPage(), const ProfilePage()];

  HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tabType = ref.watch(tabTypeProvider);

    return Scaffold(
      body: _views[tabType.index],
      bottomNavigationBar: NavigationBar(
        elevation: 0,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.book), label: "教材一覧"),
          NavigationDestination(icon: Icon(Icons.people), label: "プロフィール"),
        ],
        selectedIndex: tabType.index,
        onDestinationSelected: (int index) {
          ref.read(tabTypeProvider.notifier).updateTab(index);
        },
      ),
    );
  }
}
