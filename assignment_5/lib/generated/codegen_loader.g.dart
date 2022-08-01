// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String fullPath, Locale locale ) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> ru = {
  "Authorization": "Авторизація",
    "Login":"Логін",
    "Register":"Реєстрування",
    "Email" : "електрона пошта",
    "Name": "Ім'я",
    "Password": "пароль",
    "Sign_In": "Увійти",
    "Sign_Up": "Зареєструватися",
    "Update" : "Оновити",
    "Log_Out" : "Вийти",
    "Go_Back" : "Повернутись назад",
    "You_did_not_start_dialog":"Ви ще не почали діалог",
    "Create_dialog" : "Розпочати діалог",
    "Start_the_dialog":"Діалог розпочато",
    "You_have_not_started_a_dialog_with_this_user_yet": "Ви ще не розпочинали діалог з цим користувачем"
      };
static const Map<String,dynamic> en = {
  "Authorization": "Authorization",
  "Login":"Login",
  "Email": "email",
  "Register":"Register",
  "Name": "name",
  "Password": "password",
  "Sign_In": "Sign In",
  "Sign_Up": "Sign Up",
  "Update" : "Update",
  "Log_Out" : "Log out",
  "Go_Back" : "Go back",
  "You_did_not_start_dialog" : "You did not start dialog",
  "Create_dialog" : "Create dialog",
  "Start_the_dialog":"Start the dialog",
  "You_have_not_started_a_dialog_with_this_user_yet" : "You have not started a dialog with this user yet"
};
static const Map<String, Map<String,dynamic>> mapLocales = {"ru": ru,"en": en};
}
