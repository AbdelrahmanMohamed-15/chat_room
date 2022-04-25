import 'package:chat_room/screens/auth_screen.dart';
import 'package:chat_room/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        canvasColor: const Color.fromRGBO(14, 22, 33, 1),
        brightness: Brightness.dark,
        buttonTheme: ButtonTheme.of(context).copyWith(
          buttonColor: Colors.teal,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)
          )
        )
      ),
      home:  StreamBuilder(stream: FirebaseAuth.instance.authStateChanges(),builder: (ctx,snapShot){
        if(snapShot.hasData){
          return const ChatScreen();
        }
        else{
          return const AuthScreen();
        }
      },),
    );
  }
}

