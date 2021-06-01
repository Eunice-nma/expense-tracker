import 'package:flutter/material.dart';

class DismissibleWidget<T> extends StatelessWidget {
  final Widget child;
  final T item;
  final DismissDirectionCallback onDismissed;

  DismissibleWidget({this.child, this.item, this.onDismissed});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      direction: DismissDirection.startToEnd,
      key: UniqueKey(),
      onDismissed: onDismissed,
      child: child,
      background: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.redAccent,
        ),
        alignment: Alignment.centerLeft,
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
    );
  }
}
