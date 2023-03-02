import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:my_app_2/utils.dart';

class AuthController extends GetxController{
  FirebaseAuth auth= FirebaseAuth.instance;
  GoogleSignIn googleSignIn= GoogleSignIn();
  Rx<User?> user =Rx<User?>(FirebaseAuth.instance.currentUser);

  @override
  void onInit(){
    //TODO: implement onInit
    super.onInit();
    user.bindStream(auth.authStateChanges());
  }
  login()async{
     GoogleSignInAccount? googleUser= await googleSignIn.signIn();
     if(googleUser!=null){
        GoogleSignInAuthentication googleAuth =await googleUser.authentication;
        AuthCredential credential =GoogleAuthProvider.credential(
            idToken: googleAuth.idToken, accessToken: googleAuth.accessToken);
        print("User signed in");
        UserCredential userCredential = 
            await auth.signInWithCredential(credential);
        User? user = userCredential.user!;
        userCollection.doc(user.uid).set({
          "username": user.displayName,
          "profilepic": user.photoURL,
          "email": user.email,
          "uid": user.uid,
          "userCreated": DateTime.now()
        });
     }
  }
}

// class MyRepository {
// }