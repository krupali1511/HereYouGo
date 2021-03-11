import 'package:firebase_auth/firebase_auth.dart';
import 'package:here_you_go_1/models/user.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:here_you_go_1/models/userModel.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  FirebaseUser _user;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  bool isSignIn =false;
  bool google =false;
  // create user obj base on firebase obj
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }

  //auth change user stream
  Stream<User> get user {
    return _auth.onAuthStateChanged
        .map((FirebaseUser user) => _userFromFirebase(user));
  }

  // Register with email and password

  Future registerWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      print("It comes here");
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  // sign in with email and password
  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      FirebaseUser user = result.user;
      print("It comes here");
      return _userFromFirebase(user);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  //login with google
  Future<bool> loginWithGoogle() async {
    try {
      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount account = await googleSignIn.signIn();
      if (account == null) return false;
      AuthResult res = await _auth.signInWithCredential(
          GoogleAuthProvider.getCredential(
              idToken: (await account.authentication).idToken,
              accessToken: (await account.authentication).accessToken));
      if (res.user == null) return false;
      return true;
    } catch (e) {
      print("Error in function");
      print(e.toString());
      return false;
    }
  }
  Future<FirebaseUser> signInWithGoogle(userModel model) async {
    try{
      model.state = "Busy";
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.getCredential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );
      AuthResult authResult = await _auth.signInWithCredential(credential);
      _user = authResult.user;
      assert(!_user.isAnonymous);
      assert(await _user.getIdToken() != null);
      FirebaseUser currentUser = await _auth.currentUser();
      assert(_user.uid == currentUser.uid);
      model.state = "Idle";
      print("User Name: ${_user.displayName}");
      print("User Email ${_user.email}");
    }
    catch(e){
      print(e.toString());
    }

  }
  // sign out

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
