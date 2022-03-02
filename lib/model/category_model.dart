class CategoryModel {
  String? name;
  String? image;
  CategoryModel({this.name, this.image });

//Retriving data form the server (Firebase DB)
  factory CategoryModel.fromMap(map) {
    return CategoryModel(name: map['name'], image: map['image']);
  }
//Sending data to our Server
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'image': image,
    };
  }
}
