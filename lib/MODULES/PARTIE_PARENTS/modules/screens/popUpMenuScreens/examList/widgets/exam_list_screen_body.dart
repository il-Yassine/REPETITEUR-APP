import 'package:flutter/material.dart';

class ExamListScreenBody extends StatefulWidget {
  const ExamListScreenBody({super.key});

  @override
  State<ExamListScreenBody> createState() => _ExamListScreenBodyState();
}

class _ExamListScreenBodyState extends State<ExamListScreenBody> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Center(child: Text("data"),));
  }
}
