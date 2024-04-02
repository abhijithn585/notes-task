import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task/controller/auth_provider.dart';
import 'package:task/controller/firebase_provider.dart';
import 'package:task/firebase_options.dart';
import 'package:task/view/auth_gate.dart';

void main(List<String> args) async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => FirestoreProvider(),
        ),
        ChangeNotifierProvider(create: (context) => AuthProviders(),)
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home:AuthGate(),
      ),
    );
  }
}
