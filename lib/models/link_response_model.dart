// To parse this JSON data, do
//
//     final link = linkFromJson(jsonString);

import 'dart:convert';

Link linkFromJson(String str) => Link.fromJson(json.decode(str));

String linkToJson(Link data) => json.encode(data.toJson());

class Link {
    List<LinkElement> links;

    Link({
        required this.links,
    });

    factory Link.fromJson(Map<String, dynamic> json) => Link(
        links: List<LinkElement>.from(json["links"].map((x) => LinkElement.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "links": List<dynamic>.from(links.map((x) => x.toJson())),
    };
}

class LinkElement {
    int id;
    String title;
    String link;
    String? username;
    int isActive;
    int userId;
    DateTime createdAt;
    DateTime updatedAt;

    LinkElement({
        required this.id,
        required this.title,
        required this.link,
        required this.username,
        required this.isActive,
        required this.userId,
        required this.createdAt,
        required this.updatedAt,
    });

    factory LinkElement.fromJson(Map<String, dynamic> json) => LinkElement(
        id: json["id"],
        title: json["title"],
        link: json["link"],
        username: json["username"],
        isActive: json["isActive"],
        userId: json["user_id"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "link": link,
        "username": username,
        "isActive": isActive,
        "user_id": userId,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
    };
}