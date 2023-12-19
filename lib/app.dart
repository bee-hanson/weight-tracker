import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weight_tracker/constants/routes.dart';
import 'package:weight_tracker/services/auth_service.dart';
import 'package:weight_tracker/services/firestore_weight_service.dart';
import 'package:weight_tracker/viewmodels/home_viewmodel.dart';
import 'package:weight_tracker/viewmodels/log_in_viewmodel.dart';
import 'package:weight_tracker/views/home_view.dart';

import 'views/log_in_view.dart';

class App extends StatelessWidget {
  final getIt = GetIt.instance;

  App({super.key});

  Future _initApp() async {
    await _initializeFirebase();
    _registerDependencies();
  }

  Future _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  void _registerDependencies() {
    // services
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    getIt.registerLazySingleton<AuthService>(() => AuthService(firebaseAuth));
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    getIt.registerLazySingleton<FirestoreWeightService>(
        () => FirestoreWeightService(firestore, getIt<AuthService>()));

    // viewmodels
    getIt.registerFactory<LogInViewmodel>(
        () => LogInViewmodel(getIt<AuthService>()));
    getIt.registerFactory<HomeViewmodel>(() =>
        HomeViewmodel(getIt<AuthService>(), getIt<FirestoreWeightService>()));

    // views
    getIt.registerFactory<HomeView>(() => HomeView(getIt<HomeViewmodel>()));
    getIt.registerFactory<LogInView>(() => LogInView(getIt<LogInViewmodel>()));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _initApp(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return MaterialApp(
              title: 'Weight Tracker',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              routes: {
                homeRoute: (context) => getIt<HomeView>(),
                loginRoute: (context) => getIt<LogInView>()
              },
              home: getIt<AuthService>().currentUser != null
                  ? getIt<HomeView>()
                  : getIt<LogInView>(),
              debugShowCheckedModeBanner: false,
            );
          }
          return const Center(child: CircularProgressIndicator());
        });
  }
}
