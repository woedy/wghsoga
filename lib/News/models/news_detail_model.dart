class NewsDetailModel {
  String? message;
  Data? data;

  NewsDetailModel({this.message, this.data});

  NewsDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? newsImages;
  List<String>? newsVideos;
  int? commentCount;
  int? likeCount;
  int? shareCount;
  List<Shares>? shares;
  List<Shares>? likes;
  Shares? author;
  String? newsId;
  String? title;
  String? content;
  bool? draft;
  String? readDuration;
  String? publishedAt;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.newsImages,
      this.newsVideos,
      this.commentCount,
      this.likeCount,
      this.shareCount,
      this.shares,
      this.likes,
      this.author,
      this.newsId,
      this.title,
      this.content,
      this.draft,
      this.readDuration,
      this.publishedAt,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    newsImages = json['news_images'].cast<String>();
    newsVideos = json['news_videos'].cast<String>();
    commentCount = json['comment_count'];
    likeCount = json['like_count'];
    shareCount = json['share_count'];
    if (json['shares'] != null) {
      shares = <Shares>[];
      json['shares'].forEach((v) {
        shares!.add(new Shares.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = <Shares>[];
      json['likes'].forEach((v) {
        likes!.add(new Shares.fromJson(v));
      });
    }
    author =
        json['author'] != null ? new Shares.fromJson(json['author']) : null;
    newsId = json['news_id'];
    title = json['title'];
    content = json['content'];
    draft = json['draft'];
    readDuration = json['read_duration'];
    publishedAt = json['published_at'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['news_images'] = this.newsImages;
    data['news_videos'] = this.newsVideos;
    data['comment_count'] = this.commentCount;
    data['like_count'] = this.likeCount;
    data['share_count'] = this.shareCount;
    if (this.shares != null) {
      data['shares'] = this.shares!.map((v) => v.toJson()).toList();
    }
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['news_id'] = this.newsId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['draft'] = this.draft;
    data['read_duration'] = this.readDuration;
    data['published_at'] = this.publishedAt;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class Shares {
  String? userId;
  String? email;
  String? firstName;
  String? middleName;
  String? lastName;
  String? photo;
  String? house;

  Shares(
      {this.userId,
      this.email,
      this.firstName,
      this.middleName,
      this.lastName,
      this.photo,
      this.house});

  Shares.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    email = json['email'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    photo = json['photo'];
    house = json['house'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['photo'] = this.photo;
    data['house'] = this.house;
    return data;
  }
}
