import 'package:flutter/material.dart';
import '../widgets/letter_form.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: LetterForm(),
    );
  }
} 