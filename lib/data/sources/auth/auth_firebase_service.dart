import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/core/configs/constants/app_urls.dart';
import 'package:spotify/data/models/auth/create_user_req.dart';
import 'package:spotify/data/models/auth/signin_user_req.dart';
import 'package:spotify/data/models/auth/user.dart';
import 'package:spotify/domain/entities/auth/user_entity.dart';

abstract class AuthFirebaseService {
  Future<Either> signup(CreateUserReq user);
  Future<Either> signin(SignInUserReq user);
  Future<Either> GetUser();
}

class AuthFirebaseServiceImplementation implements AuthFirebaseService {
  @override
  Future<Either> signin(SignInUserReq user) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: user.email, password: user.password);
      return Right('Signin was successful');
    } on FirebaseAuthException catch (e) {
      String message = 'error from authservice';
      if (e.code == 'invalid-credential') {
        message = 'the password is wrong';
      } else if (e.code == 'invalid-email') {
        message = "Account doesn't exists with that mail";
      }
      return Left(message);
    }
  }

  @override
  Future<Either> signup(CreateUserReq user) async {
    try {
      var date = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(date.user?.uid)
          .set({'fullName': user.fullName, 'email': date.user?.email});
      return Right('Signup was successful');
    } on FirebaseAuthException catch (e) {
      String message = 'error from firebaseauthservice';
      if (e.code == 'weak-password') {
        message = 'the password is too weak';
      } else if (e.code == 'email-already-in-use') {
        message = 'An account already exists with that mail';
      }
      return Left(message);
    }
  }

  @override
  Future<Either> GetUser() async {
    try {
      FirebaseAuth firebaseAuth = FirebaseAuth.instance;
      FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
      var user = await firebaseFirestore
          .collection('Users')
          .doc(firebaseAuth.currentUser?.uid)
          .get();
      UserModel userModel = UserModel.fromJson(user.data()!);
      userModel.imageurl =
          firebaseAuth.currentUser?.photoURL ?? AppUrls.userprofile;
      UserEntity userEntity = userModel.toEntity();
      return Right(userEntity);
    } catch (e) {
      return Left('An error occurred');
    }
  }
}
