import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/auth_bloc.dart';
import 'home.dart';

class LogIn extends StatefulWidget {

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  StreamSubscription? streamSubscription;

  @override
  void initState() {
    var authbloc=Provider.of<AuthBloc>(context,listen: false);
    streamSubscription = authbloc.currentUser.listen((fbUser) {
      if(fbUser!=null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>Home()));
      }
    }) as StreamSubscription<User?>;
    super.initState();
  }
  @override
  void dispose() {
    streamSubscription!.cancel();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    var authbloc=Provider.of<AuthBloc>(context);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FlatButton(
                onPressed: ()=>authbloc.loginFacebook(),
                child: Text('LogIn to facebook',style: TextStyle(fontSize: 20),),
              color: Colors.cyan,
            )
          ],
        ),
      ),

    );
  }
}