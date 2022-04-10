import "package:flutter/material.dart";
import 'package:group_button/group_button.dart';

class TinyGroupButton extends StatefulWidget {
  final List<String>? selected;
  final List<String> buttonList;
  final Function onSelected;

  const TinyGroupButton({
    Key? key,
    this.selected,
    required this.onSelected,
    required this.buttonList,
  }) : super(key: key);

  @override
  State<TinyGroupButton> createState() => _TinyGroupButtonState();
}

class _TinyGroupButtonState extends State<TinyGroupButton> {
  late List<String> _selected;
  List<int> getSelectedList(List<String> selectedList) {
    List<int> tempList = [];
    selectedList.forEach((element) {
      int index = widget.buttonList.indexOf(element);
      if (index != -1) {
        tempList.add(index);
      }
    });
    return tempList;
  }
  @override
  void initState() {
    super.initState();
    _selected = widget.selected ?? [];
  }
  @override
  Widget build(BuildContext context) {
    return GroupButton(
      controller: GroupButtonController(
        selectedIndexes: getSelectedList(_selected)
      ),
      isRadio: false,
      options: GroupButtonOptions(
        borderRadius: BorderRadius.circular(100)
      ),
      buttons: widget.buttonList,
      onSelected: (val, i, selected) => {
        if (selected) {
          _selected.add(val as String)
        } else {
          _selected.remove(val)
        },
        widget.onSelected(_selected)
      }
    );
  }
}
