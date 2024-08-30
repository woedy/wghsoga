class AllNewsModel {
  String? message;
  Data? data;

  AllNewsModel({this.message, this.data});

  AllNewsModel.fromJson(Map<String, dynamic> json) {
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
  List<Newss>? newss;
  Pagination? pagination;

  Data({this.newss, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['newss'] != null) {
      newss = <Newss>[];
      json['newss'].forEach((v) {
        newss!.add(new Newss.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.newss != null) {
      data['newss'] = this.newss!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Newss {
  String? newsId;
  String? title;
  String? content;
  int? likeCount;
  int? shareCount;
  int? commentCount;
  String? newsImage;

  Newss(
      {this.newsId,
      this.title,
      this.content,
      this.likeCount,
      this.shareCount,
      this.commentCount,
      this.newsImage});

  Newss.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    title = json['title'];
    content = json['content'];
    likeCount = json['like_count'];
    shareCount = json['share_count'];
    commentCount = json['comment_count'];
    newsImage = json['news_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.newsId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['like_count'] = this.likeCount;
    data['share_count'] = this.shareCount;
    data['comment_count'] = this.commentCount;
    data['news_image'] = this.newsImage;
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
