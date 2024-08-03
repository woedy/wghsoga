class AllProductsModel {
  String? message;
  Data? data;

  AllProductsModel({this.message, this.data});

  AllProductsModel.fromJson(Map<String, dynamic> json) {
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
  List<Products>? products;
  Pagination? pagination;

  Data({this.products, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Products {
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

  Products(
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

  Products.fromJson(Map<String, dynamic> json) {
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

class Pagination {
  int? pageNumber;
  int? totalPages;
  Null? next;
  Null? previous;

  Pagination({this.pageNumber, this.totalPages, this.next, this.previous});

  Pagination.fromJson(Map<String, dynamic> json) {
    pageNumber = json['page_number'];
    totalPages = json['total_pages'];
    next = json['next'];
    previous = json['previous'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['page_number'] = this.pageNumber;
    data['total_pages'] = this.totalPages;
    data['next'] = this.next;
    data['previous'] = this.previous;
    return data;
  }
}
