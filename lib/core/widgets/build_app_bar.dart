 import 'package:flutter/material.dart';
import 'package:fruts_e_commerce/core/widgets/notification_widget.dart';

AppBar buildAppBar(context , { required String title , bool showBackButton = true}) {
    return AppBar(
      backgroundColor: Colors.white,
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: NotificationWidget(),
        ),
      ],

      elevation: 0,
      centerTitle: true,
      title: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 19,
          fontWeight: FontWeight.bold,
        ),
      ),

      leading: Visibility(
        visible: showBackButton,
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios)
        ),
      ),
    );
  }
