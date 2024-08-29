class EventDetailModel {
  String? message;
  Data? data;

  EventDetailModel({this.message, this.data});

  EventDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? eventImages;
  List<String>? eventVideos;
  String? eventId;
  String? title;
  String? theme;
  String? subject;
  String? eventDate;
  String? eventTime;
  String? venue;
  String? organisedBy;
  bool? draft;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.eventImages,
      this.eventVideos,
      this.eventId,
      this.title,
      this.theme,
      this.subject,
      this.eventDate,
      this.eventTime,
      this.venue,
      this.organisedBy,
      this.draft,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    eventImages = json['event_images'].cast<String>();
    eventVideos = json['event_videos'].cast<String>();

    eventId = json['event_id'];
    title = json['title'];
    theme = json['theme'];
    subject = json['subject'];
    eventDate = json['event_date'];
    eventTime = json['event_time'];
    venue = json['venue'];
    organisedBy = json['organised_by'];
    draft = json['draft'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['event_images'] = this.eventImages;
    data['event_videos'] = this.eventVideos;

    data['event_id'] = this.eventId;
    data['title'] = this.title;
    data['theme'] = this.theme;
    data['subject'] = this.subject;
    data['event_date'] = this.eventDate;
    data['event_time'] = this.eventTime;
    data['venue'] = this.venue;
    data['organised_by'] = this.organisedBy;
    data['draft'] = this.draft;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
