class LaunchModel {
  late String typename;
  late String missionName;
  String? details;

  LaunchModel(
      {required this.typename, required this.missionName, this.details});

  LaunchModel.fromJson(Map<String, dynamic> json) {
    typename = json['__typename'];
    missionName = json['mission_name'];
    details = json['details'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['__typename'] = this.typename;
    data['mission_name'] = this.missionName;
    data['details'] = this.details;
    return data;
  }
}
