import 'package:chatbot/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InsertApiKeyScreen extends StatefulWidget {
  const InsertApiKeyScreen({super.key});

  @override
  _InsertApiKeyScreenState createState() => _InsertApiKeyScreenState();
}

class _InsertApiKeyScreenState extends State<InsertApiKeyScreen> {
  final _insertApiKeyScreenController = TextEditingController();
  bool isThereError = false;
  String errorMessage = '';

  void setError(String message) {
    setState(() {
      isThereError = true;
      errorMessage = message;
    });
  }

  void clearError() {
    setState(() {
      isThereError = false;
      errorMessage = '';
    });
  }

  bool _validateApiKey(String apiKey) {
    if (apiKey.isEmpty) {
      setError('Você precisa digitar sua API key do ChatGPT.');
      return false;
    }
    if (!apiKey.startsWith('sk-')) {
      setError('A chave de API deve começar com "sk-".');
      return false;
    }
    if (apiKey.length < 51) {
      setError('A chave de API deve ter ao menos 51 caracteres.');
      return false;
    }
    clearError();
    return true;
  }

  @override
  void initState() {
    super.initState();
    _loadApiKey();
  }

  Future<void> _loadApiKey() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    String? savedApiKey = preferences.getString("chatgpt_api_key");
    if (savedApiKey != null) {
      _insertApiKeyScreenController.text = savedApiKey;
    }
  }

  Future<void> _saveApiKeyAndProceed() async {
    String apiKey = _insertApiKeyScreenController.text;
    if (_validateApiKey(apiKey)) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      await preferences.setString("chatgpt_api_key", apiKey);

      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => const ChatScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            TextField(
              controller: _insertApiKeyScreenController,
              cursorColor: const Color.fromARGB(255, 163, 163, 163),
              decoration: InputDecoration(
                  hintText: "Digite sua chave de acesso a API do ChatGPT aqui...",
                  hintStyle: const TextStyle(
                      color: Color.fromARGB(255, 163, 163, 163)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    borderSide: const BorderSide(width: 0, style: BorderStyle.solid),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 46, 117, 152),
                      width: 2.0,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(100.0),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 75, 195, 255),
                      width: 2.0,
                    ),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      _insertApiKeyScreenController.clear();
                    },
                    icon: const Icon(Icons.clear),
                    color: const Color.fromARGB(255, 163, 163, 163),
                  )),
              style: const TextStyle(fontSize: 16.0, color: Colors.white),
            ),
            const SizedBox(height: 14),
            isThereError
                ? Text(
                    errorMessage,
                    style: const TextStyle(color: Colors.redAccent),
                  )
                : const SizedBox.shrink(),
            isThereError
                ? const SizedBox(height: 12)
                : const SizedBox.shrink(),
            ElevatedButton(
              onPressed: _saveApiKeyAndProceed,
              style: ElevatedButton.styleFrom(
                  foregroundColor: const Color.fromARGB(255, 88, 88, 88),
                  backgroundColor: const Color.fromARGB(255, 147, 205, 234),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4))),
              child: const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.0, vertical: 12.0),
                child: Text(
                  "Acessar Chatbot",
                  style: TextStyle(fontSize: 14.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
