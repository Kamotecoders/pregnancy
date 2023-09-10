import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pregnancy/app_router.dart';
import 'package:pregnancy/repositories/auth_repository.dart';
import 'package:pregnancy/repositories/user_repository.dart';
import 'package:pregnancy/styles/color_pallete.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => UserRepository(),
        ),
      ],
      child: MaterialApp.router(
        title: 'PregnancyApp',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: ColorStyle.primary),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        routerConfig: AppRouter().router,
      ),
    );
  }
}
