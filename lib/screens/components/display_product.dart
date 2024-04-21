import 'package:flutter/material.dart';

class DiaplyProductListComponent extends StatelessWidget {
  final List<Widget> children;

  const DiaplyProductListComponent({
    super.key,
    required this.children,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: CustomScrollView(
        slivers: [
          SliverGrid(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
            ),
            delegate: SliverChildListDelegate(
              children,
            ),
          )
        ],
      ),
    );
  }
}
