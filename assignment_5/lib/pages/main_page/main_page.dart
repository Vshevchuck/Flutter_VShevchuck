import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  @override
  Widget build(BuildContext context) {
    final dataUser = (ModalRoute.of(context)?.settings.arguments) as User;

    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
                title: Row(
                  children: [Text('${dataUser.email}'), ElevatedButton(onPressed: () {
                    Navigator.pushReplacementNamed(context, '/login',arguments: true);
                  }, child: Text('Log out'))
                  ],
                )),
            body: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: Text("No elements"));
                  } else {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        print(snapshot.data!.docs[0].data() as Map<String,dynamic>);
                        final name =
                        snapshot.data!.docs[index].get('name');
                        final email = snapshot.data!.docs[index].get(
                            'email');
                        final indexNote = index;
                        return Text('$name $email');
                      },
                    );
                  }
                }),));
  }
}
