import 'package:flutter/material.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({Key? key, required this.name}) : super(key: key);
  final String name;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    double sizeContainer = ((screen.width - 20) / 2 * 0.5);
    return Card(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: sizeContainer,
            height: sizeContainer,
            decoration: BoxDecoration(
              color: const Color(0xFFff8c00),
              borderRadius: BorderRadius.all(
                Radius.circular(sizeContainer),
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            name,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w500,
            ),
          )
        ],
      ),
    );
  }
}
