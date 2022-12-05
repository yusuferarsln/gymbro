import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gymbro/extensions/context_extension.dart';
import 'package:gymbro/services/api_service.dart';
import 'package:gymbro/services/firebase_authenticate.dart';
import 'package:gymbro/ui/landing.dart';
import 'package:gymbro/ui/sign_in_page.dart';
import 'package:gymbro/ui/widgets/password_field.dart';
import 'package:string_validator/string_validator.dart';

class SignUpPage extends ConsumerStatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  ConsumerState<SignUpPage> createState() => _SignInPageState();
}

class _SignInPageState extends ConsumerState<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();

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
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text('go')),
                  const Text(
                    'Register',
                  ),
                  const SizedBox(height: 16),
                  const Text('Email'),
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
                        return 'Please enter your email';
                      } else if (!isEmail(value)) {
                        return 'Please enter a valid email';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text('Username'),
                  const SizedBox(height: 4),
                  TextFormField(
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                    autofillHints: const [AutofillHints.name],
                    textInputAction: TextInputAction.next,
                    onChanged: _submitted
                        ? (value) => _formKey.currentState!.validate()
                        : null,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      } else if (_nameController.text.length <= 4) {
                        return 'Please enter a user name longer than 4 letter';
                      }

                      return null;
                    },
                  ),
                  const SizedBox(height: 20),
                  const Text('Password'),
                  const SizedBox(height: 4),
                  PasswordField(
                      controller: _passwordController,
                      onChanged: _submitted
                          ? (value) => _formKey.currentState!.validate()
                          : null,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password';
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
                          context.go(const SignInPage());
                        },
                        child: const Text(
                          'Already have account?',
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () async {
                      var value = await auth.authRegister(
                          _emailController.text, _passwordController.text);

                      if (value != null) {
                        await api.setUser(
                            _nameController.text, _emailController.text, value);
                        context.replace(const LandingPage());
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Error')));
                      }
                    },
                    child: const Text('Sign Up'),
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
