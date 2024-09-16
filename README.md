# Educational Chatbot
Este projeto foi desenvolvido com a intenção de ser o Projeto de Conclusão da matéria Programação de Dispositivos Móveis II, do Curso Técnico Integrado em Informática do Instituto Federal do Ceará (IFCE) campus Fortaleza. Sendo este, um Chatbot que consome a API do ChatGPT de maneira pessoal, sendo possível configurar sua própria chave de acesso.

## Objetivo da Aplicação 🎯
A finalidade desta aplicação está em ser um Chatbot que será usado em sala de aula como objeto de estudo na matéria citada anteriormente. Nele, é possível configurar sua própria chave da API do ChatGPT e usá-la para ter acesso ao Educational Chatbot.

## Funcionalidades do Educational Chatbot 🛠️
* Adicionar sua API Key do ChatGPT pessoal.
* Fazer perguntas e obter respostas do gpt-4o-mini.

## Tecnologias Utilizadas 💻
* **Flutter**, para o desenvolvimento de uma aplicação que funciona em Android, iOS e na web (cross plataform);
* **Flutter SpinKit**, uma coleção de indicadores de carregamento animados, usado para mostrar quando a IA está respondendo;
* **Shared Preferences**, usado para armazenar a API Key do ChatGPT do usuário;
* **HTTP**, usada para realizar requisições HTTP para a API do ChatGPT;
* **Provider**, para a utilização de providers na aplicação;
* **Animated Text Kit**, animações gerais para a aplicação;
* **Remove Markdown**, para remover símbolos de Mark Down, usado para limpar a resposta da API do ChatGPT. 

## Executar aplicação localmente
1. Clone o repositório:
   ```
   git clone https://github.com/Yasmin-Carloto/Educational-Chatbot.git
   ```
2. Com o terminal aberto no diretório do projeto, digite:
    ```
    flutter pub get
    flutter pub run flutter_launcher_icons:main
    ```
3. Após, você pode configurar, em sua IDE de preferência, o simulador de um mobile (mobile emulator), [também podendo ser utilizado o **adb** para este passo](https://developer.android.com/tools/adb?hl=pt-br).
4. Com o terminal aberto no diretório do projeto, digite:
    ```
    flutter run
    ```