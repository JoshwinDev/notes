import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/cubit/authentication_cubit.dart';
import 'package:notes/helpers/data_validators.dart';
import 'package:notes/pages/home_page.dart';
import 'package:notes/pages/signup_page.dart';
import 'package:notes/reusable_widget/reusable_widgets.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isPasswordShown = false;

  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => AuthenticationCubit(),
        child: Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/images/welcome.jpeg"),
                    fit: BoxFit.cover)),
            child: Scaffold(
                backgroundColor: Colors.transparent,
                body: Center(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Padding(
                      padding: EdgeInsets.all(32.0),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 290,
                          ),
                          TextFormField(
                            controller: _emailController,
                            validator: DataValidator.isValidEmail,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            keyboardType: TextInputType.emailAddress,
                            decoration: InputDecoration(
                              prefixIcon: Icon(Icons.email),
                              labelText: "Email Address",
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(width: 0),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 15,
                          ),
                          TextFormField(
                            controller: _passwordController,
                            style:
                                TextStyle(color: Colors.black.withOpacity(0.9)),
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(30.0),
                                borderSide: const BorderSide(width: 0),
                              ),
                              prefixIcon: Icon(Icons.lock_outline),
                              labelText: "Password",
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
                            height: 15,
                          ),
                          BlocConsumer<AuthenticationCubit,
                              AuthenticationState>(
                            listener: (context, state) {
                              if (state is AuthenticationSuccess) {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            HomePage()));
                              } else if (state is AuthenticationFailure) {
                                String errorMessage = state.errorMessage;
                                showDialog(
                                    context: context,
                                    builder: (
                                      _,
                                    ) {
                                      return AlertDialog(
                                        title: const Text("Login Failed"),
                                        content: Text(errorMessage),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              child: const Text("Ok"))
                                        ],
                                      );
                                    });
                              }
                            },
                            builder: (context, state) {
                              if (state is AuthenticationLoading) {
                                return const Center(
                                    child: CupertinoActivityIndicator());
                              }

                              return signInButton(context, true, () {
                                FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                              });
                            },
                          ),
                          signUpButton()
                        ],
                      ),
                    ),
                  ),
                ))));
  }

  Row signUpButton() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text("Don't have an account?",
          style: TextStyle(color: Colors.black, fontSize: 15.0)),
      TextButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SignUpPage()));
          },
          child: Text("Sign Up")),
    ]);
  }
}
