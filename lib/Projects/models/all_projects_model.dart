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
  String? projectImage;
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

  Projects(
      {this.id,
      this.projectImage,
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

  Projects.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    projectImage = json['project_image'];
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
    data['project_image'] = this.projectImage;
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
