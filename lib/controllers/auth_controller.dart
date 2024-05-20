import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:store_management/constants/firebase_auth_constants.dart';
import 'package:store_management/models/user.dart';
import 'package:store_management/screens/components/snack_bar.dart';
import 'package:store_management/screens/login_page.dart';
import 'package:store_management/screens/main_page.dart';

class AuthController extends GetxController with StateMixin {
  final settings = GetStorage("Settings");

  static AuthController instance = Get.find();
  late Rx<User?> firebaseUser;

  RxBool isLoadingLogin = false.obs;

  // late Rx<GoogleSignInAccount?> googleSignInAccount;

  @override
  void onReady() {
    super.onReady();
    // auth is comning from the constants.dart file but it is basically FirebaseAuth.instance.
    // Since we have to use that many times I just made a constant file and declared there

    // googleSignInAccount = Rx<GoogleSignInAccount?>(googleSign.currentUser);
    if (auth.currentUser != null) {
      firebaseUser = Rx<User?>(auth.currentUser);
    } else {
      final storedString = settings.read('user');

      if (storedString != null) {
        final jsonData = jsonDecode(storedString);

        UserModel user = UserModel.fromJson(jsonData);
        login(user.email, user.password);
        debugPrint("email: ${user.email}, password: ${user.password}");
      } else {
        firebaseUser = Rx<User?>(auth.currentUser);
      }
    }

    firebaseUser.bindStream(auth.userChanges());
    ever(firebaseUser, _setInitialScreen);

    // googleSignInAccount.bindStream(googleSign.onCurrentUserChanged);
    // ever(googleSignInAccount, _setInitialScreenGoogle);
  }

  _setInitialScreen(User? user) {
    if (user == null) {
      // if the user is not found then the user is navigated to the Register Screen
      Get.offAll(() => const LoginPage());
    } else {
      // if the user exists and logged in the the user is navigated to the Home Screen
      Get.offAll(() => const MainPage());
    }
  }

  // _setInitialScreenGoogle(GoogleSignInAccount? googleSignInAccount) {
  //   print(googleSignInAccount);
  //   if (googleSignInAccount == null) {
  //     // if the user is not found then the user is navigated to the Register Screen
  //     Get.offAll(() => const Register());
  //   } else {
  //     // if the user exists and logged in the the user is navigated to the Home Screen
  //     Get.offAll(() => Home());
  //   }
  // }

  // void signInWithGoogle() async {
  //   try {
  //     GoogleSignInAccount? googleSignInAccount = await googleSign.signIn();

  //     if (googleSignInAccount != null) {
  //       GoogleSignInAuthentication googleSignInAuthentication =
  //           await googleSignInAccount.authentication;

  //       AuthCredential credential = GoogleAuthProvider.credential(
  //         accessToken: googleSignInAuthentication.accessToken,
  //         idToken: googleSignInAuthentication.idToken,
  //       );

  //       await auth
  //           .signInWithCredential(credential)
  //           .catchError((onErr) => print(onErr));
  //     }
  //   } catch (e) {
  //     Get.snackbar(
  //       "Error",
  //       e.toString(),
  //       snackPosition: SnackPosition.BOTTOM,
  //     );
  //     print(e.toString());
  //   }
  // }

  void register(String email, password) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
    } catch (firebaseAuthException) {
      debugPrint(firebaseAuthException.toString());
    }
  }

  void login(String email, password) async {
    isLoadingLogin.value = true;
    UserModel user = UserModel(email: email, password: password);
    final userMap = user.toJson();

    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      settings.write('user', jsonEncode(userMap));
    } catch (firebaseAuthException) {
      displaySnackbar(
        status: CustomSnackbarStatus.error,
        title: "เกิดข้อผิดพลาด",
        content: firebaseAuthException.toString(),
      );
      debugPrint(firebaseAuthException.toString());
    }

    isLoadingLogin.value = false;
  }

  void signOut() async {
    settings.remove('user');
    await auth.signOut();
  }

  void updateProfile(String name, {String? photoURL}) async {
    await auth.currentUser!.updateDisplayName(name);
    await auth.currentUser!.updatePhotoURL(photoURL);
  }
}
