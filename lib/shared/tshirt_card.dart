import 'package:flutter/material.dart';

class TshirtCard extends StatelessWidget {
  const TshirtCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      
      child: Container(
        
        child: Column(
          children: [
            Image.network(''),
            Text('Name'),
            Text('Description'),
            Text('Price')
          ],
        ),
      ),
    );
  }
}