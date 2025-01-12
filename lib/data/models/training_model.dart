class TrainingModel {
  Response? response;

  TrainingModel({this.response});

  TrainingModel.fromJson(Map<String, dynamic> json) {
    response =
        json['response'] != null ? Response.fromJson(json['response']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (response != null) {
      data['response'] = response!.toJson();
    }
    return data;
  }
}

class Response {
  List<Courses>? courses;

  Response({this.courses});

  Response.fromJson(Map<String, dynamic> json) {
    if (json['courses'] != null) {
      courses = <Courses>[];
      json['courses'].forEach((v) {
        courses!.add(Courses.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (courses != null) {
      data['courses'] = courses!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Courses {
  String? speakerName;
  int? id;
  TrainingDetails? trainingDetails;
  String? enrolmentStatus;
  String? fillingStatus;
  double? reviews;
  bool? showInHighlights;

  Courses(
      {this.speakerName,
      this.id,
      this.trainingDetails,
      this.enrolmentStatus,
      this.fillingStatus,
      this.reviews,
      this.showInHighlights});

  Courses.fromJson(Map<String, dynamic> json) {
    speakerName = json['speaker_name'];
    id = json['id'];
    trainingDetails = json['training_details'] != null
        ? TrainingDetails.fromJson(json['training_details'])
        : null;
    enrolmentStatus = json['enrolment_status'];
    fillingStatus = json['filling_status'];
    reviews = json['reviews'];
    showInHighlights = json['showInHighlights'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['speaker_name'] = speakerName;
    data['id'] = id;
    if (trainingDetails != null) {
      data['training_details'] = trainingDetails!.toJson();
    }
    data['enrolment_status'] = enrolmentStatus;
    data['filling_status'] = fillingStatus;
    data['reviews'] = reviews;
    data['showInHighlights'] = showInHighlights;
    return data;
  }
}

class TrainingDetails {
  String? name;
  String? description;
  String? place;
  String? state;
  String? city;
  String? date;
  String? time;
  String? fee;
  String? previousPrice;

  TrainingDetails(
      {this.name,
      this.description,
      this.place,
      this.state,
      this.city,
      this.date,
      this.time,
      this.fee,
      this.previousPrice});

  TrainingDetails.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    description = json['description'];
    place = json['place'];
    state = json['state'];
    city = json['city'];
    date = json['date'];
    time = json['time'];
    fee = json['fee'];
    previousPrice = json['previousPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['description'] = description;
    data['place'] = place;
    data['state'] = state;
    data['city'] = city;
    data['date'] = date;
    data['time'] = time;
    data['fee'] = fee;
    data['previousPrice'] = previousPrice;
    return data;
  }
}
