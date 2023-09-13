import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_work/features/login/login_repository.dart';
import 'package:flutter_test_work/features/main/main_page_bloc.dart';
import 'package:flutter_test_work/pages/main_page.dart';
import 'package:flutter_test_work/pages/login_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.purpleAccent,
        primarySwatch: Colors.purple,
        useMaterial3: true,
      ),
      home: RepositoryProvider(
        create: (context) => (LoginRepository()),
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => MainPageBloc(),
              child: const MainPage(),
            ),
          ],
          child: const LoginScreen(),
        ),
      ),
    );
  }
}
