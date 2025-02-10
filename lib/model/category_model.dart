class CategoryModel {
  final String id;
  final String title;
  final String task;

  CategoryModel({
    required this.id,
    required this.title,
    required this.task,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'task': task,
    };
  }

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      title: json['title'],
      task: json['task'],
    );
  }
}
