import 'package:flutter/material.dart';

class TinyIconButton extends StatelessWidget {
  final IconData icon;
  final double width;
  final double height;
  final Function onClick;

  const TinyIconButton({
    Key? key,
    required this.icon,
    required this.width,
    required this.height,
    required this.onClick
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child : Material(
          color: Colors.transparent,
          child : InkWell(
            child : Padding(
                padding : const EdgeInsets.all(0),
                child : Icon(icon, size: width-5, color: Color(0xffa8a7a7),)
            ),
            onTap : () => onClick(),
          ),
        ),
      )
    );
  }
}
