import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/constants/appcolors.dart';
import 'package:gymbro/extensions/context_extension.dart';
import 'package:gymbro/ui/sign_up_page.dart';
import 'package:gymbro/ui/widgets/password_field.dart';
import 'package:string_validator/string_validator.dart';

import '../services/firebase_authenticate.dart';
import 'landing.dart';

class SignInPage extends ConsumerStatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignInPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final bool _submitted = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.firstBlack,
        title: const Text('Giriş Yap'),
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),
                  const Text(
                    'Email',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    autofillHints: const [AutofillHints.email],
                    textInputAction: TextInputAction.next,
                    onChanged: _submitted
                        ? (value) => _formKey.currentState!.validate()
                        : null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Mailinizi girin';
                      } else if (!isEmail(value)) {
                        return 'Lütfen gerçek bir mail adresi girin';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Şifre'),
                  const SizedBox(height: 4),
                  PasswordField(
                      controller: _passwordController,
                      onChanged: _submitted
                          ? (value) => _formKey.currentState!.validate()
                          : null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Lütfen şifrenizi girin';
                        } else {
                          return null;
                        }
                      },
                      textInputAction: TextInputAction.go,
                      onSubmitted: (value) => //signin
                          doNothing()),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      const Spacer(),
                      GestureDetector(
                        onTap: () {
                          context.go(const SignUpPage());
                        },
                        child: const Text(
                          "",
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      var value = await auth.authLogin(
                          _emailController.text, _passwordController.text);
                      print(value);
                      value == true
                          ? context.replace(const LandingPage())
                          : ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Error')));
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: AppColors.primaryWhite,
                      backgroundColor: Colors.black,
                    ),
                    child: const Text('Giriş'),
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      context.go(const SignUpPage());
                    },
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.black,
                      backgroundColor: AppColors.secondWhite,
                    ),
                    child: const Text('Kayıt Ol'),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

void doNothing() {}
