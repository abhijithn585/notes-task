class NotesModel {
  String? title;
  String? details;
  NotesModel({required this.title, required this.details});
  factory NotesModel.fromJson(Map<String, dynamic> json) {
    return NotesModel(
      title: json['title'],
      details: json['details'],
    );
  }
  Map<String, dynamic> toJson() {
    return {'titile': title, 'details': details};
  }
}
