import 'package:flutter/material.dart';

class HorizontalMenu extends StatefulWidget {
  final Function onClick;
  final List<String> menus;

  const HorizontalMenu({
    Key? key,
    required this.onClick,
    required this.menus
  }) : super(key: key);

  @override
  State<HorizontalMenu> createState() => _HorizontalMenu();
}
class _HorizontalMenu extends State<HorizontalMenu> {
  String _selected = 'All';

  void _setSelected(String sel) {
    setState(() {
      _selected = sel;
    });
  }


  List<Widget> menuMaker (List<String> list, Function f, Function f2) {
    return list.map((e) => Container(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: TextButton(
        onPressed: () => {
          f2(e),
          f(e)
        },
        child: Column(
          children: [
          Text(
          e,
          style: const TextStyle(color: Colors.white),
        ),
        SizedBox(
          width: 35,
          child: (_selected == e) ?
          const Divider(
            thickness: 1.1,
            color: Colors.white
          ): null,
      ),
      ],
    ),
    ))).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5.0),
      height: 49.0,
      child: Stack(
        children: [
          ListView(
            scrollDirection: Axis.horizontal,
            children: menuMaker(widget.menus, widget.onClick, _setSelected)
          ),
          // Divider(thickness: 2, color: Colors.white12),
          const Positioned(
            bottom: -7,
            width: 500,
            child: Divider(thickness: 2, color: Colors.white12)
          ),
        ],
      ),
    );
  }
}
