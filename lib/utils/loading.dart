import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<T?> showLoading<T extends Object?>({required BuildContext context}) {
  return showGeneralDialog(
    context: context,
    barrierDismissible: false,
    transitionDuration: Duration(milliseconds: 300),
    barrierColor: Colors.black.withOpacity(0.3),
    pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
      return Center(
        child: SizedBox(
          child: CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            strokeWidth: 6
          ),
          width: 100,
          height: 100,
        ),
      );
    }
  );
}

// ignore: non_constant_identifier_names
Widget get LoadingWidget => Container(
  color: Colors.black.withOpacity(0.2),
  child: Center(
    child: SizedBox(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
        strokeWidth: 6
      ),
      width: 100,
      height: 100,
    ),
  ),
);