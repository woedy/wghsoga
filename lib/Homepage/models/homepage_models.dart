class HomeDataModel {
  String? message;
  Data? data;

  HomeDataModel({this.message, this.data});

  HomeDataModel.fromJson(Map<String, dynamic> json) {
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
  UserData? userData;
  bool? notification;
  List<Users>? users;
  List<News>? news;
  List<Events>? events;
  List<Projects>? projects;

  Data(
      {this.userData,
      this.notification,
      this.users,
      this.news,
      this.events,
      this.projects});

  Data.fromJson(Map<String, dynamic> json) {
    userData = json['user_data'] != null
        ? new UserData.fromJson(json['user_data'])
        : null;
    notification = json['notification'];
    if (json['users'] != null) {
      users = <Users>[];
      json['users'].forEach((v) {
        users!.add(new Users.fromJson(v));
      });
    }
    if (json['news'] != null) {
      news = <News>[];
      json['news'].forEach((v) {
        news!.add(new News.fromJson(v));
      });
    }
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(new Projects.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.userData != null) {
      data['user_data'] = this.userData!.toJson();
    }
    data['notification'] = this.notification;
    if (this.users != null) {
      data['users'] = this.users!.map((v) => v.toJson()).toList();
    }
    if (this.news != null) {
      data['news'] = this.news!.map((v) => v.toJson()).toList();
    }
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UserData {
  String? firstName;
  String? photo;

  UserData({this.firstName, this.photo});

  UserData.fromJson(Map<String, dynamic> json) {
    firstName = json['first_name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['first_name'] = this.firstName;
    data['photo'] = this.photo;
    return data;
  }
}

class Users {
  String? userId;
  String? firstName;
  String? lastName;
  String? photo;

  Users({this.userId, this.firstName, this.lastName, this.photo});

  Users.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    photo = json['photo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['first_name'] = this.firstName;
    data['last_name'] = this.lastName;
    data['photo'] = this.photo;
    return data;
  }
}

class News {
  String? newsId;
  String? title;
  String? content;
  String? newsImage;

  News({this.newsId, this.title, this.content, this.newsImage});

  News.fromJson(Map<String, dynamic> json) {
    newsId = json['news_id'];
    title = json['title'];
    content = json['content'];
    newsImage = json['news_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['news_id'] = this.newsId;
    data['title'] = this.title;
    data['content'] = this.content;
    data['news_image'] = this.newsImage;
    return data;
  }
}

class Events {
  String? eventId;
  String? title;
  String? eventDate;
  String? eventImage;

  Events({this.eventId, this.title, this.eventDate, this.eventImage});

  Events.fromJson(Map<String, dynamic> json) {
    eventId = json['event_id'];
    title = json['title'];
    eventDate = json['event_date'];
    eventImage = json['event_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['event_id'] = this.eventId;
    data['title'] = this.title;
    data['event_date'] = this.eventDate;
    data['event_image'] = this.eventImage;
    return data;
  }
}

class Projects {
  String? projectId;
  String? title;
  String? details;
  String? projectImage;

  Projects({this.projectId, this.title, this.details, this.projectImage});

  Projects.fromJson(Map<String, dynamic> json) {
    projectId = json['project_id'];
    title = json['title'];
    details = json['details'];
    projectImage = json['project_image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['project_id'] = this.projectId;
    data['title'] = this.title;
    data['details'] = this.details;
    data['project_image'] = this.projectImage;
    return data;
  }
}
