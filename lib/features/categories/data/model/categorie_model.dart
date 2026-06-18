class CategorieModel {
  String id;
  String image;
  String name;
  CategorieModel({required this.id, required this.name, required this.image});

  factory CategorieModel.fromMap(Map<String, dynamic> map) {
    return CategorieModel(
      id: map['id'] != null ? map['id'] as String : '',
      name: map['name'] != null ? map['name'] as String : '',
      image: map['image'] != null ? map['image'] as String : '',
    );
  }
}
