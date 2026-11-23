import 'dart:convert';
class PushNotificationModel {
  final String? id;
  final String? note;
  final String? body;
  final String? type;
  final String? title;
  final String? description;
  const PushNotificationModel({
    this.id,
    this.note,
    this.body,
    this.type,
    this.title,
    this.description,
  });
  factory PushNotificationModel.fromJson(Map<String, dynamic> json) { return PushNotificationModel(
    id: json['id'] as String?,
    note: json['note'] as String?,
    body: json['body'] as String?,
    type: json['type'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
  );
  }
}

