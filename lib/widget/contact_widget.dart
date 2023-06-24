import 'package:flutter/material.dart';
import 'package:trinity_wizards_test/model/contact_model.dart';

class ContactWidget extends StatelessWidget {
  const ContactWidget({Key? key, required this.data}) : super(key: key);
  final Contactmodel data;

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
          Center(
            child: Text(
              data.firstName + ' ' + data.lastName,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
              ),
            ),
          )
        ],
      ),
    );
  }
}
