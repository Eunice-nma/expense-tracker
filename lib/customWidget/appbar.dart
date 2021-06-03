import 'package:flutter/material.dart';
import '../utilities/constant.dart';

class ETAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget action;
  final String title;

  ETAppBar({this.action, this.title});

  @override
  _ETAppBarState createState() => _ETAppBarState();

  @override
  Size get preferredSize => new Size(25, 50);
}


class _ETAppBarState extends State<ETAppBar> {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
        color: kDarkGrey,
        size: 30,
      ),
      backgroundColor: Colors.white,
      elevation: 0,
      title: Text(
        widget.title,
        style: kTitleText,
      ),
      centerTitle: true,
      actions: [widget.action],
    );
  }
}

