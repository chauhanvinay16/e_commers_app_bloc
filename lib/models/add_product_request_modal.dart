class AddProductRequestModal {
  String? title;
  int? price;
  String? description;
  int? categoryId;
  List<String>? images;

  AddProductRequestModal(
      {this.title, this.price, this.description, this.categoryId, this.images});

  AddProductRequestModal.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    price = json['price'];
    description = json['description'];
    categoryId = json['categoryId'];
    images = json['images'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['title'] = this.title;
    data['price'] = this.price;
    data['description'] = this.description;
    data['categoryId'] = this.categoryId;
    data['images'] = this.images;
    return data;
  }
}
