import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:scmu/read%20data/get_email.dart';
import 'package:scmu/read%20data/get_username.dart';

class UserDetailsPage extends StatefulWidget {
  final String documentId;

  const UserDetailsPage({Key? key, required this.documentId}) : super(key: key);

  @override
  State<UserDetailsPage> createState() => _UserDetailsPageState();
}

class _UserDetailsPageState extends State<UserDetailsPage> {
  bool isAdmin = false;

  @override
  void initState() {
    super.initState();
    fetchUserDetails();
  }

  Future<void> fetchUserDetails() async {
    final snapshot = await FirebaseFirestore.instance.collection('users').doc(widget.documentId).get();
    final userData = snapshot.data() as Map<String, dynamic>?;

    if (userData != null) {
      setState(() {
        isAdmin = userData['admin'] ?? false;
      });
    }
  }

  Future<void> toggleAdminStatus(BuildContext context) async {
    final updatedStatus = !isAdmin;

    await FirebaseFirestore.instance
        .collection('users')
        .doc(widget.documentId)
        .update({'admin': updatedStatus});

    setState(() {
      isAdmin = updatedStatus;
    });

    final snackBarMessage = isAdmin ? 'Usuário agora é um administrador!' : 'Usuário não é mais um administrador.';
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(snackBarMessage)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Usuário'),
      ),
      body: Center(
        child: FutureBuilder<DocumentSnapshot>(
          future: FirebaseFirestore.instance.collection('users').doc(widget.documentId).get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }

            if (!snapshot.hasData) {
              return const Text('Usuário não encontrado');
            }

            final userData = snapshot.data!.data() as Map<String, dynamic>?;

            if (userData == null) {
              return const Text('Dados do usuário não encontrados');
            }

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: NetworkImage(
                      'http://placebacon.net/400/300?image=' + widget.documentId,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'Nome de Usuário: ${userData['username']}',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Email: ${userData['email']}',
                    style: TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () => toggleAdminStatus(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: isAdmin ? Colors.red : Colors.green,
                    ),
                    child: Text(
                      isAdmin ? 'Remover de Administrador' : 'Tornar Administrador',
                      style: TextStyle(color: Colors.white),
                  ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
