class ProductModel {
  final int? id;
  final String? title;
  final String? price;
  final String? description;
  final String? category;
  final String? image;
  final Rating? rating;
  bool isFavorite;
  bool isCart;
  int addedQty;

  ProductModel({this.id, this.title, this.price, this.description, this.category, this.image, this.rating, this.isFavorite = false, this.isCart = false, this.addedQty = 0});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      title: json['title'] ?? "",
      price: json['price'] != null ? json['price'].toString() : "",
      category: json['category'] ?? "",
      description: json['description'] ?? "",
      image: json['image'] ?? "",
      rating: json['rating'] != null ? Rating.fromJson(json['rating']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'category': category,
      'description': description,
      'image': image,
      'rating': rating != null ? rating!.toJson() : {},
    };
  }
}

class Rating {
  final String? rate;
  final String? count;

  Rating({
    this.rate,
    this.count,
  });

  factory Rating.fromJson(Map<String, dynamic> json) {
    return Rating(
      rate: json['rate'] != null ? json['rate'].toString() : "",
      count: json['count'] != null ? json['count'].toString() : "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'rate': rate,
      'count': count,
    };
  }
}
