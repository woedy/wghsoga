class AllProjectsModel {
  String? message;
  Data? data;

  AllProjectsModel({this.message, this.data});

  AllProjectsModel.fromJson(Map<String, dynamic> json) {
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
  List<Projects>? projects;
  Pagination? pagination;

  Data({this.projects, this.pagination});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['projects'] != null) {
      projects = <Projects>[];
      json['projects'].forEach((v) {
        projects!.add(new Projects.fromJson(v));
      });
    }
    pagination = json['pagination'] != null
        ? new Pagination.fromJson(json['pagination'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.projects != null) {
      data['projects'] = this.projects!.map((v) => v.toJson()).toList();
    }
    if (this.pagination != null) {
      data['pagination'] = this.pagination!.toJson();
    }
    return data;
  }
}

class Projects {
  int? id;
  List<ProjectImages>? projectImages;
  List<ProjectVideos>? projectVideos;
  String? projectId;
  String? title;
  String? details;
  String? target;
  Null? raised;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;

  Projects(
      {this.id,
      this.projectImages,
      this.projectVideos,
      this.projectId,
      this.title,
      this.details,
      this.target,
      this.raised,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt});

  Projects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    if (json['project_images'] != null) {
      projectImages = <ProjectImages>[];
      json['project_images'].forEach((v) {
        projectImages!.add(new ProjectImages.fromJson(v));
      });
    }
    if (json['project_videos'] != null) {
      projectVideos = <ProjectVideos>[];
      json['project_videos'].forEach((v) {
        projectVideos!.add(new ProjectVideos.fromJson(v));
      });
    }
    projectId = json['project_id'];
    title = json['title'];
    details = json['details'];
    target = json['target'];
    raised = json['raised'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.projectImages != null) {
      data['project_images'] =
          this.projectImages!.map((v) => v.toJson()).toList();
    }
    if (this.projectVideos != null) {
      data['project_videos'] =
          this.projectVideos!.map((v) => v.toJson()).toList();
    }
    data['project_id'] = this.projectId;
    data['title'] = this.title;
    data['details'] = this.details;
    data['target'] = this.target;
    data['raised'] = this.raised;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}

class ProjectImages {
  int? id;
  String? image;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? project;

  ProjectImages(
      {this.id,
      this.image,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.project});

  ProjectImages.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    project = json['project'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['project'] = this.project;
    return data;
  }
}

class ProjectVideos {
  int? id;
  String? video;
  bool? isArchived;
  bool? active;
  String? createdAt;
  String? updatedAt;
  int? project;

  ProjectVideos(
      {this.id,
      this.video,
      this.isArchived,
      this.active,
      this.createdAt,
      this.updatedAt,
      this.project});

  ProjectVideos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    video = json['video'];
    isArchived = json['is_archived'];
    active = json['active'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    project = json['project'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['video'] = this.video;
    data['is_archived'] = this.isArchived;
    data['active'] = this.active;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['project'] = this.project;
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
