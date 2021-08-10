import 'package:moyori/presentation/model/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Splash extends StatelessWidget {
  static const routeName = '/';

  static Widget provide() => ChangeNotifierProvider<SplashPageModel>(
    create: (BuildContext context) => SplashPageModel(context: context)..instantiate(),
    child: Splash()
  );

  @override
  Widget build(BuildContext context) {
    final SplashPageModel _ = Provider.of(context);
    return Scaffold(
      body: Container(
        color: Color(0xFFf3584e),
        child: Center(
          child: SizedBox(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              strokeWidth: 6
            ),
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }
}