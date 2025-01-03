import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final bool isdark;
  final String text;
  final bool isUser;
  final String? botName;
  final IconData? botIcon;

  const ChatBubble({
    Key? key,
    required this.text,
    this.isUser = false,
    this.botName,
    this.botIcon,
    required this.isdark
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment:
          isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!isUser)
          Column(
            children: [
              if (botName != null)
                Text(
                  botName!,
                  style: const TextStyle(
                      fontSize: 12, fontWeight: FontWeight.bold),
                ),
              Icon(botIcon, size: 20),
            ],
          ),
        if (!isUser) const SizedBox(width: 8),
        Flexible(
          child: Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isUser
                  ? (isdark ? Colors.blueGrey[800] : Colors.grey) // Couleur utilisateur
                  : (isdark ? Colors.red : Colors.red), // Couleur bot
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(12),
                topRight: const Radius.circular(12),
                bottomLeft: isUser
                    ? const Radius.circular(12)
                    : const Radius.circular(0),
                bottomRight: isUser
                    ? const Radius.circular(0)
                    : const Radius.circular(12),
              ),
            ),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.70, // 75% de la largeur de l'écran
              ),
              child: Text(
                text,
                style: TextStyle(
                  color: isUser
                      ? (isdark ? Colors.white : Colors.black) // Couleur utilisateur
                      : (isdark ? Colors.white : Colors.white), // Couleur bot
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
 
}
