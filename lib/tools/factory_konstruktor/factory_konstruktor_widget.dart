// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:amazing_tools/tools/factory_konstruktor/factory_konstruktor_logisch.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FactoryKonstruktor extends StatefulWidget {
  const FactoryKonstruktor({super.key});

  @override
  State<FactoryKonstruktor> createState() => _FactoryKonstruktorState();
}

class _FactoryKonstruktorState extends State<FactoryKonstruktor> {
  bool isMaenlich = true;
  // final m = Mensch._('Max', 'Mänlich', 30);
  Mensch person = Mensch.mann('Max', 30);
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Center(
            child: Text(
          '${person.name}: ${person.alter}',
          style: TextStyle(fontSize: 40),
        )),
        Switch(
          value: isMaenlich,
          onChanged: (value) {
            setState(() {
              person.alter = 30;
              isMaenlich = value;
              if (isMaenlich) {
                person = Mensch.mann('Max', person.alter);
              } else {
                person.alter = 20;
                person = Mensch.frau('Mari', person.alter);
              }
            });
          },
        )
      ],
    );
  }
}

// class other extends Mensch {
//   other(String name, int alter) : super(name: name, geschlecht: 'Mänlich', alter: alter);
// }
