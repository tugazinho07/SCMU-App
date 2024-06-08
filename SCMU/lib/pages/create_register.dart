import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scmu/components/login_button.dart';
import 'package:scmu/components/login_textfield.dart';
import 'package:scmu/pages/register.dart';

class CreatePage extends StatefulWidget{
  final Function()? onTap;
  const CreatePage ({super.key, required this.onTap});

  @override
  State<CreatePage> createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmpasswordController = TextEditingController();
  final _nameController = TextEditingController();

  void dispose(){
    emailController.dispose();
    passwordController.dispose();
    confirmpasswordController.dispose();
    _nameController.dispose();
  }

  void signUserUp() async{

    showDialog(context: context, builder: (context) {
      return const Center(child: CircularProgressIndicator(),
      );
    },
    );
    try {
      if(passwordController.text == confirmpasswordController.text){
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
        addUserDetails(
          _nameController.text.trim(),
          'false',
          emailController.text.trim(),
        );
      } else {
        //remove o loading
        Navigator.pop(context);
        passDontMatch2();
      }
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      wrongMessage();
    }
  }

  Future addUserDetails(String userName, String admin, String email) async{
    await FirebaseFirestore.instance.collection('users').add({
      'username': userName,
      'admin': admin,
      'email': email,
    });
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


  void passDontMatch(){
    showDialog(
      context: context,
      builder: (context) {
        return const AlertDialog(
          title: Text('Passwords dont match!'),
        );
      },
    );
  }

  void passDontMatch2(){
    AwesomeDialog(
      context: context,
      dialogType: DialogType.warning,
      animType: AnimType.rightSlide,
      title: 'Passwords dont match!',
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

                const SizedBox(height: 30),
                //welcome back
                Text(
                  'Welcome back!',
                  style: TextStyle(
                    color: Colors.grey.shade700,
                    fontSize: 16,
                  ),
                ),

                const SizedBox(height: 25),

                MyTextField(
                  controller: _nameController,
                  hintText: 'Username',
                  obscureText: false,
                ),
                const SizedBox(height: 10),

                //user textfield
                MyTextField(
                  controller: emailController,
                  hintText: 'Email',
                  obscureText: false,
                ),

                const SizedBox(height: 10),
                //password

                MyTextField(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),

                MyTextField(
                  controller: confirmpasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),

                const SizedBox(height: 10),
                // forgot pass

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 25),
                //sign in button
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),

                const SizedBox(height: 50),
                // not a member register

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: widget.onTap,
                      child: Text(
                        'If you have an account Login!',
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