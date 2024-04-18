import 'package:flutter/material.dart';
import 'package:store_management/screens/components/calculator_component.dart';

class CustomAppBarComponent extends StatefulWidget
    implements PreferredSizeWidget {
  final String title;

  const CustomAppBarComponent({key, required this.title})
      : preferredSize = const Size.fromHeight(kToolbarHeight),
        super(key: key);

  @override
  final Size preferredSize; // default is 56.0

  @override
  State<CustomAppBarComponent> createState() => _CustomAppBarComponentState();
}

class _CustomAppBarComponentState extends State<CustomAppBarComponent> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: Text(widget.title),
      actions: [
        IconButton(
          onPressed: () {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return const AlertDialog(
                  content: CalculatorComponent(),
                );
              },
            );
          },
          icon: const Icon(Icons.calculate_rounded),
        ),
      ],
    );
  }
}
