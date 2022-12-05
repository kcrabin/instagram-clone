class ChatRoomodel {
  String? chatroomid;
  Map<String, dynamic>? participants;
  String? lastMessage;

  ChatRoomodel({this.chatroomid, this.participants, this.lastMessage});

  ChatRoomodel.fromMap(Map<String, dynamic> map) {
    chatroomid = map['chatroomid'];
    participants = map['participants'];
    lastMessage = map['lastMessage'];
  }

  Map<String, dynamic> toMap() {
    return {
      'chatroomid': chatroomid,
      'participants': participants,
      'lastMessage': lastMessage
    };
  }
}
