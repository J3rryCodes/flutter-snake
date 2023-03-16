import 'package:flutter/material.dart';
import 'package:snake/widgets/board.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: GameBoard());
  }
}
