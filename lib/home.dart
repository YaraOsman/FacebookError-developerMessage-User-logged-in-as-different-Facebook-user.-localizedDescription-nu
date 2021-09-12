import 'dart:async';
import 'package:fb/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'bloc/auth_bloc.dart';


class Home extends StatefulWidget {
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late StreamSubscription? streamSubscription;

  @override
  void initState() {
    var authbloc=Provider.of<AuthBloc>(context,listen: false);
    streamSubscription = authbloc.currentUser.listen((fbUser) {
      if(fbUser==null){
        Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>LogIn()));
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
    var authbloc=Provider.of<AuthBloc>(context,listen: false);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage('https://th.bing.com/th/id/OIP.LsFhAwzXEWuJL-goNDLseAHaF7?w=218&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7'),
            ),
            FlatButton(
                onPressed: ()=>authbloc.logout(),
                child: Text('LogOut from facebook',style: TextStyle(fontSize: 20),),
              color: Colors.cyan,
            )
          ],
        ),
      ),

    );
  }
}