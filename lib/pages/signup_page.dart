import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:notes/helpers/data_validators.dart';
import 'package:notes/pages/home_page.dart';
import 'package:notes/reusable_widget/reusable_widgets.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  bool isPasswordShown = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/welcome 2.jpeg"),
                fit: BoxFit.cover)),
        child: Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(
    child: SingleChildScrollView(reverse: true,
              child: Padding(padding: EdgeInsets.all(32.0),
                child: Column(
                    children: [
                      SizedBox(
                          height: 290
                      ),
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.person_outline),
                          hintText: "Name",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(width: 0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _emailController,
                        validator: DataValidator.isValidEmail,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          hintText: "Email Address",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(width: 0),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: _passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30.0),
                            borderSide: const BorderSide(width: 0),
                          ),
                          prefixIcon: Icon(Icons.lock_outline),
                          hintText: "Password",
                          suffixIcon: Visibility(
                            visible: isPasswordShown,
                            replacement: IconButton(
                              onPressed: () {
                                setState(() {
                                  isPasswordShown = !isPasswordShown;
                                });
                              },
                              icon: Icon(Icons.visibility),
                            ),
                            child: IconButton(
                                onPressed: () {
                                  setState(() {
                                    isPasswordShown = !isPasswordShown;
                                  });
                                },
                                icon: Icon(Icons.visibility_off)),

                          ),
                        ),
                        obscureText: !isPasswordShown,
                      ),
                      SizedBox(
                        height: 24,
                      ),
                      signInButton(context, false, () {
                        FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: _emailController.text,
                            password: _passwordController.text);

                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => HomePage()));
                      })
                    ]),
              ),
            ))));
  }
}