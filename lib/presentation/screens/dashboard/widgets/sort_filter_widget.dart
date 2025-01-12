import 'package:flutter/material.dart';
import 'package:trainings/core/app_colors.dart';
import 'package:trainings/core/app_constants.dart';

import '../../../../data/models/sort_filter_model.dart';

class SortFilter extends StatefulWidget {
  final List<FilterModel> initialFilterModel;
  final Function onSelectFilterCallback;
  const SortFilter({
    Key? key,
    required this.initialFilterModel,
    required this.onSelectFilterCallback,
  }) : super(key: key);

  @override
  State<SortFilter> createState() => _SortFilterState();
}

class _SortFilterState extends State<SortFilter> {
  int _selectedTabIndex = 0;
  String _searchKey = '';
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  List<Filter> _filteredFilters = <Filter>[];

  @override
  void initState() {
    super.initState();
    _onTapVerticalTab();
  }

  _onTapVerticalTab() {
    _textEditingController.clear();
    _focusNode.unfocus();
    _filteredFilters =
        List.from(widget.initialFilterModel[_selectedTabIndex].filter!);
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _updateSearch(String value) {
    setState(() {
      _searchKey = value;
      _filteredFilters = widget.initialFilterModel[_selectedTabIndex].filter!
          .where((filter) => filter.label!
              .toLowerCase()
              .contains(_searchKey.trim().toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [_header(), _verticalTabs()],
    );
  }

  Container _header() {
    return Container(
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.3)))),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            AppConstants.sortFilter,
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .copyWith(fontWeight: FontWeight.w600),
          ),
          GestureDetector(
            child: const Icon(
              Icons.close,
              color: Colors.grey,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  Padding _searchField() {
    return Padding(
      padding: const EdgeInsets.only(left: 12, right: 12, top: 12, bottom: 8),
      child: SizedBox(
        height: 50,
        child: TextField(
          controller: _textEditingController,
          focusNode: _focusNode,
          style: const TextStyle(color: Colors.grey, fontSize: 18),
          cursorColor: Theme.of(context).dividerColor,
          textAlign: TextAlign.start,
          onChanged: _updateSearch,
          decoration: InputDecoration(
            hintText: AppConstants.search,
            prefixIcon: const Icon(
              Icons.search_sharp,
              color: Colors.grey,
            ),
            contentPadding: const EdgeInsets.only(
              top: 12,
              bottom: 12,
              right: 10,
            ),
            hintStyle: const TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Theme.of(context).dividerColor),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).dividerColor, width: 1),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide:
                  BorderSide(color: Theme.of(context).dividerColor, width: 1),
            ),
          ),
        ),
      ),
    );
  }

  Container _verticalTabs() {
    return Container(
      height: (MediaQuery.of(context).size.height / 2) +
          MediaQuery.of(context).viewInsets.bottom,
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(
            flex: 3,
            child: Container(
              color: Theme.of(context).inputDecorationTheme.fillColor,
              child: ListView.builder(
                itemCount: widget.initialFilterModel.length,
                itemBuilder: (BuildContext context, int index) =>
                    _verticalTabItem(index),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0, bottom: 30),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _searchField(),
                    ...List.generate(_filteredFilters.length,
                        (index) => _checkBoxWidget(index))
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  GestureDetector _checkBoxWidget(int index) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      child: SizedBox(
        child: Row(
          children: [
            Checkbox(
              side: const BorderSide(color: Colors.black54),
              fillColor: MaterialStatePropertyAll(AppColors.primaryColor),
              value: _filteredFilters[index].isSelected,
              onChanged: (val) {
                setState(() {
                  _filteredFilters[index].isSelected =
                      !_filteredFilters[index].isSelected!;
                });
                widget.onSelectFilterCallback();
              },
            ),
            Expanded(
              child: Text(
                _filteredFilters[index].label!,
                style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      ),
      onTap: () {
        setState(() {
          _filteredFilters[index].isSelected =
              !_filteredFilters[index].isSelected!;
        });
        widget.onSelectFilterCallback();
      },
    );
  }

  GestureDetector _verticalTabItem(int index) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        height: 60,
        width: MediaQuery.of(context).size.width / 3,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 20),
        decoration: BoxDecoration(
          border: Border(
              left: index == _selectedTabIndex
                  ? BorderSide(width: 6, color: AppColors.primaryColor)
                  : BorderSide.none),
          color: index == _selectedTabIndex
              ? Colors.white
              : Colors.grey.withOpacity(0.15),
        ),
        child: Text(
          widget.initialFilterModel[index].filterName!,
          style: Theme.of(context).textTheme.bodySmall!.copyWith(
              color: Colors.black54,
              fontWeight: index == _selectedTabIndex
                  ? FontWeight.w800
                  : FontWeight.w500,
              fontSize: index == _selectedTabIndex ? 17 : 16),
        ),
      ),
      onTap: () {
        setState(() {
          _selectedTabIndex = index;
        });
        _onTapVerticalTab();
      },
    );
  }
}
