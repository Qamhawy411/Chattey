import 'package:chattey/Screens/chatScreen.dart';
import 'package:chattey/Screens/goinus.dart';
import 'package:chattey/shared%20widget/textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:community_material_icon/community_material_icon.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:chattey/functions/Showsnackbar.dart';

class loginScreen extends StatefulWidget {
  const loginScreen({super.key});

  @override
  State<loginScreen> createState() => _loginScreenState();
}

class _loginScreenState extends State<loginScreen> {
  bool isLoading=false;
  String? loginPass;
  String? loginEmail;
  TextEditingController userController = TextEditingController();
  TextEditingController passController = TextEditingController();
  GlobalKey<FormState> usernamekey = GlobalKey<FormState>();
  GlobalKey<FormState> passkey = GlobalKey<FormState>();
  GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
                          image: AssetImage("assets/logo.jpg"),
                          fit: BoxFit.contain),
                      shape: BoxShape.circle),
                )),
            Positioned(
                top: 270,
                right: 30,
                left: 30,
                child: Text(
                  "Welcome to Chattey again!",
                  style: TextStyle(color: Colors.deepOrange, fontSize: 27,fontWeight: FontWeight.w900),
                )),
            Positioned(
                top: 300,
                right: 10,
                left: 10,
                child: Container(
                  width: 200,
                  height: 400,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: Colors.white),
                  child: Form(
                    key: _formkey,
                    autovalidateMode: AutovalidateMode.always,
                    child: ListView(
                      children: [
                        readyform(Ready(
                          d:((x) {
                            loginEmail=x;
                          }) ,
                          f: (value) {
                            if (value!.isEmpty){
                              return "This Field is Required ";
                            }
                                 
                          },
                            key: usernamekey,
                            labelname: "User Name",
                            iconprefix: Icons.email,
                            controller: userController)),
                        readyform(Ready(
                          d: ((x) {
                            loginPass=x;
                          }),
                           f: (value) {
                            if (value!.isEmpty){
                              return "This Field is Required   ";
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
                              style: TextStyle(color: Colors.pink, fontSize: 20,fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        TextButton(
                            onPressed: () async{
                                if (!_formkey.currentState!.validate()) {
                                   showSnackBar(context," Some Fields Required  ");
                                }else{
                                  setState(() {
                                    isLoading=true;
                                  });
                                try{
                             UserCredential goinUser=  await FirebaseAuth.instance.signInWithEmailAndPassword(email:loginEmail! , password: loginPass!);
                                  showSnackBar(context,"success Register");
                                  Navigator.of(context).pushReplacementNamed("chatpage",arguments:loginEmail);
                               }on FirebaseAuthException catch (e) {
                                  if (e.code == 'user-not-found') {
                                   showSnackBar(context,'No user found for that email.');} 
                                      else if (e.code == 'wrong-password') {
                                           showSnackBar(context,'Wrong password provided for that user.');}
                                       else{ showSnackBar(context,"SomeThing Erorr or No Connection");}
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
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(25)),
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(50, 8, 0, 0),
                                child: Text(
                                  "LOGIN",
                                  style:
                                      TextStyle(color: Colors.white, fontSize: 30),
                                ),
                              ),
                            )),
                        InkWell(
                          onTap: () {Navigator.of(context).push(MaterialPageRoute(builder: (context){return GoinUsScreen();} ));},
                          child: Align(
                            alignment: Alignment.center,
                            child: Text(
                              " Don't Have an account ? Sign up  ",
                              style: TextStyle(color: Colors.red, fontSize: 20,fontWeight: FontWeight.w900),
                            ),
                          ),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            " \n or SignIn with  ",
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
