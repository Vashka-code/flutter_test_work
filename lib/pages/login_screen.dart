import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test_work/features/login/login_bloc.dart';
import 'package:flutter_test_work/features/login/login_repository.dart';
import 'package:flutter_test_work/features/login/login_state.dart';
import 'package:flutter_test_work/features/main/main_page_bloc.dart';
import 'package:flutter_test_work/form/form.dart';
import 'package:flutter_test_work/form/form_submission_status.dart';
import 'package:flutter_test_work/pages/main_page.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      body: BlocProvider(
        create: (context) =>
            LoginBloc(authRepo: context.read<LoginRepository>()),
        child: BlocListener<LoginBloc, LoginState>(
          listenWhen: (previous, current) =>
              previous.formStatus != current.formStatus,
          listener: (context, state) {
            final formStatus = state.formStatus;

            if (formStatus is SubmissionFailed) {
              _showSnackBar(context, formStatus.exception.toString());
            }
            if (formStatus is SubmissionSuccess) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return BlocProvider(
                    create: (context) => MainPageBloc(),
                    child: const MainPage(),
                  );
                }),
              );
            }
          },
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Welcome to my first Flutter Application",
                    style: TextStyle(fontSize: 30),
                  ),
                  FormWidget(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _showSnackBar(BuildContext context, String message) {
    final snackBar = SnackBar(content: Text(message));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}
