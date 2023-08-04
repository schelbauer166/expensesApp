import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class AdaptiveTextField extends StatelessWidget {
  final TextEditingController controllerRe;
  final String inputLabel;
  final Function(String)? onSubmit;
  final TextInputType keyboardType;

  AdaptiveTextField({
    required this.controllerRe,
    required this.inputLabel,
    required this.onSubmit,
    required this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoTextField(
            controller: controllerRe,
            placeholder: inputLabel,
            // por causa do IOS coloca decimal true
            keyboardType: keyboardType,
            //Voce chama o submite quando da ok no teclado
            onSubmitted: onSubmit,
          )
        : TextField(
            controller: controllerRe,
            decoration: InputDecoration(labelText: inputLabel),
            // por causa do IOS coloca decimal true
            keyboardType: keyboardType,
            //Voce chama o submite quando da ok no teclado
            onSubmitted: onSubmit,
          );
  }
}
