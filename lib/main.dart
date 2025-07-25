import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:vguard/core/app_routes.dart';
import 'package:vguard/firebase_options.dart';
import 'package:vguard/pages/ask_advisor_page.dart';
import 'package:vguard/pages/crop_disease_scanner_page.dart';
import 'package:vguard/pages/disease_database_page.dart';
import 'package:vguard/pages/expert_help_page.dart';
import 'package:vguard/pages/farmer_tips_page.dart';
import 'package:vguard/pages/home_page.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // await InitialDataLoader().loadAllInitialData();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Vguard Crop Protection',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (context) => const HomePage(),
        AppRoutes.scanCrop: (context) => const CropDiseaseScannerPage(),
        AppRoutes.diseaseDatabase: (context) => const DiseaseDatabasePage(),
        AppRoutes.farmerTips: (context) => const FarmerTipsPage(),
        AppRoutes.expertHelp: (context) => const ExpertHelpPage(),
        AppRoutes.askAdvisor: (context) => const AskAdvisorPage(),
      },
    );
  }
}
