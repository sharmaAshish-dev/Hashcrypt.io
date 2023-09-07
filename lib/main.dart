import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hashcrypt/theme/app_theme.dart';
import 'package:hashcrypt/values/strings.dart';
import 'package:layout/layout.dart';

import 'pages/hash_crypt.dart';

final isLightTheme = StateProvider<bool>((ref) => true);

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Layout(
      child: MaterialApp(
        title: Strings.APP_TITLE,
        theme: AppTheme.lightThemeData,
        home: const Hashcrypt(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
