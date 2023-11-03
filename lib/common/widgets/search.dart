import 'package:flutter/material.dart';
import 'package:flutter_ducafecat_news_getx/common/style/text_style.dart';
import 'package:flutter_ducafecat_news_getx/common/utils/utils.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

//listView头部search
class SearchEdit extends StatefulWidget {
  final TextEditingController controller;
  final Color backgroundColor;

  const SearchEdit({
    Key? key,
    required this.controller,
    this.backgroundColor = Colors.white,
  }) : super(key: key);

  @override
  State<SearchEdit> createState() => _SearchEditState();
}

class _SearchEditState extends State<SearchEdit> {
  late bool _isShowDelete;

  @override
  void initState() {
    super.initState();
    _isShowDelete = (widget.controller.text).isNotEmpty;
    widget.controller.addListener(() {
      if (mounted) {
        setState(() {
          // 更新widget状态
          _isShowDelete = (widget.controller.text).isNotEmpty;
        });
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    // widget.controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 5),
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(20.0)),
      ),
      child: SizedBox(
        height: 40,
        child: TextField(
          controller: widget.controller,
          decoration: InputDecoration(
            prefixIcon: const Icon(Icons.search),
            suffixIcon: Material(
              color: Colors.transparent,
              clipBehavior: Clip.hardEdge,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (_isShowDelete)
                    IconButton(
                      onPressed: () {
                        Utils.hideKeyboard(context);
                        widget.controller.text = '';
                      },
                      icon: const Icon(Icons.clear_rounded),
                    ),
                ],
              ),
            ),
            fillColor: Colors.white12,
            filled: true,
            hintStyle: AppTextStyle.secondary_14,
            focusedBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent)),
            disabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent)),
            enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent)),
            border: const OutlineInputBorder(
                borderSide: BorderSide(width: 0, color: Colors.transparent)),
            contentPadding: const EdgeInsets.all(0),
          ),
        ),
      ),
    );
  }
}

//列表中 edit search
class SearchEditItem extends StatefulWidget {
  //左侧标题
  final String? title;

  //初始值
  // final SearchEditItemEntity? initValue;

  //搜索方法
  final Future<List> Function(String) getSearchData;

  //选择方法
  final Function(String?)? onSelect;

  const SearchEditItem({
    super.key,
    this.title,
    required this.getSearchData,
    this.onSelect,
    // this.initValue,
  });

  @override
  State<SearchEditItem> createState() => _SearchEditItemState();
}

class _SearchEditItemState extends State<SearchEditItem> {
  late FocusNode _focusNode;
  late TextEditingController _typeAheadController;
  late SuggestionsBoxController suggestionBoxController;
  SearchEditItemEntity? _selected;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _typeAheadController = TextEditingController();
    suggestionBoxController = SuggestionsBoxController();
    // _selected = widget.initValue;
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        if (_selected?.id == null) {
          _typeAheadController.text = "";
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _typeAheadController.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // close the suggestions box when the user taps outside of it
      onTap: () => suggestionBoxController.close(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 9.0, vertical: 4),
        child: Row(
          children: [
            Text(
              widget.title ?? "",
              style: AppTextStyle.primary_16_w500,
            ),
            Expanded(
              child: TypeAheadFormField(
                // initialValue: _selected?.name,
                textFieldConfiguration: TextFieldConfiguration(
                    controller: _typeAheadController,
                    textAlign: TextAlign.end,
                    focusNode: _focusNode,
                    onChanged: (value) {
                      _selected = null;
                      if (widget.onSelect != null) widget.onSelect!(null);
                    },
                    decoration: InputDecoration(
                      border: InputBorder.none,
                    )),
                suggestionsCallback: (pattern) => widget.getSearchData(pattern),
                itemBuilder: (context, suggestion) => ListTile(
                  title: Text((suggestion as SearchEditItemEntity).name ?? ""),
                ),
                noItemsFoundBuilder: (context){
                  return Center(child: Text("暂无数据～"));
                },
                errorBuilder: (context, error){
                  return Center(child: Text("出错了TAT"));
                },
                suggestionsBoxDecoration: SuggestionsBoxDecoration(
                  color: Colors.white,
                  elevation: 1,
                  offsetX: 50,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(10))),
                  constraints: BoxConstraints(
                      maxHeight: 250,
                      minWidth: MediaQuery.of(context).size.width - 20),
                ),
                itemSeparatorBuilder: (context, index) => const Divider(
                  indent: 10,
                  endIndent: 10,
                ),
                transitionBuilder: (context, suggestionsBox, controller) =>
                    suggestionsBox,
                onSuggestionSelected: (suggestion) {
                  _typeAheadController.text =
                      (suggestion as SearchEditItemEntity).name ?? "";
                  _selected = suggestion;
                  if (widget.onSelect != null) {
                    widget.onSelect!(suggestion.id);
                  }
                },
                suggestionsBoxController: suggestionBoxController,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SearchEditItemEntity {
  String? name;
  String? id;

  SearchEditItemEntity({this.name, this.id});

  SearchEditItemEntity.fromJson(Map<String, dynamic> json) {
    name = json["name"];
    id = json["id"];
  }

  SearchEditItemEntity.fromJsonAsRiver(Map<String, dynamic> json) {
    name = json["riverName"];
    id = json["id"];
  }

  SearchEditItemEntity.fromJsonAsReach(Map<String, dynamic> json) {
    name = json["reachName"];
    id = json["id"];
  }
}
