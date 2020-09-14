import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

enum Status { Uninitialized, Authenticated, Authenticating, Unauthenticated }

class Auth with ChangeNotifier {
  FirebaseAuth _auth;
  FirebaseUser _user;
  Status _status = Status.Uninitialized;

  Auth.instance() : _auth = FirebaseAuth.instance {
    _auth.onAuthStateChanged.listen(_onAuthStateChanged);
  }

  Status get status => _status;
  FirebaseUser get user => _user;

  Future<bool> signIn(String email, String password) async {
    try {
      // _status = Status.Authenticating;
      // notifyListeners();
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {      
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future<bool> signUp(String email, String password) async {
    try {
      // _status = Status.Authenticating;
      // notifyListeners();
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await storeUserDetails(email);
      await sendVerificationMail();

      return true;
    } catch (e) {
      _status = Status.Unauthenticated;
      notifyListeners();
      return false;
    }
  }

  Future storeUserDetails(email) async {
    var data = {
      "email": email,
      "createdAt": new DateTime.now().millisecondsSinceEpoch,
      "userid": user.uid
    };
    await Firestore.instance
        .collection('users')
        .document(user.uid)
        .setData(data);
  }

  Future sendVerificationMail() async {
    await user.sendEmailVerification();
  }

  Future<bool> changePassword(String oldPassword, String newPassword) async {
    try {
      // _status = Status.Authenticating;
      // notifyListeners();

      print('inside AuthProvider');

      final AuthCredential credential = EmailAuthProvider.getCredential(
          email: user.email, password: oldPassword);

      final AuthResult result =
          await user.reauthenticateWithCredential(credential);
      print('inside AuthResult');
      print(result.user);

      await updatePassword(newPassword);

      return true;
    } on PlatformException catch (e) {
      return false;
    } catch (e) {
      await updatePassword(newPassword);

      return true;
    }
  }

  Future<bool> updatePassword(newPassword) async {
    try {
      await user.updatePassword(newPassword);
      return true;
    } catch (e) {
      print('update Password error : ');
      print(e);
      return false;
    }
  }

  Future signOut() async {
    _auth.signOut();
    _status = Status.Unauthenticated;
    notifyListeners();
    return Future.delayed(Duration.zero);
  }

  Future<void> _onAuthStateChanged(FirebaseUser firebaseUser) async {
    print('_onAuthStateChanged');
    if (firebaseUser == null) {
      _status = Status.Unauthenticated;
    } else {
      _user = firebaseUser;
      _status = Status.Authenticated;
      user.reload();
    }
    notifyListeners();
  }

  Future forgetPassword(String email) async {
    return _auth.sendPasswordResetEmail(email: email);
  }

}
