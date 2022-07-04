import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => MainPageState();
}

class MainPageState extends State<MainPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            title: Text(
                'Auth User (Logged ' + (user == null ? 'out' : 'in') + ')')),
        body: Column(
          children: [
            TextField(controller: emailController),
            TextField(controller: passwordController),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    await FirebaseAuth.instance.signInWithEmailAndPassword(
                        email: emailController.text,
                        password: passwordController.text);
                    setState(() {});
                  },
                  child: const Text('Sign In'),
                ),
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance
                          .createUserWithEmailAndPassword(
                              email: emailController.text,
                              password: passwordController.text);
                      setState(() {});
                    },
                    child: const Text('Sign Up')),
                ElevatedButton(
                    onPressed: () async {
                      await FirebaseAuth.instance.signOut();
                      setState(() {});
                    },
                    child: const Text('Sign Out')),
                ElevatedButton(
                  onPressed: ()  {
                  },
                  child: const Text('get id'),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
