import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:intl/intl.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

final _fireStore = FirebaseFirestore.instance;
User firebaseUser;

class _ChatScreenState extends State<ChatScreen> {
  final _auth = FirebaseAuth.instance;
  String _message;
  DateTime now;


  final TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
    getCurrentUser();
  }

  void getCurrentUser() {
    if(_auth.currentUser != null){
      firebaseUser = _auth.currentUser;
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBubble(),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[

                  Expanded(
                    child: TextField(
                      controller: messageController,
                      onChanged: (value) {
                        _message = value;
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),

                  FlatButton(
                    onPressed: () {
                      messageController.clear();
                     _fireStore.collection("message").add({
                       'text':_message,
                       'sender':firebaseUser.email,
                       'dateTime':DateTime.now()
                     });
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StreamBubble extends StatelessWidget {
  final DateFormat formattedDate = DateFormat('dd/MM/yyyy hh:mm:ss');

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: _fireStore.collection('message').orderBy('dateTime',descending: true).snapshots(),
      builder: (context,snapshot){
        if(!snapshot.hasData){
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        final messages = snapshot.data.docs;
        List<BubbleMessage> texts =[];
        for(var message in messages){
          final msg = message['text'];
          final sender = message['sender'];
          final Timestamp timeStamp = message['dateTime'];
          final dateTime = new DateTime.fromMicrosecondsSinceEpoch(timeStamp.microsecondsSinceEpoch);
          texts.add(
              BubbleMessage(
                msg: msg,
                sender: sender,
                formattedTime: formattedDate.format(dateTime),
              )
          );
        }
        return Expanded(
            child: ListView(
                children: texts,
                 reverse: true,
            )
        );
      },
    );
  }
}

class BubbleMessage extends StatelessWidget {
  final String sender;
  final String msg;
  final String formattedTime;
  final bool isMe;

  BubbleMessage({this.sender,this.msg,this.formattedTime}):
        this.isMe = sender == firebaseUser.email;
//        this.alignment = isMe ?CrossAxisAlignment.end:CrossAxisAlignment.start,

  @override
  Widget build(BuildContext context) { 
    return  Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: isMe ? CrossAxisAlignment.end:CrossAxisAlignment.start,
            children: [
              Text(sender,style: TextStyle(fontSize: 10,color: Colors.black38),),
              Text(
                formattedTime,
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black38),
              ),
              Material(
                  color: isMe ? Colors.lightBlue: Colors.red,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(15.0),
                      topRight: Radius.circular(15.0),
                      bottomRight: isMe ? Radius.zero : Radius.circular(15.0),
                      bottomLeft: isMe ? Radius.circular(15.0):Radius.zero,
                  ),
                  elevation: 5.0,
                  child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.0, horizontal:20.0),
                      child: Text(
                          msg,
                          style: TextStyle(color: Colors.white),
                      )
                  )
              ),

            ]),
      );

  }
}
