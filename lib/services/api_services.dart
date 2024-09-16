import 'dart:convert';
import 'dart:io';
import 'dart:developer';
// import 'package:chatbot/constants/api_consts.dart';
import 'package:chatbot/models/chat_model.dart';
// import 'package:chatbot/models/models_model.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiServices {
  static Future<String?> _getChatGPTApikey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? savedApiKey = preferences.getString("chatgpt_api_key");

    return savedApiKey;
  }

  // static Future<List<ModelsModel>> getModels() async {
  //   String? savedApiKey = await _getChatGPTApikey();

  //   try {
  //     var response = await http.get(Uri.parse("$BASE_URL/models"),
  //         headers: {'Authorization': 'Bearer $savedApiKey'});
  //     Map jsonResponse = jsonDecode(response.body);

  //     if (jsonResponse['error'] != null) {
  //       throw HttpException(jsonResponse["error"]["message"]);
  //     }

  //     List tempList = [];
  //     for (var modelValue in jsonResponse["data"]) {
  //       tempList.add(modelValue);
  //     }

  //     return ModelsModel.modelsFromSnapshot(jsonResponse["data"]);
  //   } catch (error) {
  //     log("Error: $error");
  //     rethrow;
  //   }
  // }

  static Future<List<ChatModel>> sendMessage({required String message}) async {
    String? savedApiKey = await _getChatGPTApikey();

    try {
      var response = await http.post(
        Uri.parse("https://api.openai.com/v1/chat/completions"),
        headers: {
          'Authorization': 'Bearer $savedApiKey',
          'Content-Type': 'application/json'
        },
        body: jsonEncode({
          "model": "gpt-4o-mini",
          "messages": [
            {"role": "user", "content": message}
          ],
          "max_tokens": 400,
        }),
      );

      Map jsonResponse = jsonDecode(utf8.decode(response.bodyBytes));

      if (jsonResponse['error'] != null) {
        throw HttpException(jsonResponse["error"]["message"]);
      }

      List<ChatModel> chatList = [];
      if (jsonResponse["choices"].length > 0) {
        chatList = List.generate(
            jsonResponse["choices"].length,
            (index) => ChatModel(
                message: jsonResponse["choices"][index]["message"]["content"],
                chatIndex: 1));
      }
      return chatList;
    } catch (error) {
      log("Erro: $error");
      rethrow;
    }
  }
}
