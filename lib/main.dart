import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nt_sixth_exam/bloc/single_state_bloc.dart';
import 'package:nt_sixth_exam/cubit/get_cards_cubit.dart';
import 'package:nt_sixth_exam/data/repository/cards_repository.dart';
import 'package:nt_sixth_exam/ui/screens/all_cards/all_cards_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarIconBrightness: Brightness.dark,
      statusBarColor: Colors.transparent,
    ),
  );
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Firebase.initializeApp();
  runApp(
    MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) =>
              CardRepository(firebaseFirestore: FirebaseFirestore.instance),
        ),
      ],
      child: MultiBlocProvider(providers: [
        BlocProvider(
          create: (context) => CardsCubit(
            context.read<CardRepository>(),
          ),
        ),
        BlocProvider(
          create: (context) => AUDStateBloc(
            cardRepository: context.read<CardRepository>(),
          ),
        ),
      ], child: const MyApp()),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AllCardsScreen(),
    );
  }
}
