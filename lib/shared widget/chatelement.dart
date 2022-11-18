import 'package:chattey/models/messagemodel.dart';
import 'package:flutter/material.dart';

class chatElement extends StatelessWidget {
  final Message message;
  const chatElement(this.message,{super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 7, 40, 7),
        padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
        decoration: BoxDecoration(
            color: Colors.purple,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: Text(
        message.message,
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}





class chatElement2 extends StatelessWidget {
  final Message message;
  const chatElement2(this.message,{super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.fromLTRB(10, 7, 40, 7),
        padding: EdgeInsets.fromLTRB(15, 30, 15, 30),
        decoration: BoxDecoration(
            color: Colors.pink[200],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20),
              topRight: Radius.circular(20),
              bottomRight: Radius.circular(20),
            )),
        child: Text(
        message.message,
          style: TextStyle(
              color: Colors.white, fontSize: 22, fontWeight: FontWeight.w900),
        ),
      ),
    );
  }
}
