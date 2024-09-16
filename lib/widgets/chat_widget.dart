import 'package:chatbot/constants/constants.dart';
import 'package:chatbot/services/assets_manager.dart';
import 'package:chatbot/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:remove_markdown/remove_markdown.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.message, required this.chatIndex});

  final String message;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Material(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0
                      ? AssetsManager.userImage
                      : AssetsManager.chatImage,
                  height: 30,
                  width: 30,
                ),
                const SizedBox(width: 8),
                Expanded(
                    child: chatIndex == 0
                        ? TextWidget(label: message)
                        : DefaultTextStyle(
                            style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                                fontSize: 16),
                            child: AnimatedTextKit(
                              isRepeatingAnimation: false,
                              repeatForever: false,
                              displayFullTextOnTap: true,
                              totalRepeatCount: 1,
                              animatedTexts: [
                                TyperAnimatedText(message.removeMarkdown().trim())
                              ],
                            ),
                          )),
              ],
            ),
          ),
        )
      ],
    );
  }
}
