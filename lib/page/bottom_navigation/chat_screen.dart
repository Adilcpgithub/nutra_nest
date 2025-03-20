import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:nutra_nest/auth/auth_service.dart';
import 'package:nutra_nest/core/theme/app_theme.dart';
import 'package:nutra_nest/page/bottom_navigation/bottom_navigation_screen.dart';
import 'package:nutra_nest/utity/colors.dart';
import 'package:nutra_nest/widgets/icons_widget.dart';

class ChatScreen extends StatefulWidget {
  // ignore: prefer_typing_uninitialized_variables
  final useId;
  const ChatScreen(this.useId, {super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  UserStatus userStatus = UserStatus();

  Future<void> sendMessage() async {
    if (_messageController.text.isEmpty) return;

    String senderId = await userStatus.getUserId();
    log('sender id is  $senderId');

    await _db.collection("chats").doc(senderId).collection('messages').add({
      "senderId": senderId,
      "receiverId": 'riderspot401#@@',
      "message": _messageController.text,
      "timestamp": FieldValue.serverTimestamp(),
    });

    _messageController.clear();
    await _db.collection("chats").doc(senderId).set({
      "exists": true,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: buildHeader(context),
            ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: _db
                    .collection("chats")
                    .doc(widget.useId)
                    .collection('messages')
                    .orderBy("timestamp", descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    log('kooi');
                    log(snapshot.hasError.toString());
                    return Text('Error: ${snapshot.error}');
                  }
                  if (!snapshot.hasData) {
                    log('snapshot dont have any data1');
                    return const Center(child: Text('no messagges'));
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Text('No messages');
                  }

                  var messages = snapshot.data!.docs;

                  return ListView.builder(
                    reverse: true,
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      var message = messages[index];
                      bool isMe = message['senderId'] == UserStatus.userIdFinal;
                      Timestamp? timestamp = message['timestamp'];
                      // ! Time
                      String formattedTime = '';
                      if (timestamp != null) {
                        DateTime messageTime = timestamp.toDate();
                        formattedTime =
                            DateFormat('h:mm a').format(messageTime);
                      }
                      String formattedDate = '';
                      // ! Data
                      if (timestamp != null) {
                        DateTime messageDate = timestamp
                            .toDate(); // Convert Firestore Timestamp to DateTime
                        formattedDate = DateFormat('MMMM d, y')
                            .format(messageDate); // Format to "Month Day, Year"
                      }

                      return Align(
                        alignment:
                            isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: isMe
                              ? CrossAxisAlignment.end
                              : CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 10),
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color:
                                    isMe ? Colors.blue[200] : Colors.grey[300],
                                borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(10),
                                    bottomLeft: Radius.circular(10),
                                    bottomRight: Radius.circular(10),
                                    topRight: Radius.circular(10)),
                              ),
                              child: Text(
                                message['message'],
                                style: const TextStyle(color: Colors.black),
                              ),
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: isMe ? 13 : 0, left: !isMe ? 13 : 0),
                              child: Text(
                                formattedTime, // Show formatted time
                                style: TextStyle(
                                    fontSize: 10,
                                    color: customTextTheme(context)),
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Padding(
                              padding: EdgeInsets.only(
                                  right: isMe ? 13 : 0, left: !isMe ? 13 : 0),
                              child: Text(
                                formattedDate, // Show formatted time
                                style: const TextStyle(
                                    fontSize: 10, color: Colors.grey),
                              ),
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      style: TextStyle(color: customTextTheme(context)),
                      controller: _messageController,
                      keyboardType: TextInputType.text,
                      textCapitalization: TextCapitalization.sentences,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15)),
                          hintText: "Type a message",
                          hintStyle:
                              TextStyle(color: customTextTheme(context))),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: CustomColors.green,
                    ),
                    onPressed: sendMessage,
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

Widget buildHeader(BuildContext context) {
  return Column(
    children: [
      Row(
        children: [
          CustomIcon(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (_) => const MyHomePage(setIndex: 3)),
                );
              },
              icon: Icons.arrow_back,
              iconSize: 26),
          const SizedBox(width: 92.5),
          Expanded(
            child: Text(
              '   Chat',
              style: GoogleFonts.poppins(
                fontSize: 19,
                fontWeight: FontWeight.w600,
                color: customTextTheme(context),
              ),
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 20,
      )
    ],
  );
}
