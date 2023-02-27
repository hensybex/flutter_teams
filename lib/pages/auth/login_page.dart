import 'package:auto_route/auto_route.dart';
import 'package:black_pearl/models/router.gr.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:black_pearl/pages/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends ConsumerStatefulWidget {
  @override
  ConsumerState<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends ConsumerState<LoginPage> {
  bool _isObscure3 = true;
  bool visible = false;
  final _formkey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                  enabled: true,
                  labelText: "Email",
                ),
                validator: (value) {
                  if (value!.length == 0) {
                    return "Email cannot be empty";
                  }
                  if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                      .hasMatch(value)) {
                    return ("Please enter a valid email");
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  emailController.text = value!;
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: passwordController,
                obscureText: _isObscure3,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      icon: Icon(_isObscure3
                          ? Icons.visibility
                          : Icons.visibility_off),
                      onPressed: () {
                        setState(() {
                          _isObscure3 = !_isObscure3;
                        });
                      }),
                  enabled: true,
                  labelText: "Password",
                ),
                validator: (value) {
                  RegExp regex = new RegExp(r'^.{6,}$');
                  if (value!.isEmpty) {
                    return "Password cannot be empty";
                  }
                  if (!regex.hasMatch(value)) {
                    return ("please enter valid password min. 6 character");
                  } else {
                    return null;
                  }
                },
                onSaved: (value) {
                  passwordController.text = value!;
                },
                keyboardType: TextInputType.emailAddress,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                signIn(emailController.text, passwordController.text);
              },
              child: Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                context.pushRoute(const RegisterRoute());
                //context.replaceRoute(const RegisterRoute());
                //Navigator.pushNamed(context, './register');
              },
              child: Text('Register'),
            ),
          ],
        ),
      ),
    );
  }

  void signIn(String email, String password) async {
    if (_formkey.currentState!.validate()) {
      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        context.replaceRoute(const HomeRoute());
        //context.router.pop();
        //context.router.push(const HomeRoute());
        //Navigator.pushNamedAndRemoveUntil(context, './home', (route) => false);
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }
    }
  }
}
