import 'package:flutter/material.dart';

class Tutors extends StatefulWidget {
  const Tutors({Key? key}) : super(key: key);
  @override
  State<Tutors> createState() => _TutorsState();
}

class _TutorsState extends State<Tutors> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tutors List'),
      ),
    );
  }
}
