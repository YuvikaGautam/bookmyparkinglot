import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:path_provider/path_provider.dart';

class AuthProvider with ChangeNotifier {
  bool _isLoggedin = false;
  bool _loading = true;
  // bool _submitted = false;
  String _email = "";
  String _password = "";
  String _role = "";
  String _uid = "";
  // bool get submitted => _submitted;
  bool get isLoggedin => _isLoggedin;
  String get email => _email;
  String get password => _password;
  String get role => _role;
  String get uid => _uid;
  bool get loading => _loading;

  Future<void> initAuth() async {
    const storage = FlutterSecureStorage();
    try {
      _email = await storage.read(key: "email") ?? "";
      _password = await storage.read(key: "password") ?? "";
      _role = await storage.read(key: "role") ?? "";
      _uid = await storage.read(key: "uid") ?? "";
    } catch (e) {
      _email = _password = _role = _uid = "";
      print(e);
    }
    _isLoggedin = _email != "" ? true : false;
    _loading = false;
    notifyListeners();
  }

  Future<String> signUp(String email, String password, String rool) async {
    final auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    const storage = FlutterSecureStorage();
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _uid = result.user!.uid;
      _email = email;
      _password = password;
      await firebaseFirestore.collection("users").doc(_uid).set({
        "email": email,
        "role": rool,
        "uid": _uid,
      });
      notifyListeners();
      return "Signed Up";
    } catch (e) {
    return "Something went wrong please try again";
    
    }

    await storage.write(key: "email", value: email);
    notifyListeners();
  }

  Future<String> login(String email, String password) async {
    try{
      final auth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    const storage = FlutterSecureStorage();
    final result =
        await auth.signInWithEmailAndPassword(email: email, password: password);
    _uid = result.user!.uid;
    await firebaseFirestore.collection("users").doc(_uid).get().then((value) {
      _role = value.data()!["role"];
      _uid = value.data()!["uid"];
    });
    _isLoggedin = true;
    storage.write(key: "email", value: email);
    storage.write(key: "password", value: password);
    storage.write(key: "role", value: _role);
    storage.write(key: "uid", value: _uid);
    print('=====================================');
    print('auth');
    print(_role);
    print(_uid);
    print(_email);
    print('=====================================');
    
    notifyListeners();
    return "Login Success";
    }
    catch(e){
      _isLoggedin = false;
      return "Login Failed";
    }
  }
// Future<void> signInWithGoogle(BuildContext context) async {
//     // User? firebaseUser;
//     try {
//       final googleUser = await _googleSignIn.signIn();
//       if (googleUser == null) return;
//       _googleUser = googleUser;
//       final googleAuth = await googleUser.authentication;
//       final credential = GoogleAuthProvider.credential(
//           accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
//       final UserCredential userCredential =
//           await FirebaseAuth.instance.signInWithCredential(credential);
//       // assert(userCredential.user != null);
//       final User firebaseUser = userCredential.user!;
//       Map data = {
//         'username': firebaseUser.uid,
//         'password': firebaseUser.uid.hashCode.toString(),
//       };
//       await FirebaseFirestore.instance
//           .collection('users')
//           .doc(firebaseUser.uid)
//           .set(data);
//       if (firebaseUser.email != null) data['email'] = firebaseUser.email;
//       if (firebaseUser.phoneNumber != null) {
//         data['mobile_number'] = firebaseUser.phoneNumber!.substring(3);
//       }
//       await login(data);
//       // Navigator.pop(context);
//     } catch (e) {
//       showSnackBar(context, "Gmail verification failed.", false);
//       print("---------- Gmail verification failed. -------------");
//       print(e.toString());
//     }
//   }
  Future<void> logout() async {
    await FirebaseAuth.instance.signOut();
    const storage = FlutterSecureStorage();
    await storage.deleteAll();

    await _deleteCacheDir();
    await _deleteAppDir();
    _email = _password = _role = _uid = "";
    _isLoggedin = false;
    notifyListeners();
  }

  Future<void> _deleteCacheDir() async {
    final cacheDir = await getTemporaryDirectory();

    if (cacheDir.existsSync()) {
      cacheDir.deleteSync(recursive: true);
    }
  }

  /// this will delete app's storage
  Future<void> _deleteAppDir() async {
    final appDir = await getApplicationSupportDirectory();

    if (appDir.existsSync()) {
      appDir.deleteSync(recursive: true);
    }
  }
}
