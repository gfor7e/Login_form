import 'package:flutter/material.dart';
import '../api/api_service.dart';

class InfoPage extends StatelessWidget {
   @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        alignment: Alignment.center,
        decoration:
          ShapeDecoration(
          color: Colors.white,
          shape:
            Border.all(
              color: Colors.blue,
              width: 20.0,),
          ),
          child: Text('You are successfully signed to \n$domain as $user',
                      textAlign: TextAlign.center,
                      ),
          )   
      );
      
  }
}
