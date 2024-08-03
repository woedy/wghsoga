class AllEventsModel {
  String? message;
  Data? data;

  AllEventsModel({this.message, this.data});

  AllEventsModel.fromJson(Map<String, dynamic> json) {
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
  List<Events>? events;
  Pagination? pagination;

  Data({this.events, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['events'] != null) {
      events = <Events>[];
      json['events'].forEach((v) {
        events!.add(new Events.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.events != null) {
      data['events'] = this.events!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Events {
  int? id;
  List<EventImages>? eventImages;
  List<EventVideos>? eventVideos;
  List<Attendees>? attendees;
  String? eventId;
  String? title;
  String? theme;
  String? subject;
  String? eventDate;
  String? eventTime;
  String? venue;
  String? organisedBy;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;

  Events(
      {this.id,
      this.eventImages,
      this.eventVideos,
      this.attendees,
      this.eventId,
      this.title,
      this.theme,
      this.subject,
      this.eventDate,
      this.eventTime,
      this.venue,
      this.organisedBy,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt});

  Events.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['event_images'] != null) {
      eventImages = <EventImages>[];
      json['event_images'].forEach((v) {
        eventImages!.add(new EventImages.fromJson(v));
      });
    }
    if (json['event_videos'] != null) {
      eventVideos = <EventVideos>[];
      json['event_videos'].forEach((v) {
        eventVideos!.add(new EventVideos.fromJson(v));
      });
    }
    if (json['attendees'] != null) {
      attendees = <Attendees>[];
      json['attendees'].forEach((v) {
        attendees!.add(new Attendees.fromJson(v));
      });
    }
    eventId = json['event_id'];
    title = json['title'];
    theme = json['theme'];
    subject = json['subject'];
    eventDate = json['event_date'];
    eventTime = json['event_time'];
    venue = json['venue'];
    organisedBy = json['organised_by'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.eventImages != null) {
      data['event_images'] = this.eventImages!.map((v) => v.toJson()).toList();
    }
    if (this.eventVideos != null) {
      data['event_videos'] = this.eventVideos!.map((v) => v.toJson()).toList();
    }
    if (this.attendees != null) {
      data['attendees'] = this.attendees!.map((v) => v.toJson()).toList();
    }
    data['event_id'] = this.eventId;
    data['title'] = this.title;
    data['theme'] = this.theme;
    data['subject'] = this.subject;
    data['event_date'] = this.eventDate;
    data['event_time'] = this.eventTime;
    data['venue'] = this.venue;
    data['organised_by'] = this.organisedBy;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class EventImages {
  int? id;
  String? image;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? event;

  EventImages(
      {this.id,
      this.image,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.event});

  EventImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    event = json['event'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['event'] = this.event;
    return data;
  }
}

class EventVideos {
  int? id;
  String? video;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? event;

  EventVideos(
      {this.id,
      this.video,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.event});

  EventVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    video = json['video'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    event = json['event'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video'] = this.video;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['event'] = this.event;
    return data;
  }
}

class Attendees {
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

  Attendees(
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

  Attendees.fromJson(Map<String, dynamic> json) {
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
