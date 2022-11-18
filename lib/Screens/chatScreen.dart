import 'package:chattey/models/messagemodel.dart';
import 'package:chattey/shared%20widget/chatelement.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatBage extends StatefulWidget {
  const ChatBage({super.key});

  @override
  State<ChatBage> createState() => _ChatBageState();
}

class _ChatBageState extends State<ChatBage> {
  final ScrollController _controller = ScrollController();
  TextEditingController messageController= TextEditingController();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference users = FirebaseFirestore.instance.collection('chatting');
  @override
  Widget build(BuildContext context) {
   String email= ModalRoute.of(context)!.settings.arguments as String;
    return StreamBuilder<QuerySnapshot>(
      stream:users.orderBy("time",descending: true).snapshots() ,
      builder: (context, snapshot) {
       if(snapshot.hasData){
       List<Message> actualMessage=[];
       for(int i=0; i<snapshot.data!.docs.length;i++){
            actualMessage.add(Message.json(snapshot.data!.docs[i]));
       }
       return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.purple,
          title: Text(
            "Chattey",
            style: TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w900),
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: ListView.builder(
                   reverse: true   ,
                controller: _controller,
                  itemCount: actualMessage.length,
                  itemBuilder: ((context, index) {
                    return chatElement(actualMessage[index]);
                  })),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: TextField(
                controller:messageController ,
                onSubmitted: ((value) {
                  users.add({"message":value,"time":DateTime.now(),"id":email}
                  );
                  messageController.clear();
                   _controller.animateTo(
                    //  _controller.position.maxScrollExtent,
                    0,
                        duration: Duration(seconds: 2),
                                 curve: Curves.fastOutSlowIn,
                                );
              }
              
              ),
                decoration: InputDecoration(hintText: " Send Message",
                    suffixIcon:IconButton (icon:Icon(Icons.send),color: Colors.purple,onPressed: (){},),
                  border: border(Colors.purple),
                  enabledBorder: border(Colors.purple)
                ),
              ),
            ),
          ],
        ));
     }else{ return Text("Loading.....");}
      
    });
  }
 OutlineInputBorder border(Color color){
   return 
          OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
          borderSide: BorderSide(color: color),
        )
                ;
  }
}
