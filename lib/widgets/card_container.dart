import 'package:flutter/material.dart';

class CardContainer extends StatelessWidget {
  const CardContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  BoxDecoration _createCardShape() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25.0),
        boxShadow: const [
          BoxShadow(
            blurRadius: 15.0,
            color: Colors.black,
            offset: Offset(0, 5),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Container(
        decoration: _createCardShape(),
        padding: const EdgeInsets.all(
          20.0,
        ),
        width: double.infinity,
        child: child,
      ),
    );
  }
}
