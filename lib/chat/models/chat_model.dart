import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ktalk/common/models/base_model.dart';

import '../../auth/models/user_model.dart';

class ChatModel extends BaseModel{
  ChatModel({
    required super.id,
    super.lastMessage = '',
    required super.userList,
    required super.createAt,
  });

  factory ChatModel.intit(){
    return ChatModel(
        id: '',
        userList: [],
        createAt: Timestamp.now(),
    );
  }

  Map<String, dynamic> toMap(){
    return {
      'id': id,
      'lastMessage': lastMessage,
      'userList': userList.map<String>((e) => e.uid).toList(),
      'createAt': createAt,
    };
  }

  factory ChatModel.fromMap({
    required Map<String, dynamic> map,
    required List<UserModel> userList,
}){
    return ChatModel(
        id: map['id'],
        userList: map['lastMessage'],
        createAt: map['createAt']);
  }
}