import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  final TextEditingController _textController = TextEditingController();
  bool _isButtonVisible = false;
  bool _showMoreButtons = false;

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
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        title: const Text(
          'TobassiChatBot',
          style: TextStyle(
            color: Colors.red,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
        leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.white),
          onPressed: () {},
        ),
      ),
      drawer: Drawer(
        backgroundColor: Colors.black,
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                border: Border.all()
              ),
               child: Text('Menu'),
            ),
            ListTile(
              leading: Icon(Icons.close),
              title: Text('Quittez'),
              onTap: (){},
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
                    color: Colors.white,
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
                    _buildButton(Icons.auto_awesome, "M’étonner"),
                    SizedBox(width: 10),
                     if (!_showMoreButtons)
                     ElevatedButton.icon(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black54,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
                        ),
                        onPressed: () {
                          setState(() {
                            _showMoreButtons = true; // Afficher ou cacher les boutons
                          });
                        },
                        icon: Icon(Icons.more_horiz, color: Colors.white),
                        label: Text(
                          "Plus",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),                    
                      )
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                      if (_showMoreButtons) ...[
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _buildButton(Icons.auto_awesome, "M’étonner"),
                             SizedBox(height: 10),
                            _buildButton(Icons.star, "Favoris"),
                          ],
                        ),                       
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                           _buildButton(Icons.share, "Partager"),
                          ],
                        ),                       
                      ]
                  ],
                  )
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
                      fillColor: const Color.fromARGB(255, 48, 40, 40),
                      hintText: 'Message.....',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(25.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(
                      color: Colors.white, // Couleur du texte
                      fontSize: 16, // Taille de la police (facultatif)
                    ),
                  ),
                ),
                SizedBox(width: 10),
                 if (_isButtonVisible)
                CircleAvatar(
                  backgroundColor: Colors.red,
                  child: IconButton(
                    icon: Icon(Icons.send, color: Colors.white),
                    onPressed: () {},
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
        backgroundColor: Colors.black54,
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      ),
      onPressed: () {
        _updateTextField(text);
      },
      icon: Icon(icon,color: Colors.red,),
      label: Text(text),
    );
  }
}