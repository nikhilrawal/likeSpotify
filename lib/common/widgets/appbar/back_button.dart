import 'package:flutter/material.dart';
import 'package:spotify/common/helpers/is_dark.dart';

class BasicAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? action;
  final bool hideBack;
  final Color? colorback;
  const BasicAppBar(
      {super.key,
      this.title,
      this.hideBack = false,
      this.action,
      this.colorback});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colorback ?? Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: title ?? null,
      actions: [action ?? Container()],
      leading: hideBack
          ? Text('')
          : IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Container(
                height: 50,
                width: 50,
                decoration: BoxDecoration(
                    color: context.isDarkMode
                        ? const Color.fromARGB(20, 255, 255, 255)
                        : const Color.fromARGB(13, 0, 0, 0),
                    shape: BoxShape.circle),
                child: Icon(
                  Icons.arrow_back_ios_new,
                  size: 15,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
    );
  }

  @override
  // TODO: implement preferredSize
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
