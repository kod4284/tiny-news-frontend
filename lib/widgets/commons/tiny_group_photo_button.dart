import "package:flutter/material.dart";
import 'package:group_button/group_button.dart';

class TinyGroupPhotoButton extends StatefulWidget {
  final List<String>? selected;
  final List<String> buttonList;
  final Function onSelected;

  const TinyGroupPhotoButton({
    Key? key,
    this.selected,
    required this.onSelected,
    required this.buttonList,
  }) : super(key: key);

  @override
  State<TinyGroupPhotoButton> createState() => _TinyGroupPhotoButtonState();
}

class _TinyGroupPhotoButtonState extends State<TinyGroupPhotoButton> {
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
        buttonBuilder: (selected, value, context) {
          return Container(
            width: 100,
            decoration: selected ? BoxDecoration(
                border: Border.all(color: Colors.blueAccent, width: 4)
            ): null,
            child: Image(
                width: 100,
                image: AssetImage("images/"+value.toString().split(".")[0]+".png"),
                fit: BoxFit.cover
            )
          );
        },
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
