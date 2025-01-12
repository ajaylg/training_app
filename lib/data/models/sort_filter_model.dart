class FilterModel {
  String? filterName;
  List<Filter>? filter;

  FilterModel({this.filterName, this.filter});

  FilterModel.fromJson(Map<String, dynamic> json) {
    filterName = json['filterName'];
    if (json['filter'] != null) {
      filter = <Filter>[];
      json['filter'].forEach((v) {
        filter!.add(Filter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['filterName'] = filterName;
    if (filter != null) {
      data['filter'] = filter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Filter {
  String? label;
  bool? isSelected;

  Filter({this.label, this.isSelected});

  Filter.fromJson(Map<String, dynamic> json) {
    label = json['label'];
    isSelected = json['isSelected'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['label'] = label;
    data['isSelected'] = isSelected;
    return data;
  }
}
