import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../main.dart';

import '../constant.dart';
import '../login/login_screen.dart';
import 'cubit/cubit.dart';
import 'cubit/states.dart';

class RegisterScreen extends StatelessWidget {
  var formKey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passController = TextEditingController();
  var numberController = TextEditingController();
  var facebookController = TextEditingController();
  var isAbscure = true;

  @override
  Widget build(BuildContext context) {
    var scaff = ScaffoldMessenger.of(context);
    return BlocProvider(
      create: (BuildContext context) => RegisterCubit(),
      child: BlocConsumer<RegisterCubit, RegisterStates>(
        listener: (context, state) {
          if (state is CreateSuccessState) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          } //
          if (state is RegisterSuccessState) {
            scaff.showSnackBar(
              SnackBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                content: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55),
                        color: Colors.green,
                      ),
                      child: const Center(
                        child: Text(
                            "You did a great job..You created the account successfully now please login "),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else if (state is RegisterErrorState) {
            scaff.showSnackBar(
              SnackBar(
                elevation: 0,
                backgroundColor: Colors.transparent,
                content: Column(
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(55),
                        color: Colors.red,
                      ),
                      child: const Center(
                        child: Text("An error occurred try again !"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: Container(
                constraints: const BoxConstraints.expand(),
                decoration: const BoxDecoration(),
                child: Form(
                  key: formKey,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(0, 35, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                         Text(
                          "Create an account",
                          style: TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            color:!isDark ? Colors.black : Color(0xFFECF0F3),
                          ),
                        ),
                        const Text(
                          "Sign up to get started ",
                          style: TextStyle(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.person,
                                ),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: 'Name'),
                            controller: nameController,
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'the name must not be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.email,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                filled: true,
                                labelText: 'Email'),
                            controller: emailController,
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'the name must not be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                                hoverColor: Colors.green,
                                suffixIcon: GestureDetector(
                                    onTap: () {
                                      isAbscure
                                          ? isAbscure = RegisterCubit.get(context)
                                              .ChangeBool(isAbscure, false)
                                          : isAbscure = RegisterCubit.get(context)
                                              .ChangeBool(isAbscure, true);
                                    },
                                    child: isAbscure
                                        ? Icon(Icons.visibility_off)
                                        : Icon(Icons.visibility)),
                                prefixIcon: const Icon(
                                  Icons.lock,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                filled: true,
                                focusColor: Colors.black,
                                labelText: 'Password'),
                            controller: passController,
                            obscureText: isAbscure,
                            keyboardType: TextInputType.text,
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'the password must not be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          child: TextFormField(
                            decoration: InputDecoration(
                                prefixIcon: const Icon(
                                  Icons.phone_android_outlined,
                                ),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20.0),
                                ),
                                labelText: 'number'),
                            controller: numberController,
                            keyboardType: TextInputType.text,
                            inputFormatters: <TextInputFormatter>[
                              FilteringTextInputFormatter.digitsOnly,
                            ],
                            validator: (String? value) {
                              if (value!.isEmpty) {
                                return 'the password must not be empty';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(),
                            elevation: 7,
                            primary: isDark ? Colors.grey.shade800 : Colors.orange,
                            shape: const StadiumBorder(side: BorderSide()),
                            fixedSize: const Size(300, 50),
                          ),
                          child: const Text(
                            "Sign Up",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onPressed: () async {
                            if(formKey.currentState!.validate()) {
                              var token =
                              await FirebaseMessaging.instance.getToken();
                              print('the token is :' + token.toString());
                              RegisterCubit.get(context).userRegister(
                                isEmailVerifaed: false,
                                name: nameController.text,
                                email: emailController.text,
                                phone: numberController.text,
                                password: passController.text,
                              );
                            }
                            },
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        const Text(
                          "Already have an account?",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 6,
                        ),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            side: const BorderSide(color: Colors.white),
                            primary: Colors.white,
                            elevation: 7,
                            shape: const StadiumBorder(side: BorderSide()),
                            fixedSize: const Size(300, 50),
                          ),
                          onPressed: () {
                            Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => LoginScreen(),
                              ),
                              (route) {
                                return false;
                              },
                            );
                          },
                          child: const Text(
                            "Log in",
                            style: TextStyle(
                              fontSize: 18.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
