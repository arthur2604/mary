import 'package:flutter/material.dart';
import 'thirdpage.dart';

class DomesticAnimalsPage extends StatelessWidget {
  const DomesticAnimalsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Domestic Animals'),
      ),
      body: Column(
        children: [
          ListTile(
            title: const Text('Cat'),
            subtitle: const Text('Type of Food: Cat Food'),
            leading: Image.asset('assets/ images (2).jpg'), // Replace 'cat.jpg' with your image asset
          ),
          ListTile(
            title: const Text('Dog'),
            subtitle: const Text('Type of Food: Dog Food'),
            leading: Image.asset('assets/images (1).jpg'), // Replace 'dog.jpg' with your image asset
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThirdPage(
                    questions: [
                      Question('Is this a domestic animal?', 'Yes', 'No', 'Domestic', 'Non-Domestic'),
                      Question('What is the food type of this animal?', 'Cat Food', 'Dog Food', 'Meat', 'Vegetables'),
                    ],
                  ),
                ),
              );
            },
            child: const Text('Take Quiz'),
          ),
        ],
      ),
    );
  }
}