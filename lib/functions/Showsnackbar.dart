
import 'package:flutter/material.dart';




void showSnackBar(BuildContext owncontext,String message ){

     ScaffoldMessenger.of(owncontext)
        .showSnackBar(
          SnackBar(backgroundColor: Colors.red,
      content: Text(textAlign: TextAlign.center,
        message,
        style: TextStyle(
            color: Colors.white, fontSize: 18,fontWeight: FontWeight.w900),
      ),
    ));
    

}