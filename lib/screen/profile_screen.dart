import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  final bool isDarkMode;

  ProfileScreen({required this.isDarkMode}); // Le paramètre requis
  
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  

  // Données simulées des commandes pour cet exemple
  final List<Map<String, dynamic>> orders = [
    {
      "state": "En cours",
      "orderDate": "2024-01-01",
      "deliveryDate": "2024-01-02",
      "menu": "Pizza Margherita",
      "price": 12.99,
    },
    {
      "state": "Terminé",
      "orderDate": "2023-12-25",
      "deliveryDate": "2023-12-25",
      "menu": "Sushi Deluxe",
      "price": 19.99,
    },
    {
      "state": "Échoué",
      "orderDate": "2023-11-20",
      "deliveryDate": null,
      "menu": "Burger Double",
      "price": 9.99,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.isDarkMode? Colors.black: Colors.white,
      appBar: AppBar(
        backgroundColor: widget.isDarkMode?Colors.black: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back,color: widget.isDarkMode? Colors.white: Colors.black,),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Profil",
        style: TextStyle(
          color: widget.isDarkMode? Colors.white: Colors.black,
        ),),
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Image de profil au centre
          CircleAvatar(
            radius: 50,
            backgroundImage: NetworkImage(
              "https://images.app.goo.gl/VSnfizGzbabKWia6A",
              scale:1.0  // Remplacez par l'URL réelle
            ),
          ),
          SizedBox(height: 20),
          Text(
            "THE STRANGE MAN ",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: widget.isDarkMode? Colors.white: Colors.black, ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: orders.length,
              itemBuilder: (context, index) {
                final order = orders[index];
                return Card(
                  color: widget.isDarkMode? Colors.black: Colors.white,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: ListTile(
                    title: Text(order['menu'],
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: widget.isDarkMode? Colors.white: Colors.black,
                    ),),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Date de commande : ${order['orderDate']}",
                          style: TextStyle(                    
                            color: widget.isDarkMode? Colors.white: Colors.black,
                          ),
                        ),
                        Text(
                          "Date de livraison : ${order['deliveryDate'] ?? 'Non livrée'}",
                           style: TextStyle(                    
                            color: widget.isDarkMode? Colors.white: Colors.black,
                          ),
                        ),
                        Text("État : ${order['state']}",
                            style: TextStyle(                    
                            color: widget.isDarkMode? Colors.white: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(
                      "${order['price'].toStringAsFixed(2)} €",
                      style: TextStyle(fontWeight: FontWeight.bold,color: Colors.red),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
