import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;

  const CustomAppBar({Key? key, required this.title, this.actions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(title),
      leading: IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).pop(),
      ),
      actions: actions,
      elevation: 0.0, // App bar'ın altındaki gölgeyi kaldırır.
      centerTitle: true,
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(kToolbarHeight); // AppBar'in yüksekliğini belirler.
}
