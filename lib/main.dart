import 'package:fb/bloc/auth_bloc.dart';
import 'package:fb/login.dart';
import 'package:fb/services/auth_services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp( MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

            return Provider(
              create: (context)=>AuthBloc(),
              child: MaterialApp(
                theme: ThemeData(
                  primarySwatch: Colors.blue,
                ),
                home:  LogIn(),
              ),
            );

  }
}




