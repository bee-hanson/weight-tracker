import 'package:flutter/material.dart';
import 'package:weight_tracker/constants/routes.dart';
import 'package:weight_tracker/viewmodels/log_in_viewmodel.dart';

class LogInView extends StatelessWidget {
  LogInView(this._loginViewModel, {super.key});

  final LogInViewmodel _loginViewModel;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text(
            'Weight Tracker',
            style: TextStyle(
                fontSize: 24.0,
                color: Colors.deepPurple,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 24.0),
          TextField(
            decoration: const InputDecoration(hintText: 'Email'),
            controller: _emailController,
          ),
          TextField(
            decoration: const InputDecoration(hintText: 'Password'),
            obscureText: true,
            controller: _passwordController,
          ),
          const SizedBox(height: 24.0),
          ElevatedButton(
              onPressed: () async {
                await _loginViewModel.login(
                    _emailController.text, _passwordController.text,
                    onSuccess: () => Navigator.pushNamedAndRemoveUntil(
                        context, homeRoute, (Route<dynamic> route) => false));
              },
              child: const SizedBox(
                width: double.infinity,
                child: Text(
                  'Log In',
                  style: TextStyle(fontSize: 24.0),
                  textAlign: TextAlign.center,
                ),
              ))
        ]),
      )),
    );
  }
}
