import 'package:flutter/material.dart';

AppBar customAppBar(  context,{ required String title}) {
    return AppBar(
      backgroundColor: Colors.white ,
      leading: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back_ios)),
      centerTitle: true,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontWeight: FontWeight.bold ),
      ),
    );
  }