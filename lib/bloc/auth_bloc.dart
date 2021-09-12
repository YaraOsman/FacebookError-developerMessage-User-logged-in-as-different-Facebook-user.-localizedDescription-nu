
import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:fb/services/auth_services.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';

class AuthBloc {
  final authService = AuthService();
  final fb = FacebookLogin();

  Stream get currentUser => authService.currentUser;

  loginFacebook() async {
    try {


      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email
      ]);

      if (res.status == FacebookLoginStatus.success) {
        print('It workedddddddddddddddddddddddddddddddddddddddddddddddddddddd');
        //Get Token
        final fbToken = await res.accessToken!.token;
        final AuthCredential credential =await FacebookAuthProvider.credential(fbToken);
        final result = await authService.signInWithCredentail(credential);

        print('${result.user.displayName} is now logged in');
        } else if (res.status == FacebookLoginStatus.cancel) {
          print('The user canceled the loginnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn}');
        }
        else if (res.status == FacebookLoginStatus.error) {
          print('There is an errorrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrrr ${res.error}');
        }
        }catch(e){
          print('eeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee:$e');
        }
  }

  logout(){
    authService.logout().catchError((e){
      print('logouttttttttttttteeeeeeeeeeerrrrrrrrrrrr${e.message}');
    });
  }
}