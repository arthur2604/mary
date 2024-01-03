import 'package:flutter/material.dart';
import 'thirdpage.dart';

class NonDomesticAnimalsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Non-Domestic Animals'),
      ),
      body: Column(
        children: [
          ListTile(
            title: Text('Lion'),
            subtitle: Text('Type of Food: Meat'),
            leading: Image.asset('assets/images (3).jpg'), // Replace 'lion.jpg' with your image asset
          ),
          ListTile(
            title: Text('Tiger'),
            subtitle: Text('Type of Food: Meat'),
            leading: Image.asset('assets/images (2).jpg'), // Replace 'tiger.jpg' with your image asset
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ThirdPage(
                    questions: [
                      Question('Is this a non-domestic animal?', 'Yes', 'No', 'Domestic', 'Non-Domestic'),
                      Question('What is the food type of this animal?', 'Meat', 'Vegetables', 'Dog Food', 'Cat Food'),
                    ],
                  ),
                ),
              );
            },
            child: Text('Take Quiz'),
          ),
        ],
      ),
    );
  }
}