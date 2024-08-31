class ProductDetailModel {
  String? message;
  Data? data;

  ProductDetailModel({this.message, this.data});

  ProductDetailModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  int? id;
  List<String>? productImages;
  List<String>? productVideos;
  String? productId;
  String? name;
  String? description;
  String? price;
  int? stock;
  bool? available;
  bool? draft;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? category;

  Data(
      {this.id,
      this.productImages,
      this.productVideos,
      this.productId,
      this.name,
      this.description,
      this.price,
      this.stock,
      this.available,
      this.draft,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productImages = json['product_images'].cast<String>();
    productVideos = json['product_videos'].cast<String>();
    productId = json['product_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
    available = json['available'];
    draft = json['draft'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_images'] = this.productImages;
    data['product_videos'] = this.productVideos;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['available'] = this.available;
    data['draft'] = this.draft;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category'] = this.category;
    return data;
  }
}
