import 'package:flutter/material.dart';
import 'package:forms_validation_app/providers/login_form_provider.dart';
import 'package:forms_validation_app/ui/input_decorations.dart';
import 'package:forms_validation_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AuthBackground(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 250.0),
              CardContainer(
                child: Column(
                  children: [
                    const SizedBox(height: 10.0),
                    Text(
                      'Login',
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    const SizedBox(height: 30.0),
                    ChangeNotifierProvider(
                      create: (_) => LoginFormProvider(),
                      child: _LoginForm(),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 50.0),
              const Text('Create a new account'),
              const SizedBox(height: 50.0),
            ],
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final loginForm = Provider.of<LoginFormProvider>(context);
    return Form(
      key: loginForm.formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Column(
        children: [
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
              hintext: 'link@zelda.com',
              laberText: 'Email',
              prefixIcon: Icons.alternate_email,
            ),
            keyboardType: TextInputType.emailAddress,
            onChanged: (value) => loginForm.email = value,
            validator: (value) {
              String pattern =
                  r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
              RegExp regExp = RegExp(pattern);

              return regExp.hasMatch(value ?? '')
                  ? null
                  : 'The value entered is not an email';
            },
          ),
          const SizedBox(height: 30.0),
          TextFormField(
            autocorrect: false,
            decoration: InputDecorations.authInputDecoration(
              hintext: '*****',
              laberText: 'Password',
              prefixIcon: Icons.lock_outline,
            ),
            keyboardType: TextInputType.text,
            obscureText: true,
            onChanged: (value) => loginForm.password = value,
            validator: (value) {
              return (value != null && value.length >= 6)
                  ? null
                  : 'The password must have at least 6 characters';
            },
          ),
          const SizedBox(height: 30.0),
          MaterialButton(
            color: Colors.deepPurple,
            disabledColor: Colors.grey,
            elevation: 0.0,
            onPressed: loginForm.isLoading
                ? null
                : () async {
                    FocusScope.of(context).unfocus();
                    if (loginForm.isValidForm()) {
                      loginForm.isLoading = true;
                      await Future.delayed(
                        const Duration(seconds: 2),
                      ).then((_) {
                        loginForm.isLoading = false;
                        Navigator.pushReplacementNamed(
                          context,
                          'home',
                        );
                      });
                    }
                  },
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 80.0,
                vertical: 15.0,
              ),
              child: Text(
                loginForm.isLoading == true ? 'Wait' : 'Sign in',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
