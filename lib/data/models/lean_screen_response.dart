// To parse this JSON data, do
//
//     final learnScreenResponse = learnScreenResponseFromJson(jsonString);

import 'dart:convert';

LearnScreenResponse learnScreenResponseFromJson(String str) => LearnScreenResponse.fromJson(json.decode(str));

String learnScreenResponseToJson(LearnScreenResponse data) => json.encode(data.toJson());

class LearnScreenResponse {
    LearnScreenResponse({
        required this.status,
        required this.message,
        required this.data,
    });

    int status;
    String message;
    Data? data;

    factory LearnScreenResponse.fromJson(Map<String, dynamic> json) => LearnScreenResponse(
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "data": data == null ? null :  data!.toJson(),
    };
}

class Data {
    Data({
        required this.topics,
        required this.subjects,
    });

    List<Topic> topics;
    List<Subject> subjects;

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        topics: List<Topic>.from(json["topics"].map((x) => Topic.fromJson(x))),
        subjects: List<Subject>.from(json["subjects"].map((x) => Subject.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "topics": List<dynamic>.from(topics.map((x) => x.toJson())),
        "subjects": List<dynamic>.from(subjects.map((x) => x.toJson())),
    };
}

class Subject {
    Subject({
        required this.id,
        required this.course,
        required this.name,
        required this.semester,
    });

    int id;
    String course;
    String name;
    int semester;

    factory Subject.fromJson(Map<String, dynamic> json) => Subject(
        id: json["id"],
        course: json["course"],
        name: json["name"],
        semester: json["semester"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "course": course,
        "name": name,
        "semester": semester,
    };
}

class Topic {
    Topic({
        required this.id,
        required this.name,
        required this.chapter,
        required this.subject,
        required this.module,
        required this.teacher,
    });

    int id;
    String name;
    String chapter;
    String subject;
    int module;
    String teacher;

    factory Topic.fromJson(Map<String, dynamic> json) => Topic(
        id: json["id"],
        name: json["name"],
        chapter: json["chapter"],
        subject: json["subject"],
        module: json["module"],
        teacher: json["teacher"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "chapter": chapter,
        "subject": subject,
        "module": module,
        "teacher": teacher,
    };
}
