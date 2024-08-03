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
  List<NewsComments>? newsComments;
  List<NewsImages>? newsImages;
  List<NewsVideos>? newsVideos;
  List<Likes>? likes;
  List<Likes>? shares;
  Likes? author;
  String? newsId;
  String? title;
  String? content;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.newsComments,
      this.newsImages,
      this.newsVideos,
      this.likes,
      this.shares,
      this.author,
      this.newsId,
      this.title,
      this.content,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['news_comments'] != null) {
      newsComments = <NewsComments>[];
      json['news_comments'].forEach((v) {
        newsComments!.add(new NewsComments.fromJson(v));
      });
    }
    if (json['news_images'] != null) {
      newsImages = <NewsImages>[];
      json['news_images'].forEach((v) {
        newsImages!.add(new NewsImages.fromJson(v));
      });
    }
    if (json['news_videos'] != null) {
      newsVideos = <NewsVideos>[];
      json['news_videos'].forEach((v) {
        newsVideos!.add(new NewsVideos.fromJson(v));
      });
    }
    if (json['likes'] != null) {
      likes = <Likes>[];
      json['likes'].forEach((v) {
        likes!.add(new Likes.fromJson(v));
      });
    }
    if (json['shares'] != null) {
      shares = <Likes>[];
      json['shares'].forEach((v) {
        shares!.add(new Likes.fromJson(v));
      });
    }
    author = json['author'] != null ? new Likes.fromJson(json['author']) : null;
    newsId = json['news_id'];
    title = json['title'];
    content = json['content'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.newsComments != null) {
      data['news_comments'] =
          this.newsComments!.map((v) => v.toJson()).toList();
    }
    if (this.newsImages != null) {
      data['news_images'] = this.newsImages!.map((v) => v.toJson()).toList();
    }
    if (this.newsVideos != null) {
      data['news_videos'] = this.newsVideos!.map((v) => v.toJson()).toList();
    }
    if (this.likes != null) {
      data['likes'] = this.likes!.map((v) => v.toJson()).toList();
    }
    if (this.shares != null) {
      data['shares'] = this.shares!.map((v) => v.toJson()).toList();
    }
    if (this.author != null) {
      data['author'] = this.author!.toJson();
    }
    data['news_id'] = this.newsId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class NewsComments {
  int? id;
  String? comment;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? news;
  int? user;

  NewsComments(
      {this.id,
      this.comment,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.news,
      this.user});

  NewsComments.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    comment = json['comment'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    news = json['news'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['comment'] = this.comment;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['news'] = this.news;
    data['user'] = this.user;
    return data;
  }
}

class NewsImages {
  int? id;
  String? image;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? news;

  NewsImages(
      {this.id,
      this.image,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.news});

  NewsImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    news = json['news'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['news'] = this.news;
    return data;
  }
}

class NewsVideos {
  int? id;
  String? video;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? news;

  NewsVideos(
      {this.id,
      this.video,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.news});

  NewsVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    video = json['video'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    news = json['news'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video'] = this.video;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['news'] = this.news;
    return data;
  }
}

class Likes {
  int? id;
  UserProfile? userProfile;
  String? password;
  Null? lastLogin;
  String? userId;
  String? email;
  String? username;
  String? firstName;
  String? middleName;
  String? lastName;
  String? phone;
  String? yearGroup;
  Null? fcmToken;
  Null? otpCode;
  String? emailToken;
  bool? emailVerified;
  String? photo;
  Null? dob;
  bool? maritalStatus;
  String? country;
  String? language;
  Null? aboutMe;
  bool? profileComplete;
  bool? verified;
  bool? isArchived;
  Null? locationName;
  Null? lat;
  Null? lng;
  bool? isActive;
  bool? staff;
  bool? admin;
  String? timestamp;

  Likes(
      {this.id,
      this.userProfile,
      this.password,
      this.lastLogin,
      this.userId,
      this.email,
      this.username,
      this.firstName,
      this.middleName,
      this.lastName,
      this.phone,
      this.yearGroup,
      this.fcmToken,
      this.otpCode,
      this.emailToken,
      this.emailVerified,
      this.photo,
      this.dob,
      this.maritalStatus,
      this.country,
      this.language,
      this.aboutMe,
      this.profileComplete,
      this.verified,
      this.isArchived,
      this.locationName,
      this.lat,
      this.lng,
      this.isActive,
      this.staff,
      this.admin,
      this.timestamp});

  Likes.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userProfile = json['user_profile'] != null
        ? new UserProfile.fromJson(json['user_profile'])
        : null;
    password = json['password'];
    lastLogin = json['last_login'];
    userId = json['user_id'];
    email = json['email'];
    username = json['username'];
    firstName = json['first_name'];
    middleName = json['middle_name'];
    lastName = json['last_name'];
    phone = json['phone'];
    yearGroup = json['year_group'];
    fcmToken = json['fcm_token'];
    otpCode = json['otp_code'];
    emailToken = json['email_token'];
    emailVerified = json['email_verified'];
    photo = json['photo'];
    dob = json['dob'];
    maritalStatus = json['marital_status'];
    country = json['country'];
    language = json['language'];
    aboutMe = json['about_me'];
    profileComplete = json['profile_complete'];
    verified = json['verified'];
    isArchived = json['is_archived'];
    locationName = json['location_name'];
    lat = json['lat'];
    lng = json['lng'];
    isActive = json['is_active'];
    staff = json['staff'];
    admin = json['admin'];
    timestamp = json['timestamp'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.userProfile != null) {
      data['user_profile'] = this.userProfile!.toJson();
    }
    data['password'] = this.password;
    data['last_login'] = this.lastLogin;
    data['user_id'] = this.userId;
    data['email'] = this.email;
    data['username'] = this.username;
    data['first_name'] = this.firstName;
    data['middle_name'] = this.middleName;
    data['last_name'] = this.lastName;
    data['phone'] = this.phone;
    data['year_group'] = this.yearGroup;
    data['fcm_token'] = this.fcmToken;
    data['otp_code'] = this.otpCode;
    data['email_token'] = this.emailToken;
    data['email_verified'] = this.emailVerified;
    data['photo'] = this.photo;
    data['dob'] = this.dob;
    data['marital_status'] = this.maritalStatus;
    data['country'] = this.country;
    data['language'] = this.language;
    data['about_me'] = this.aboutMe;
    data['profile_complete'] = this.profileComplete;
    data['verified'] = this.verified;
    data['is_archived'] = this.isArchived;
    data['location_name'] = this.locationName;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['is_active'] = this.isActive;
    data['staff'] = this.staff;
    data['admin'] = this.admin;
    data['timestamp'] = this.timestamp;
    return data;
  }
}

class UserProfile {
  int? id;
  String? profileId;
  Null? profession;
  Null? jobTitle;
  Null? placeOfWork;
  Null? city;
  Null? house;
  Null? website;
  Null? linkedIn;
  Null? instagram;
  Null? facebook;
  Null? twitter;
  bool? profileComplete;
  bool? verified;
  bool? isDeleted;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? user;
  int? room;

  UserProfile(
      {this.id,
      this.profileId,
      this.profession,
      this.jobTitle,
      this.placeOfWork,
      this.city,
      this.house,
      this.website,
      this.linkedIn,
      this.instagram,
      this.facebook,
      this.twitter,
      this.profileComplete,
      this.verified,
      this.isDeleted,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.user,
      this.room});

  UserProfile.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileId = json['profile_id'];
    profession = json['profession'];
    jobTitle = json['job_title'];
    placeOfWork = json['place_of_work'];
    city = json['city'];
    house = json['house'];
    website = json['website'];
    linkedIn = json['linked_in'];
    instagram = json['instagram'];
    facebook = json['facebook'];
    twitter = json['twitter'];
    profileComplete = json['profile_complete'];
    verified = json['verified'];
    isDeleted = json['is_deleted'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    user = json['user'];
    room = json['room'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['profile_id'] = this.profileId;
    data['profession'] = this.profession;
    data['job_title'] = this.jobTitle;
    data['place_of_work'] = this.placeOfWork;
    data['city'] = this.city;
    data['house'] = this.house;
    data['website'] = this.website;
    data['linked_in'] = this.linkedIn;
    data['instagram'] = this.instagram;
    data['facebook'] = this.facebook;
    data['twitter'] = this.twitter;
    data['profile_complete'] = this.profileComplete;
    data['verified'] = this.verified;
    data['is_deleted'] = this.isDeleted;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['user'] = this.user;
    data['room'] = this.room;
    return data;
  }
}
