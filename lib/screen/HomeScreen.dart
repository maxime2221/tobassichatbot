import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tobassichatbot/screen/ChatScreen.dart';

import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  bool isDarkMode;

  HomeScreen({required this.isDarkMode});
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _textController = TextEditingController();
  bool _isButtonVisible = false; //pour le bouton d anvoi....
  bool _showMoreButtons = false; // afficher d autres questions possibles


  void _updateTextField(String text) {
    setState(() {
      _textController.text = text;
    });
  }

  
  @override
  void initState() {
    super.initState();
    _textController.addListener(() {
      setState(() {
        _isButtonVisible = _textController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode? Colors.black:Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color:  widget.isDarkMode? Colors.white:Colors.black),
        centerTitle: true,
        backgroundColor:  widget.isDarkMode? Colors.black:Colors.white,
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
              icon: Icon( widget.isDarkMode ? Icons.dark_mode : Icons.light_mode),
              onPressed: () {
                setState(() {
                   widget.isDarkMode = ! widget.isDarkMode; // Basculer entre clair et sombre
                });
              },
            ),
          IconButton(
            icon: Icon(Icons.more_vert, color: widget.isDarkMode? Colors.white:Colors.black),
            onPressed: () {},
          ),
        ],
        
      ),
      drawer: Drawer(
        backgroundColor: widget.isDarkMode? Colors.black:Colors.white,       
        child: ListView(
          children: [
            DrawerHeader(
              padding: EdgeInsets.only(top: 30,left: 12),
              decoration: BoxDecoration(
              color: widget.isDarkMode? Colors.black: Colors.white,
              ),
               child: Text(
                'Menu',
                style:TextStyle(
                   color:  widget.isDarkMode? Colors.white: Colors.black,
                   fontWeight: FontWeight.bold,
                   fontSize: 34,
                ) ,),
            ),
            ListTile(
              leading: Icon(Icons.account_circle,color:Colors.red),
              title: Text(
                'Profil',
                style: TextStyle(
                  color:  widget.isDarkMode? Colors.white: Colors.black,
                  fontWeight: FontWeight.bold,
                ),               
              ),
              subtitle:Text(
                "Verifier les etats de vos commandes",
                style: TextStyle(
                  color:  widget.isDarkMode? Colors.white: Colors.black,                 
                ),
              ),
              trailing:Icon(Icons.chevron_right),
              onTap: (){
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => ProfileScreen( isDarkMode:  widget.isDarkMode)),                 
                 );
              },
              
            ),
            ListTile(
              leading: Icon(Icons.close_outlined,color:Colors.red),
              title: Text(
                'Quittez',
                style: TextStyle(
                  color:  widget.isDarkMode? Colors.white: Colors.black,
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
           SizedBox(height: 1),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Comment puis-je vous aider ?',
                  style: TextStyle(
                    color:  widget.isDarkMode? Colors.white:Colors.black,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                     ),               
                ),
                SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildButton(Icons.image, "Créer une image"),
                    SizedBox(width: 10),
                    _buildButton(Icons.text_snippet, "Résumer un texte"),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 10),
                     if (!_showMoreButtons)
                      ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  widget.isDarkMode? Colors.black54 : Colors.white54,
                          foregroundColor:  widget.isDarkMode? Colors.white: Colors.black45,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                        onPressed: () {
                          setState(() {
                            _showMoreButtons = true; // Afficher ou cacher les boutons
                          });
                        },
                        icon: Icon(Icons.more_horiz, color: Colors.red),
                        label: Text(
                          "Plus",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),                    
                      )
                  ],
                ),
                  const SizedBox(height: 10),              
                      if (_showMoreButtons) ...[
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildButton(Icons.auto_awesome, "M’étonner"),
                             SizedBox(width: 10),
                            _buildButton(Icons.star, "Favoris"),
                          ],
                        ),                                             
                      ]                
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    cursorColor:  Colors.red,                  
                    decoration: InputDecoration(
                      filled: true,
                      fillColor:  widget.isDarkMode? Color.fromARGB(255, 48, 40, 40): Colors.grey,
                      hintText: 'Message.....',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(
                      color:  widget.isDarkMode? Colors.white: Colors.black, // Couleur du texte
                      fontSize: 16.4, // Taille de la police (facultatif)
                    ),
                  ),
                ),
                SizedBox(width: 10),
                 if (_isButtonVisible)
                CircleAvatar(
                  backgroundColor: widget.isDarkMode? Colors.white: Colors.black,
                  foregroundColor: Colors.black54,
                  child: IconButton(
                    icon: Icon(Icons.send, color:  widget.isDarkMode? Colors.black:Colors.white),
                    onPressed: () {
                      Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Chatscreen( isDarkMode:  widget.isDarkMode,text:_textController.text ,)),                 
                 );
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

  Widget _buildButton(IconData icon, String text) {
    
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor:  widget.isDarkMode? Colors.black54 : Colors.white54,
        foregroundColor:  widget.isDarkMode? Colors.white: Colors.black45,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      ),
      onPressed: () {
        _updateTextField(text);
      },
      icon: Icon(icon,color: Colors.red,),
      label: Text(text,
      style: TextStyle(
          fontWeight: FontWeight.bold,
     ),),
    );
  }
}