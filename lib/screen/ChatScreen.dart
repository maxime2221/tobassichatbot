import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tobassichatbot/screen/HomeScreen.dart';
import 'package:tobassichatbot/screen/profile_screen.dart';
import 'package:http/http.dart' as http;
import 'package:tobassichatbot/widgets/chatbubble.dart';

class Chatscreen extends StatefulWidget{

    final bool isDarkMode;
    final String text;
    
    Chatscreen({required this.isDarkMode,required this.text});

    @override
    _ChatScreenState createState() => _ChatScreenState();

}

class _ChatScreenState extends State<Chatscreen> {

  final TextEditingController _textController = TextEditingController();
   bool _isButtonVisible = false; //pour le bouton Plus....
  final List<Map<String, dynamic>> _messages = []; // Messages du chat

  @override
  void initState() {
    super.initState();
    _sendMessage(widget.text);
    _textController.addListener(() {
      setState(() {
        _isButtonVisible = _textController.text.isNotEmpty;
      });
    });
  }

  Future<String> getBotResponse(String message) async {
    const apiUrl = 'https://api.dialogflow.com/v1/query?v=20150910'; // Remplacez par l'URL Dialogflow
    const token = 'YOUR_DIALOGFLOW_API_KEY'; // Votre clé API Dialogflow

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        "query": message,
        "lang": "fr",
        "sessionId": "12345678", // ID unique pour la session
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['result']['fulfillment']['speech'] ?? "Pas de réponse.";
    } else {
      throw Exception('Erreur API Dialogflow');
    }
  }

  void _sendMessage(String message) async {
    final userMessage = message;
    if (userMessage.isEmpty) return;

    setState(() {
      _messages.add({"text": userMessage, "isUser": true});
    });

    _textController.clear();

    try {
      final botResponse = await getBotResponse(userMessage);
      setState(() {
        _messages.add({"text": botResponse, "isUser": false});
      });
    } catch (e) {
      setState(() {
        _messages.add({"text": "Erreur : Impossible d'obtenir une réponse.", "isUser": false});
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode? Colors.black:Colors.white,
        appBar: AppBar(
          centerTitle: true,
          iconTheme: IconThemeData(color: widget.isDarkMode? Colors.white:Colors.black),
          backgroundColor: widget.isDarkMode? Colors.black:Colors.white,        
          title: const Text(
            'TobassiChatBot',
            style: TextStyle(
              color:Colors.red,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(Icons.clear_all),
              onPressed: (){
                Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => HomeScreen(isDarkMode: widget.isDarkMode)),                 
                 );
              },           
            ),
            IconButton(
            icon: Icon(Icons.more_vert, color:widget.isDarkMode? Colors.white:Colors.black),
            onPressed: () {},
          ),
          ],
        ),
        drawer: Drawer(
          backgroundColor:widget.isDarkMode? Colors.black:Colors.white,       
          child: ListView(
            children: [
              DrawerHeader(
                padding: EdgeInsets.only(top: 30,left: 12),
                decoration: BoxDecoration(
                color:widget.isDarkMode? Colors.black: Colors.white,
                ),
                child: Text(
                  'Menu',
                  style:TextStyle(
                    color: widget.isDarkMode? Colors.white: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 34,
                  ) ,),
              ),
              ListTile(
                leading: Icon(Icons.account_circle,color:Colors.red),
                title: Text(
                  'Profil',
                  style: TextStyle(
                    color: widget.isDarkMode? Colors.white: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),               
                ),
                subtitle:Text(
                  "Verifier les etats de vos commandes",
                  style: TextStyle(
                    color: widget.isDarkMode? Colors.white: Colors.black,                 
                  ),
                ),
                trailing:Icon(Icons.chevron_right),
                onTap: (){
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProfileScreen( isDarkMode: widget.isDarkMode)),                 
                  );
                },
                
              ),
              ListTile(
                leading: Icon(Icons.close_outlined,color:Colors.red),
                title: Text(
                  'Quittez',
                  style: TextStyle(
                    color: widget.isDarkMode? Colors.white: Colors.black,
                    fontWeight: FontWeight.bold,
                ),
                ),
                onTap: (){
                  SystemNavigator.pop();
                },
              )
            ],
          ),      
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [      
            const SizedBox(height: 23),                                 
            Expanded(
              child: ListView.builder(
                reverse: false, // Affiche les nouveaux messages en haut et mettre a true pour afficher en bas
                itemCount: _messages.length,
                itemBuilder: (context, index) {
                  final message = _messages[index]; // si afficher en bas   final message = _messages[_messages.length - 1 - index];
                  return ChatBubble(
                    text: message['text'],
                    isUser: message['isUser'],
                    botName: !message['isUser'] ? "Tobassi" : null,
                    botIcon: !message['isUser'] ? Icons.android : null,
                    isdark:widget.isDarkMode
                  );
                },
              ),            
            ),           
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    maxLines: null, // Permet plusieurs lignes
                    cursorColor:  Colors.red,                  
                    decoration: InputDecoration(
                      filled: true,
                      fillColor: widget.isDarkMode? Color.fromARGB(255, 48, 40, 40): Colors.grey,
                      hintText: 'Message.....',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(
                      color: widget.isDarkMode? Colors.white: Colors.black, // Couleur du texte
                      fontSize: 16.4, // Taille de la police (facultatif)
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                 if (_isButtonVisible)
                CircleAvatar(
                  backgroundColor:widget.isDarkMode? Colors.white: Colors.black,
                  foregroundColor: Colors.black54,
                  child: IconButton(
                    icon: Icon(Icons.send, color: widget.isDarkMode? Colors.black:Colors.white),
                    onPressed: () {
                      _sendMessage(_textController.text);
                    },
                  ),
                ),
              ],
            ),
          ),
          ],
        ),
    );
  }
 
}