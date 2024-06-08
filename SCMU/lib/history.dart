import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scmu/pages/userProfile.dart';
import 'package:scmu/read%20data/get_email.dart';
import 'package:scmu/read%20data/get_username.dart';

class historyPage extends StatefulWidget {
  const historyPage({Key? key}) : super(key: key);

  @override
  State<historyPage> createState() => _historyPageState();
}

class _historyPageState extends State<historyPage> {

  List<String> docIDs = [];

  Future getDocId() async{
    await FirebaseFirestore.instance.collection('users').orderBy('username',descending: true).get().then(
          (snapshot) => snapshot.docs.forEach((document) {
            print(document.reference);
            docIDs.add(document.reference.id);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getDocId(),
        builder: (context, snapshot) {
        return ListView.builder(
            itemCount: docIDs.length,
            itemBuilder: (context, index) => Card(
              child: ListTile(
                leading: CircleAvatar(
                  radius: 28,
                  backgroundImage: NetworkImage(
                      'http://placebacon.net/400/300?image=' + docIDs[index],
                  ),
                ),
                title: GetUserName(documentId: docIDs[index]),
                subtitle: GetEmail(documentId: docIDs[index]),
                trailing: (const Icon(Icons.arrow_forward)),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => UserDetailsPage(documentId: docIDs[index]),
                    ),
                  );
                },
              ),
            )
        );
      },),
    );
  }
}
