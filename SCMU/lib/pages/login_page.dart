import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scmu/components/login_button.dart';
import 'package:scmu/components/login_textfield.dart';


class LoginPage extends StatefulWidget{
  final Function()? onTap;
  const LoginPage ({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  void signUserIn() async{

    showDialog(context: context, builder: (context) {
      return const Center(child: CircularProgressIndicator(),
      );
    },
    );
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      //remove o loading
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      wrongMessage2();
    }
  }
  void wrongMessage(){
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Email ou Password está incorreta'),
        );
      },
    );
  }

  void wrongMessage2(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.error,
      animType: AnimType.rightSlide,
      title: 'Wrong Credentials',
      desc: 'Email or Password are incorrect!',
      btnOkOnPress: () {},
    ).show();
  }

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
              //logo
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                        'lib/images/logo.png',
                        height: 120,
                    ),

                  ],
                ),

                const SizedBox(height: 50),
              //welcome back
              Text(
                'Welcome back!',
                style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                ),
              ),

                const SizedBox(height: 25),
              //user textfield
              MyTextField(
                controller: emailController,
                hintText: 'Username',
                obscureText: false,
              ),

                const SizedBox(height: 10),
              //password

              MyTextField(
                controller: passwordController,
                hintText: 'Password',
                obscureText: true,
              ),

                const SizedBox(height: 25),
              //sign in button
              MyButton(
                text: 'Sign In',
                onTap: signUserIn,
              ),

                const SizedBox(height: 50),
              // not a member register

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: widget.onTap,
                      child: const Text(
                          'Register here!',
                          style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                          ),
                      ),
                    ),
                  ],
                )
            ],),
          ),
        ),
      ),
    );
  }
}