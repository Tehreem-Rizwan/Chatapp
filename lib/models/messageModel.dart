class MessageModel {
  String? messageid;
  String? sender;
  String? text;
  DateTime? createdon;
  bool? seen;
  MessageModel(
      {this.sender, this.createdon, this.seen, this.text, this.messageid});
  MessageModel.fromMap(Map<String, dynamic> map) {
    messageid = map['messageid'];
    sender = map['sender'];
    text = map['text'];
    createdon = map['createdon'].toDate();
    seen = map['seen'];
  }
  Map<String, dynamic> toMap() {
    return {
      'messageid': messageid,
      'sender': sender,
      'text': text,
      'createdon': createdon,
      'seen': seen
    };
  }
}
