import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseAuthClient{
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<dynamic>SignIn(String email,String password)
  async {
    String? newToken = await FirebaseMessaging.instance.getToken();
    User? user = FirebaseAuth.instance.currentUser;
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email, password: password);
      user = FirebaseAuth.instance.currentUser;
      var getIdDoc = await FirebaseFirestore.instance
          .collection('users')
          .where('id', isEqualTo: user?.uid)
          .get();
      FirebaseFirestore.instance
          .collection('users')
          .doc(getIdDoc.docs.first.id)
          .set({'device_id': newToken}, SetOptions(merge: true));
      return (user);
    } catch (e) {
      if (e is FirebaseAuthException) {
        return e;
      }
    }
  }
  Future<dynamic>SignUp(String email,String password,String name) async {
    try {
      String? newToken = await FirebaseMessaging.instance.getToken();
      User? user = FirebaseAuth.instance.currentUser;
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email, password: password);
      user = FirebaseAuth.instance.currentUser;
      if(user!=null)
        {
          FirebaseFirestore.instance.collection('users').add({
            'email': user.email,
            'name': name,
            'id': user.uid,
            'chatrooms': <String, String>{},
            'device_id': newToken
          });
        }
      return (user);
    }catch (e) {
      if (e is FirebaseAuthException) {
        return (e);
      }
  }

  }
}