

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:en_payroll/screens/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../screens/otp_screen.dart';


class PhoneAuthService{
  FirebaseAuth auth = FirebaseAuth.instance;
  User user = FirebaseAuth.instance.currentUser;
  CollectionReference users = FirebaseFirestore.instance.collection('users');


  Future<void> addUser(context) async{
    final QuerySnapshot result = await users.where('uid',isEqualTo: user.uid).get();
    List <DocumentSnapshot> document = result.docs; //list of user data

    if(document.length>0){

      Navigator.pushReplacementNamed(context, HomeScreen.id);
    }else{

      return users.doc(user.uid)
          .set({
        'uid': user.uid, // user id
        'mobile': user.phoneNumber, // Stokes and Sons
        'email': user.email // 42
      })
          .then((value){
        Navigator.pushReplacementNamed(context, HomeScreen.id);
      })
          .catchError((error) => print("Failed to add user: $error"));
    }

  }




  Future<void> verifyPhoneNumber(BuildContext context, number) async {
    final PhoneVerificationCompleted verificationCompleted =
        (PhoneAuthCredential credential) async {
      //if we use real number , sometime in android device this will work that
      //system will login automatically.
      //lets try once
      await auth.signInWithCredential(
          credential); //after verification completed need to signin
    };

    final PhoneVerificationFailed verificationFailed =
        (FirebaseAuthException e) {
      //if verification failed , it will show the reason
      if (e.code == 'invalid-phone-number') {
        print('The provided phone number is not valid.');
      }
      print('The error is ${e.code}');
    };

    final PhoneCodeSent codeSent = (String verId, int resendToken) async {
      //if OTP send now new screen to should open to enter OTP.
      //so we will design a new screen now
      Navigator.push(
        context, MaterialPageRoute(builder: (context) => OTPScreen(number: number,verId:verId ,),),);

      //lets try now
    };

    try {
      auth.verifyPhoneNumber(
          phoneNumber: number,
          verificationCompleted: verificationCompleted,
          verificationFailed: verificationFailed,
          codeSent: codeSent,
          timeout: const Duration(seconds: 60),
          codeAutoRetrievalTimeout: (String verificationId) {
            print(verificationId); //will work on this later
          });
    } catch (e) {
      print('Error ${e.toString()}');
    }
  }
}