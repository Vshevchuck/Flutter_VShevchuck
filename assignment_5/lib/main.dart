import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app.dart';
import 'generated/codegen_loader.g.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  runApp( EasyLocalization(
      assetLoader: CodegenLoader(),
      supportedLocales:  const [Locale('en'), Locale('ru')],
      path: 'assets/translation',
      fallbackLocale:  const Locale('en'),
      child: App()
  ),);
}
