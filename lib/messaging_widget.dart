import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:infixedu/utils/modal/message.dart';
class MessagingWidget extends StatefulWidget {
  @override
  _MessagingWidgetState createState() => _MessagingWidgetState();
}

class _MessagingWidgetState extends State<MessagingWidget> {

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final List<Message> messages = [];
  final titleController = TextEditingController();
  final bodyController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _firebaseMessaging.onTokenRefresh.listen(sendTokenToserver);
    _firebaseMessaging.getToken();

    _firebaseMessaging.subscribeToTopic('student');

    _firebaseMessaging.configure(
      onMessage: (Map<String,dynamic> message)async{
        print('onMessage: $message');
        final notification = message['notification'];
        setState(() {
          messages.add(Message(title: notification['title'],body: notification['body']));
        });
      },
      onLaunch: (Map<String,dynamic> message) async{
        print('onLaunch: $message');
      },
      onResume: (Map<String,dynamic> message) async{
        print('onResume: $message');
      }
    );
    _firebaseMessaging.requestNotificationPermissions(
      const IosNotificationSettings(sound: true,badge: true,alert: true)
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          TextField(
            controller: titleController,
            decoration: InputDecoration(labelText: 'Title'),
          ),
          TextField(
            controller: bodyController,
            decoration: InputDecoration(labelText: 'Body'),
          ),
          RaisedButton(
            //onPressed: sentNotification,
            child: Text('Send notification to all'),
          )
        ]..addAll(messages.map(buildMessage).toList()),
      ),
    );
  }
  Widget buildMessage(Message message) => ListTile(
    title: Text(message.title),
    subtitle: Text(message.body),
  );

  void sendTokenToserver(String token) {
    print('token : $token');
  }
}
