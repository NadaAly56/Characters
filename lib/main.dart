// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'routes.dart';

void main() {
  runApp(MyApp(
    router: App_Router(),
  ));
}

class MyApp extends StatelessWidget {
  final App_Router router;
  const MyApp({
    Key? key,
    required this.router,
  }) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: router.generateRoute,
      title: 'Flutter Demo',
    );
  }
}
