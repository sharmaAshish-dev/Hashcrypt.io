import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:hashcrypt/hash_functions/hash_functions.dart';

import '../values/colors.dart';
import '../values/sizes.dart';

class DropDownUtils<T> {
  List<T> items = [];
  T? selectedItem;
  String? title;
  List<Widget>? icons;
  bool showSearchBar;

  DropDownUtils({this.selectedItem, required this.items, this.title, this.icons, this.showSearchBar = false});

  Widget dropDownMenu(ValueChanged<T> onChanged) {
    return Container(
      padding: const EdgeInsets.only(right: Sizes.PADDING_12),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(Sizes.RADIUS_12),
        border: Border.all(color: AppColors.primaryColor, width: 1),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2<T>(
          iconEnabledColor: AppColors.primaryColor,
          value: selectedItem,
          selectedItemHighlightColor: AppColors.primaryColor.withOpacity(0.1),
          scrollbarAlwaysShow: true,
          dropdownDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Sizes.RADIUS_12),
            border: Border.all(color: AppColors.primaryColor, width: 1),
          ),
          isExpanded: true,
          onChanged: (item) {
            selectedItem = item;
            onChanged(item as T);
          },
          items: addDropDownMenu(items),
        ),
      ),
    );
  }

  Future<T?> showDropDownModalSheet(BuildContext context) async {
    return await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.RADIUS_16)),
      ),
      builder: (context) {
        return _DropDownModalSheet<T>(
          items: items,
          title: title ?? '',
          showSearchBar: showSearchBar,
          selectedItem: selectedItem,
        );
      },
    ).then((selectedItem) => selectedItem as T?);
  }

  List<DropdownMenuItem<T>> addDropDownMenu(List<T> items) {
    List<DropdownMenuItem<T>> menuItems = [];
    for (int i = 0; i < items.length; i++) {
      menuItems.add(DropdownMenuItem(
        value: items[i],
        child: Row(
          children: [
            if (icons != null) icons![i],
            if (icons != null) const SizedBox(width: Sizes.WIDTH_8),
            Expanded(
                child: Text(
              _DropDownModalSheet(items: items, title: title ?? '', showSearchBar: showSearchBar).getItemText(items[i]) ?? '',
              style: const TextStyle(
                color: AppColors.primaryColor,
              ),
            )),
          ],
        ),
      ));
    }
    return menuItems;
  }
}

class _DropDownModalSheet<T> extends StatefulWidget {
  final List<T> items;
  final String title;
  final bool showSearchBar;
  final T? selectedItem;

  const _DropDownModalSheet({Key? key, required this.items, required this.title, this.showSearchBar = false, this.selectedItem}) : super(key: key);

  @override
  State<_DropDownModalSheet> createState() => _DropDownModalSheetState();

  String? getItemText(T item) {
    switch (item.runtimeType) {
      case String:
        return item as String;
      case int:
        return item.toString();
        case HashType:
        return (item as HashType).name;
      default:
        return '';
    }
  }
}

class _DropDownModalSheetState extends State<_DropDownModalSheet> {
  String tileText = '';

  List items = [];

  @override
  void initState() {
    items = widget.items;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      maxChildSize: 0.9,
      initialChildSize: 0.6,
      minChildSize: 0.2,
      expand: false,
      builder: (BuildContext context, ScrollController scrollController) {
        return Container(
          decoration: const BoxDecoration(color: AppColors.accentColor, borderRadius: BorderRadius.vertical(top: Radius.circular(Sizes.RADIUS_16))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: Sizes.PADDING_16, right: Sizes.PADDING_16, top: Sizes.PADDING_16),
                child: Row(
                  children: [
                    Text(
                      widget.title,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(fontWeight: FontWeight.bold),
                    ),
                    const Spacer(),
                    IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.primaryColor,
                      ),
                    ),
                  ],
                ),
              ),
              if (widget.showSearchBar)
                Padding(
                  padding: const EdgeInsets.only(left: Sizes.PADDING_8, right: Sizes.PADDING_8, top: Sizes.PADDING_8),
                  child: TextField(
                    onChanged: (value) {
                      setState(() {
                        items = widget.items.where((element) => widget.getItemText(element)!.toLowerCase().contains(value.toLowerCase())).toList();
                      });
                    },
                    decoration: const InputDecoration(
                      hintText: "Search",
                      prefixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.symmetric(horizontal: Sizes.PADDING_16, vertical: Sizes.PADDING_8),
                    ),
                  ),
                ),
              Expanded(
                child: ListView.separated(
                  controller: scrollController,
                  itemCount: items.length,
                  padding: const EdgeInsets.only(top: Sizes.PADDING_8),
                  itemBuilder: (context, index) {
                    tileText = widget.getItemText(items[index]) ?? '';

                    return ListTile(
                      onTap: () {
                        Navigator.pop(context, items[index]);
                      },
                      title: Text(tileText),
                      contentPadding: const EdgeInsets.symmetric(horizontal: Sizes.PADDING_16),
                      trailing: widget.selectedItem == items[index] ? const Icon(Icons.check_circle, color: AppColors.primaryColor) : null,
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(color: AppColors.grey, height: 1, thickness: 0.4);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
