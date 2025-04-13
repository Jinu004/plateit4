import 'package:flutter/material.dart';

class MealsPage extends StatelessWidget {
  const MealsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(

      appBar: AppBar(

        backgroundColor: Colors.teal,
        title: Text('Meals Page'),
        centerTitle: true,

      ),
      body: Center(
        child: Text('Meals Page'),
      ),
    );
  }
}