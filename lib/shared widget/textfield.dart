import 'package:flutter/material.dart';

OutlineInputBorder readyborder(Color color) {
  return OutlineInputBorder(
      borderRadius: BorderRadius.circular(20),
      borderSide: BorderSide(color: color));
}

enum Secure{password,text}

class Ready {
  String labelname;
  String hintText;
  final IconData? iconprefix;
  bool issecure;
  Secure pass;
  TextEditingController? controller;
  Key? key;
  String? Function(String?)? f;
  void Function(String)? d;
  

  Ready(
      {required this.d, 
         required this.f ,
         this.key,
        this.controller,this.labelname = "",
      this.hintText = "",
      this.iconprefix,
      this.issecure = false,this.pass=Secure.text});
}

class readyform extends StatefulWidget {
  final Ready form;
  const readyform(this.form, {super.key});

  @override
  State<readyform> createState() => _readyformState();
}

class _readyformState extends State<readyform> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        onChanged:(widget.form.d) ,
         validator:( widget.form.f
       
        ),
        decoration: InputDecoration(
            border: readyborder(Colors.green),
            enabledBorder: readyborder(Colors.blue),
            errorBorder: readyborder(Colors.red),
            prefixIcon: Icon(widget.form.iconprefix),
            labelText: widget.form.labelname,
            hintText: widget.form.hintText,
            suffixIcon: widget.form.pass==Secure.password?IconButton(
                    icon: Icon(
                      Icons.remove_red_eye,
                    ),
                    onPressed: () {
                      setState(() { 
                        widget.form.issecure=!widget.form.issecure;
                      });
                    },
                  ):null
                
                ),
              obscureText:widget.form.issecure ,
              controller: widget.form.controller,
              



      ),
    );
  }
}
