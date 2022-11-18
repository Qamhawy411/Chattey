class Message{
 final String  message;
 final String id;
 Message(this.message,this.id);
 factory Message.json(data){
  return Message(data["message"],data["id"]);
 }
}