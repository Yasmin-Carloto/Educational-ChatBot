import 'package:chatbot/constants/constants.dart';
import 'package:chatbot/providers/chat_provider.dart';
import 'package:chatbot/services/assets_manager.dart';
import 'package:chatbot/widgets/chat_widget.dart';
import 'package:chatbot/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  bool _isTyping = false;
  late TextEditingController textEditingController;
  late FocusNode focusNode;
  late ScrollController _listScrollController;

  @override
  void initState() {
    textEditingController = TextEditingController();
    focusNode = FocusNode();
    _listScrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    focusNode.dispose();
    _listScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = Provider.of<ChatProvider>(context);
    return Scaffold(
        appBar: AppBar(
          elevation: 2,
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(AssetsManager.openaiLogo),
          ),
          title: const Text("ChatGPT", style: TextStyle(color: Colors.white)),
        ),
        body: SafeArea(
            child: Column(
          children: [
            Flexible(
                child: ListView.builder(
                    controller: _listScrollController,
                    itemCount: chatProvider.getChatsList.length,
                    itemBuilder: (context, index) {
                      return ChatWidget(
                        message: chatProvider.getChatsList[index].message,
                        chatIndex: chatProvider.getChatsList[index].chatIndex,
                      );
                    })),
            if (_isTyping) ...[
              const SpinKitThreeBounce(
                color: Colors.white,
                size: 18,
              ),
            ],
            const SizedBox(height: 15),
            Material(
              color: cardColor,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                        child: TextField(
                      focusNode: focusNode,
                      style: const TextStyle(color: Colors.white),
                      controller: textEditingController,
                      onSubmitted: (value) async {
                        await sendMessageFCT(chatProvider: chatProvider);
                      },
                      decoration: const InputDecoration.collapsed(
                          hintText: "Como posso te ajudar?",
                          hintStyle: TextStyle(color: Colors.blueGrey)),
                    )),
                    IconButton(
                        onPressed: () async {
                          await sendMessageFCT(chatProvider: chatProvider);
                        },
                        icon: const Icon(Icons.send, color: Colors.white))
                  ],
                ),
              ),
            ),
          ],
        )));
  }

  void ScrollListToEnd() {
    _listScrollController.animateTo(
        _listScrollController.position.maxScrollExtent,
        duration: const Duration(seconds: 2),
        curve: Curves.easeOut);
  }

  Future<void> sendMessageFCT({required ChatProvider chatProvider}) async {
    if (textEditingController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: TextWidget(label: "Digite uma mensagem antes de enviar."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    if (_isTyping) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
            TextWidget(label: "Você não pode mandar mensagens ao mesmo tempo."),
        backgroundColor: Colors.red,
      ));
      return;
    }

    try {
      String messageTextEditing = textEditingController.text;

      setState(() {
        chatProvider.addUserMessage(message: messageTextEditing);
        _isTyping = true; 
        focusNode.unfocus();
      });

      textEditingController.clear();
      await chatProvider.sendMessageAndGetAnswers(message: messageTextEditing);

      ScrollListToEnd();
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: TextWidget(label: error.toString()),
        backgroundColor: Colors.red,
      ));
    } finally {
      setState(() {
        _isTyping = false; 
      });
      ScrollListToEnd(); 
    }
  }
}
