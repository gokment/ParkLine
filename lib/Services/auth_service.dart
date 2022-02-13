import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:parkline/Const/Routes.dart';
import 'package:parkline/Model/User.dart' as u;
import 'package:parkline/Services/db.dart';

class AuthServices {
  FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googlesignIn = GoogleSignIn();

  Future signinAnonimous() async {
    try {
      final result = await auth.signInAnonymously();
      return result.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> get user async {
    final user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future<bool> signup(String email, pass, String username) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (result.user != null) {
        await DBServices().saveUser(
          u.UserModel(id: result.user.uid, email: email, username: username),
        );
        // UserModel.fromJson(result[2])
        await DBServices().saveUserPref(
          u.UserModel(id: result.user.uid, email: email, username: username),
        );
        return true;
      }

      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateUserCredentials(
      String email, String username, String id) async {
    try {
      final result = await DBServices().updateUser(
          u.UserModel(id: id, email: email, username: username), id);
      // if (result.user != null) {
        // await DBServices().saveUser(
        //   u.UserModel(
        //       id: id,
        //       email: email,
        //       username: result.user.displayName),
        // );
        // // UserModel.fromJson(result[2])
        await DBServices().saveUserPref(
          u.UserModel(
              id: id,
              email: email,
              username: username),
        );
        // print(result.user.uid);
        return true;
      // }

      // return false;
    } catch (e) {
      return false;
    }
  }

  // bool isLog = false;
  Future<bool> signin(String email, String pass) async {
    try {
      final result =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      if (result.user != null) {
        await DBServices().saveUser(
          u.UserModel(id: result.user.uid, email: email),
        );
        await DBServices().saveUserPref(
          u.UserModel(
              id: result.user.uid,
              email: email,
              username: result.user.displayName),
        );
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  Future<bool> resetpassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> googleSignIn() async {
    try {
      GoogleSignInAccount googleUser = await googlesignIn.signIn();
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
      final user = await auth.signInWithCredential(credential);
      if (user != null) return true;
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }

  Future signOut() async {
    try {
      return auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
