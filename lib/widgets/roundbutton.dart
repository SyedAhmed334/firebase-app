// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RoundButton extends StatelessWidget {
  final bool loading;
  final String title;
  final Function()? onTap;

  RoundButton({required this.onTap, required this.title, this.loading = false});

  @override
  Widget build(BuildContext context) {
    return loading
        ? CircularProgressIndicator()
        : GestureDetector(
            onTap: onTap,
            child: Container(
              height: 50,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.amber,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Center(
                child: Text(
                  title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          );
  }
}
