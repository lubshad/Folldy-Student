// To parse this JSON data, do
//
//     final learnScreenResponse = learnScreenResponseFromJson(jsonString);

import 'dart:convert';

LearnScreenResponse learnScreenResponseFromJson(String str) =>
    LearnScreenResponse.fromJson(json.decode(str));

String learnScreenResponseToJson(LearnScreenResponse data) =>
    json.encode(data.toJson());

class LearnScreenResponse {
  LearnScreenResponse({
    required this.status,
    required this.message,
    required this.data,
  });

  final int status;
  final String message;
  final Data data;

  factory LearnScreenResponse.fromJson(Map<String, dynamic> json) =>
      LearnScreenResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.topics,
    required this.subjects,
  });

  final List<Topic> topics;
  final List<Subject> subjects;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        topics: List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
        subjects: List<Subject>.from(
            json["subjects"].map((x) => Subject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
      };
}

class Subject {
  Subject({
    required this.id,
    required this.name,
    required this.semester,
    required this.course,
  });

  final int id;
  final String name;
  final int semester;
  final int course;

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        name: json["name"],
        semester: json["semester"],
        course: json["course"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "semester": semester,
        "course": course,
      };
}

class Topic {
  Topic({
    required this.id,
    required this.name,
    required this.chapter,
    required this.subject,
    required this.teachers,
    required this.languages,
    required this.thumbnail,
  });

  final int id;
  final String name;
  final Chapter chapter;
  final String subject;
  final String thumbnail;
  final List<Teacher> teachers;
  final List<String> languages;

  factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        thumbnail: json["thumbnail"],
        id: json["id"],
        name: json["name"],
        chapter: Chapter.fromJson(json["chapter"]),
        subject: json["subject"],
        teachers: List<Teacher>.from(
            json["teachers"].map((x) => Teacher.fromJson(x))),
        languages: List<String>.from(json["languages"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "chapter": chapter.toJson(),
        "subject": subject,
        "thumbnail": thumbnail,
        "teachers": List<dynamic>.from(teachers.map((x) => x.toJson())),
        "languages": List<dynamic>.from(languages.map((x) => x)),
      };
}

class Chapter {
  Chapter({
    required this.id,
    required this.name,
    required this.module,
    required this.subject,
  });

  final int id;
  final String name;
  final int module;
  final int subject;

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json["id"],
        name: json["name"],
        module: json["module"],
        subject: json["subject"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "module": module,
        "subject": subject,
      };
}

class Teacher {
  Teacher({
    required this.id,
    required this.name,
    required this.profile,
  });

  final int id;
  final String name;
  final String profile;

  factory Teacher.fromJson(Map<String, dynamic> json) => Teacher(
        id: json["id"],
        name: json["name"],
        profile: json["profile"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "profile": profile,
      };
}
