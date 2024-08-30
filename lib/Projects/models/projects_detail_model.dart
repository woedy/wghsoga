class ProjectDetailModel {
  String? message;
  Data? data;

  ProjectDetailModel({this.message, this.data});

  ProjectDetailModel.fromJson(Map<String, dynamic> json) {
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
  List<String>? projectImages;
  List<String>? projectVideos;
  String? projectId;
  String? title;
  String? details;
  String? target;
  String? raised;
  bool? draft;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;

  Data(
      {this.id,
      this.projectImages,
      this.projectVideos,
      this.projectId,
      this.title,
      this.details,
      this.target,
      this.raised,
      this.draft,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectImages = json['project_images'].cast<String>();
    projectVideos = json['project_videos'].cast<String>();
    projectId = json['project_id'];
    title = json['title'];
    details = json['details'];
    target = json['target'];
    raised = json['raised'];
    draft = json['draft'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['project_images'] = this.projectImages;
    data['project_videos'] = this.projectVideos;
    data['project_id'] = this.projectId;
    data['title'] = this.title;
    data['details'] = this.details;
    data['target'] = this.target;
    data['raised'] = this.raised;
    data['draft'] = this.draft;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
