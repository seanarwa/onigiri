import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:onigiri/models/index.dart';

class ItemRow extends StatefulWidget {
  ItemRow({
    Key key,
    this.items,
    this.onChanged,
  }) : super(key: key);

  final List<Item> items;
  final Function(Item) onChanged;

  @override
  _ItemRowState createState() => _ItemRowState();
}

class _ItemRowState extends State<ItemRow> {
  Function(Item) _onChanged;
  List<Item> _items = [];
  Map<String, List<Item>> _index = {};

  @override
  void initState() {
    _onChanged = widget.onChanged ?? () {};
    _items = List.from(widget.items);
    _index = _indexItems(_items);
    super.initState();
  }

  Map<String, List<Item>> _indexItems(List<Item> items) {
    Map<String, List<Item>> result = {};
    for (Item item in items) {
      if (result.containsKey(item.name)) {
        result[item.name].add(item);
      } else {
        result[item.name] = [item];
      }
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        DropdownSearch<Item>(
          label: "Select item",
          onFind: (String filter) async {
            if (filter.isEmpty) {
              return _items;
            }

            List<Item> result = [];
            filter = filter.toLowerCase();
            List<String> searchTerms = _index.keys.toList();
            for (String searchTerm in searchTerms) {
              searchTerm = searchTerm.toLowerCase();
              if (searchTerm.contains(filter)) {
                result.addAll(_index[searchTerm]);
              }
            }
            return result;
          },
          itemAsString: (Item item) => item.name,
          onChanged: _onChanged,
        ),
      ],
    );
  }
}
