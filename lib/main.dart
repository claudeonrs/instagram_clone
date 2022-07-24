import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:instagram_clone/responsive/responsive_layout_screen.dart';
import 'package:instagram_clone/screens/login_screen.dart';
import 'package:instagram_clone/screens/signup_screen.dart';
import 'package:instagram_clone/utils/colors.dart';
import 'package:instagram_clone/responsive/screens_layout/all.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    // if web platform
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: "AIzaSyDyZi6tkACV6G5kSk5gGrCHjZaUDv3Xuno",
      appId: "1:314231666416:web:fb7fa1d0605f4d56bb3435",
      messagingSenderId: "314231666416",
      projectId: "instagram-clone-421d4",
      storageBucket: "instagram-clone-421d4.appspot.com",
    ));
  } else {
    await Firebase
        .initializeApp(); // if mobile platform, has been initialized in the ios and android setup stage
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Deon's & Andre's IG Clone",
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: mobileBackgroundColor,
      ),
      // home: const ResponsiveLayout(
      //   mobileScreenLayout: MobileScreenLayout(),
      //   webScreenLayout: WebScreenLayout(),
      // ),
      home: SignupScreen(),
    );
  }
}
