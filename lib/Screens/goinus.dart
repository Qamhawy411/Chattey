import 'package:chattey/shared%20widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chattey/functions/Showsnackbar.dart';

import 'chatScreen.dart';
class GoinUsScreen extends StatefulWidget {
  const GoinUsScreen({super.key});

  @override
  State<GoinUsScreen> createState() => _GoinUsScreenState();
}

class _GoinUsScreenState extends State<GoinUsScreen> {
  String? logEmail;
  String? logPass;
  bool isLoading=false;
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  GlobalKey<FormState> usernamekey = GlobalKey<FormState>();
  GlobalKey<FormState> passkey = GlobalKey<FormState>();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  GlobalKey<FormState> namekey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.purple, Colors.white],
                      begin: Alignment.bottomLeft,
                      end: Alignment.topCenter)),
            ),
            Positioned(
                top: 50,
                right: 10,
                left: 10,
                child: Container(
                  width: 500,
                  height: 200,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/logo2.jfif"),
                          fit: BoxFit.contain),
                      shape: BoxShape.circle),
                )),
            Positioned(
                top: 250,
                right: 30,
                left: 30,
                child: Text(
                  "Welcome to  Goining Chattey ",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 25,fontWeight: FontWeight.w900),
                )),
            Positioned(
                top: 280,
                right: 10,
                left: 10,
                child: Container(
                  width: 200,
                  height: 470,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  child: Form(
                    key: _formkey,
                    autovalidateMode: AutovalidateMode.always,
                    child: ListView(
                      children: [
                        readyform(Ready(
                          d: ((p0) {
                            logEmail=p0;
                          }),
                          f: (value) {
                            if (value!.isEmpty){
                              return "This Field is Required ";
                            }
                                 
                          },
                            key: namekey,
                            labelname: "User Name",
                            iconprefix: Icons.email,
                            controller: userController)),
                        readyform(Ready(
                          d: (p0) {
                            logPass=p0;
                          },
                           f: (value) {
                            if (value!.isEmpty){
                              return "This Field is Required   ";
                            }else if (value.contains("#")){
                              return "This Field is  contain #  ";
                            }
                                 
                          },
                            key: passkey,
                            labelname: "PassWord",
                            issecure: true,
                            iconprefix: Icons.lock,
                            pass: Secure.password,
                            controller: passController)),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: InkWell(
                            onTap: () {},
                            child: Text(
                              "forget password?  ",
                              style: TextStyle(color: Colors.pink, fontSize: 20),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () async{
                              if (!_formkey.currentState!.validate()) {
                                 showSnackBar(context ," Some Fields Required  ");
                                
                              }else{
                                setState(() {
                                  isLoading=true;
                                });
                              try{
                                
                                
                           UserCredential goinUser=  await FirebaseAuth.instance.createUserWithEmailAndPassword(email:logEmail! , password: logPass!);
                                showSnackBar(context,"success Register");
                                 Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context){return ChatBage();}));
                             }on FirebaseAuthException catch (e) {
                                if (e.code == 'user-not-found') {
                                 showSnackBar(context,'No user found for that email.');} 
                                    else if (e.code == 'wrong-password') {
                                         showSnackBar(context,'Wrong password provided for that user.');}
                                     else if (e.code == 'email-already-in-use') {
                                      showSnackBar(context,'email address used by another account');
                                     }else{ showSnackBar(context,"SomeThing Erorr or No Connection");}
                                      }
                                      setState(() {
                                  isLoading=false;
                                });

                                      }
                                      
                            },
                            child: Container(
                              height: 50,
                              width: 200,
                              decoration: BoxDecoration(
                                  color: Color.fromARGB(255, 82, 91, 112),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(50, 8, 0, 0),
                                child: Text(
                                  "Goin Us",
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 30),
                                ),
                              ),
                            )),
                        InkWell(
                          onTap: () {Navigator.of(context).pop();},
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              " Already have An Account ? Login ! ",
                              style: TextStyle(color: Colors.red, fontSize: 20,fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            " \n or Signin  with  ",
                            style: TextStyle(color: Colors.pink, fontSize: 20,fontWeight: FontWeight.w900),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            
                            IconButton(
                              onPressed: () {},
                              icon: Icon(CommunityMaterialIcons.twitter,
                                  size: 35, color: Colors.blue),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(
                                CommunityMaterialIcons.google,
                                size: 35,
                                 color: Color(0xffD03B3C),
                              ),
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: Icon(CommunityMaterialIcons.facebook,
                                  size: 35, color: Color(0xff3E5591)),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

 
}


