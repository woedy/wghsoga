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
  String? productImage;
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

  Products(
      {this.id,
      this.productImage,
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

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productImage = json['product_image'];
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
    data['product_image'] = this.productImage;
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

class Pagination {
  int? pageNumber;
  int? totalPages;
  int? next;
  int? previous;

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
