import 'package:flutter/material.dart';

class ControllBar extends StatelessWidget {
  const ControllBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(),
        borderRadius: BorderRadius.circular(3),
        color: Colors.blueGrey[300],
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueGrey[500],
                ),
                child: InkWell(
                  onTap: () {},
                  child: const SizedBox(height: 40, child: Icon(Icons.navigate_before)),
                ),
              ),
            ),
            const Expanded(flex: 2, child: SizedBox()),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueGrey[500],
                ),
                child: InkWell(
                  onTap: () {},
                  child: const SizedBox(
                    height: 40,
                    child: Icon(
                      Icons.navigate_next,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
