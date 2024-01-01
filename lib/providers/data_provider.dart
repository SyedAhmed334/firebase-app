// ignore_for_file: unused_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

class DataProvider extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance.collection('User Data');
  DocumentSnapshot? _userData;
  bool _isEditable = false;

  bool get isEditable => _isEditable;

  DocumentSnapshot<Object> get userData =>
      _userData as DocumentSnapshot<Object>;

  Future<void> fetchData() async {
    _userData = await FirebaseFirestore.instance
        .collection('User Data')
        .doc(auth.currentUser!.uid.toString())
        .get();
    notifyListeners();
  }

  Future<void> setData(String firstName, String lastName, String email) async {
    await fireStore.doc(auth.currentUser!.uid).set({
      'firstname': firstName,
      'lastname': lastName,
      'email': email,
    });
    notifyListeners();
  }

  void isNotEditable() {
    _isEditable = false;
    notifyListeners();
  }

  void editable() {
    _isEditable = true;
    notifyListeners();
  }
}
