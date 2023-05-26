import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:leadstudy/ui/add_record_page/add_record_page.dart';
import 'package:leadstudy/ui/book_detail_page/book_detail_page.dart';
import 'package:leadstudy/ui/book_detail_page/create_goal_page.dart';
import 'package:leadstudy/ui/book_manage_page.dart';
import 'package:leadstudy/ui/edit_book_page.dart';
import 'package:leadstudy/ui/edit_section_page.dart';
import 'package:leadstudy/ui/home_page.dart';
import 'package:leadstudy/ui/login_page.dart';
import 'package:leadstudy/ui/register_page.dart';
import 'package:leadstudy/ui/splash_page.dart';
import 'package:leadstudy/view_model/record_view_model.dart';

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: "LeadStudy",
      initialRoute: "/",
      theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.blue,
          fontFamily: "LINESeedJP"),
      debugShowCheckedModeBanner: false,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case "/":
            return MaterialPageRoute(builder: (context) => const SplashPage());
          case "/login":
            return MaterialPageRoute(builder: (context) => const LoginPage());
          case "/register":
            return MaterialPageRoute(
                builder: (context) => const RegisterPage());
          case "/home":
            return MaterialPageRoute(builder: (context) => HomePage());
          case "/edit_section":
            return MaterialPageRoute(
                builder: (context) => const EditSectionPage());
          case "/new_book":
            final args = settings.arguments as BookEditScreenArgument;
            return MaterialPageRoute(
                builder: (context) => EditBookPage(
                      args,
                    ),
                fullscreenDialog: true);
          case "/new_record":
            final args = settings.arguments as AddRecordScreenArgument;
            return MaterialPageRoute(
                builder: (context) => AddRecordPage(
                      args,
                    ),
                fullscreenDialog: true);
          case "/book_detail":
            final args = settings.arguments as BookScreenArgument;
            ref.read(recordListProvider.notifier).getRecentActivity(args.book);
            return MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => BookDetailPage(args),
            );
          case "/manage_books":
            return MaterialPageRoute(
                builder: (context) => const BooksManagePage(),
                fullscreenDialog: true);
          case "/new_goal":
            final args = settings.arguments as CreateGoalArgument;
            return MaterialPageRoute(
                builder: (context) => CreateGoalPage(
                      args: args,
                    ),
                fullscreenDialog: true);
        }
        return null;
      },
    );
  }
}
