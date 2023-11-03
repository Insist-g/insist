import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/store/dict.dart';
import 'package:flutter_ducafecat_news_getx/common/style/color.dart';
import 'package:flutter_ducafecat_news_getx/common/values/constant.dart';

class StarBar extends StatefulWidget {
  final Function(int) onSelect;

  const StarBar({super.key, required this.onSelect});

  @override
  State<StarBar> createState() => _StarBarState();
}

class _StarBarState extends State<StarBar> {

  var data = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DictStore.to
        .findWithType(type: DictKeys.CTRL_PROBLEM_LEVEL)
        .forEach((key, value) {
      data.add({"title": value, "id": int.tryParse(key) ?? 0, "select": false});
    });
    data.first['select'] = true;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: data.asMap().keys.map((index) {
        int ID = data[index]["id"] as int;
        return GestureDetector(
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: data[index]["select"] == true
                    ? Colors.primaries[index % 8]
                    : AppColor.dividerColor),
            child: Text(
              data[index]["title"] as String,
              style: TextStyle(color: AppColor.white),
            ),
          ),
          onTap: () {
            for (var item in data) {
              int itemID = item["id"] as int;
              if (ID >= itemID) {
                item["select"] = true;
              } else {
                item["select"] = false;
              }
            }
            setState(() {});
            widget.onSelect(ID);
          },
        );
      }).toList(),
    );
  }
}
