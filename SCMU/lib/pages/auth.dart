import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scmu/homepage.dart';
import 'package:scmu/pages/login_page.dart';
import 'package:scmu/pages/register.dart';

class Auth extends StatelessWidget {
  const Auth({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(), //esta com o login feito ou nao
        builder: (context, snapshot){
          //user is logged in
          if(snapshot.hasData){
            return HomePageApp();
          }
          //user is not logged in
          else{
            return RegisterPage();
          }
        },
      ),
    );
  }
}
