import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FormError extends StatelessWidget {
  const FormError({
    super.key,
    required this.errors,
  });

  final List<String> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
        children: List.generate(errors.length, (index) => formErrorText(error: errors[index]))
    );
  }

  Padding formErrorText({required String error}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 9.0),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
        ),
        child: Row(
          children: [
            const Icon(CupertinoIcons.clear_circled, color: Colors.redAccent,),
            const SizedBox(width: 10,),
            Text(error, style: const TextStyle(color: Colors.redAccent),)
          ],
        ),
      ),
    );
  }
}