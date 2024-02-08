// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class InputBox extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType textInputType;
  const InputBox({super.key, required this.controller, required this.hintText, required this.prefixIcon, required this.textInputType});

  @override
  State<InputBox> createState() => _InputBoxState();
}

class _InputBoxState extends State<InputBox> {
  bool pass = false;
  bool showPass = false;

  @override
  void initState() {
    super.initState();
    if(widget.hintText == "Password") {
      setState(() {
        pass = true;
      });
    }
  }

  void changeVisibility() {
    setState(() {
      showPass = (showPass == true) ? false : true;
    });
  }

  @override
  Widget build(BuildContext context) {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.deepPurple, width: 2)
    );
    return TextField(
      controller: widget.controller,
      obscureText: showPass,
      keyboardType: widget.textInputType,
      style: TextStyle(color: Colors.black, fontSize: 20),
      decoration: InputDecoration(
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        labelStyle: TextStyle(color: Colors.grey.shade800),
        alignLabelWithHint: true,
        labelText: widget.hintText,
        floatingLabelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 25),
        prefixIcon: Icon(widget.prefixIcon, color: Colors.deepPurple, size: 20),
        suffixIcon: (widget.hintText != "Password")
        ? null
        : IconButton(onPressed: changeVisibility, icon: Icon((showPass) ? Icons.visibility : Icons.visibility_off, color: Colors.grey)),
      ),
    );
  }
}
