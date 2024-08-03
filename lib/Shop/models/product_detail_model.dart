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
  List<ProductImages>? productImages;
  List<ProductVideos>? productVideos;
  String? productId;
  String? name;
  String? description;
  String? price;
  int? stock;
  bool? available;
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
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.category});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['product_images'] != null) {
      productImages = <ProductImages>[];
      json['product_images'].forEach((v) {
        productImages!.add(new ProductImages.fromJson(v));
      });
    }
    if (json['product_videos'] != null) {
      productVideos = <ProductVideos>[];
      json['product_videos'].forEach((v) {
        productVideos!.add(new ProductVideos.fromJson(v));
      });
    }
    productId = json['product_id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stock = json['stock'];
    available = json['available'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    category = json['category'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.productImages != null) {
      data['product_images'] =
          this.productImages!.map((v) => v.toJson()).toList();
    }
    if (this.productVideos != null) {
      data['product_videos'] =
          this.productVideos!.map((v) => v.toJson()).toList();
    }
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['description'] = this.description;
    data['price'] = this.price;
    data['stock'] = this.stock;
    data['available'] = this.available;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['category'] = this.category;
    return data;
  }
}

class ProductImages {
  int? id;
  String? image;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? product;

  ProductImages(
      {this.id,
      this.image,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.product});

  ProductImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product'] = this.product;
    return data;
  }
}

class ProductVideos {
  int? id;
  String? video;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? product;

  ProductVideos(
      {this.id,
      this.video,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.product});

  ProductVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    video = json['video'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    product = json['product'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video'] = this.video;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['product'] = this.product;
    return data;
  }
}
