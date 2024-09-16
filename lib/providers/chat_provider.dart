import 'package:chatbot/models/chat_model.dart';
import 'package:chatbot/services/api_services.dart';
import 'package:flutter/foundation.dart';

class ChatProvider with ChangeNotifier {
  List<ChatModel> chatList = [];
  List<ChatModel> get getChatsList {
    return chatList;
  }

  void addUserMessage({required String message}) {
    chatList.add(ChatModel(message: message, chatIndex: 0));
    notifyListeners();
  }

  Future<void> sendMessageAndGetAnswers({required String message}) async {
    chatList.addAll(await ApiServices.sendMessage(
      message: message,
    ));
    notifyListeners();
  }
}
