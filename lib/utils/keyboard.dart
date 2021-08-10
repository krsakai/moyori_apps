import 'package:flutter/material.dart';
import 'package:keyboard_actions/keyboard_actions.dart';

KeyboardActionsConfig keyboardActionConfig(FocusNode forcusNode) {
  return KeyboardActionsConfig(
    keyboardActionsPlatform: KeyboardActionsPlatform.ALL,
    nextFocus: false,
    actions: [
      KeyboardActionsItem(focusNode: forcusNode, toolbarButtons: [
        (node) {
          return GestureDetector(
            onTap: () => node.unfocus(),
            child: Container(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "閉じる",
                style: TextStyle(color: Colors.black),
              ),
            ),
          );
        }
      ])
    ],
  );
}