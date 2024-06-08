import 'package:flutter/material.dart';
import 'package:scmu/pages/login_page.dart';
import 'package:scmu/pages/create_register.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //inicialmente mostra o pagina do login
  bool showLoginPage = true;

  //toggle entre o login e a pagina do registo
  void togglePages(){
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showLoginPage){
      return LoginPage(
        onTap: togglePages,
      );
    } else {
      return CreatePage(
        onTap: togglePages,
      );
    }
  }
}
