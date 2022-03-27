import 'package:laxia/models/m_user.dart';

class Message {
  final User? sender;
  final String? time; // Would usually be type DateTime or Firebase Timestamp in production apps
  final String? text;
  final bool? isOnline;
  final bool? unread;

  Message({
    this.sender,
    this.time,
    this.text,
    this.isOnline,
    this.unread,
  });
}

// FAVORITE CONTACTS
List<User> favorites = [sam, olivia, steven, john, greg];

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: james,
    time: '5:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: false,
    unread: true,
  ),
  Message(
    sender: olivia,
    time: '4:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: false,
    unread: true,
  ),
  Message(
    sender: john,
    time: '3:30 PM',
    text:
        'Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?',
    isOnline: false,
    unread: false,
  ),
  Message(
    sender: sophia,
    time: '2:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: false,
    unread: true,
  ),
  Message(
    sender: steven,
    time: '1:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: false,
    unread: false,
  ),
  Message(
    sender: sam,
    time: '12:30 PM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: false,
    unread: false,
  ),
  Message(
    sender: greg,
    time: '11:30 AM',
    text: 'Hey, how\'s it going? What did you do today?',
    isOnline: false,
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: james,
    time: '5:30 PM',
    text:
        'Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?Hey, how\'s it going? What did you do today?',
    isOnline: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'Just walked my doge. She was super duper cute. The best pupper!!',
    isOnline: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: '3:45 PM',
    text: 'How\'s the doggo?',
    isOnline: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: '3:15 PM',
    text: 'All the food How\'s the doggo? All the food How\'s the doggo? Nice! What kind of food did you eat?',
    isOnline: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Nice! What kind of food did you eat?',
    isOnline: false,
    unread: true,
  ),
  Message(
    sender: james,
    time: '2:00 PM',
    text: 'I ate so much food today.',
    isOnline: false,
    unread: true,
  ),
];
