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

  int status;
  String message;
  Data data;

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

  List<TopicElement> topics;
  List<Subject> subjects;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        topics: List<TopicElement>.from(
            json["topics"].map((x) => TopicElement.fromJson(x))),
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



class TopicElement {
  TopicElement({
    required this.presentations,
    required this.name,
    required this.id,
    required this.chapter,
    required this.subject,
  });

  List<Presentation> presentations;
  String name;
  int id;
  Chapter chapter;
  Subject subject;

  factory TopicElement.fromJson(Map<String, dynamic> json) => TopicElement(
        presentations: List<Presentation>.from(
            json["presentations"].map((x) => Presentation.fromJson(x))),
        name: json["name"],
        id: json["id"],
        chapter: Chapter.fromJson(json["chapter"]),
        subject: Subject.fromJson(json["subject"]),
      );

  Map<String, dynamic> toJson() => {
        "presentations":
            List<dynamic>.from(presentations.map((x) => x.toJson())),
        "name": name,
        "id": id,
        "chapter": chapter.toJson(),
        "subject": subject.toJson(),
      };
}

class Chapter {
  Chapter({
    required this.id,
    required this.name,
    required this.module,
    required this.subject,
  });

  int id;
  String name;
  int module;
  int subject;

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

class Presentation {
  Presentation({
    required this.teacher,
    required this.topic,
    required this.id,
    required this.audios,
    required this.slides,
  });

  Teacher teacher;
  PresentationTopic topic;
  int id;
  List<Audio> audios;
  List<Slide> slides;

  factory Presentation.fromJson(Map<String, dynamic> json) => Presentation(
        teacher: Teacher.fromJson(json["teacher"]),
        topic: PresentationTopic.fromJson(json["topic"]),
        id: json["id"],
        audios: List<Audio>.from(json["audios"].map((x) => Audio.fromJson(x))),
        slides: List<Slide>.from(json["slides"].map((x) => Slide.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "teacher": teacher.toJson(),
        "topic": topic.toJson(),
        "id": id,
        "audios": List<dynamic>.from(audios.map((x) => x.toJson())),
        "slides": List<dynamic>.from(slides.map((x) => x.toJson())),
      };
}

class Audio {
  Audio({
    required this.id,
    required this.language,
    required this.audio,
    required this.presentation,
  });

  int id;
  int language;
  String audio;
  int presentation;

  factory Audio.fromJson(Map<String, dynamic> json) => Audio(
        id: json["id"],
        language: json["language"],
        audio: json["audio"],
        presentation: json["presentation"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "language": language,
        "audio": audio,
        "presentation": presentation,
      };
}

class Slide {
  Slide({
    required this.id,
    required this.slide,
    required this.displayOrder,
  });

  int id;
  String slide;
  int displayOrder;

  factory Slide.fromJson(Map<String, dynamic> json) => Slide(
        id: json["id"],
        slide: json["slide"],
        displayOrder: json["display_order"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "slide": slide,
        "display_order": displayOrder,
      };
}

class Teacher {
  Teacher({
    required this.id,
    required this.name,
    required this.profile,
  });

  int id;
  String name;
  String profile;

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

class PresentationTopic {
  PresentationTopic({
    required this.id,
    required this.name,
    required this.chapter,
  });

  int id;
  String name;
  int chapter;

  factory PresentationTopic.fromJson(Map<String, dynamic> json) =>
      PresentationTopic(
        id: json["id"],
        name: json["name"],
        chapter: json["chapter"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "chapter": chapter,
      };
}

