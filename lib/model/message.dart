import 'dart:convert';

import 'package:flutter/material.dart';

abstract class Message {
  String get message;

  String get clientId;

  String get name;
}

class DefaultMessage implements Message {

  final String _name;
  final String _clientId;
  final String _message;

  DefaultMessage(this._clientId,
      this._message,
      this._name);

  @override
  String get clientId => _clientId;

  @override
  String get message => _message;

  @override
  String get name => _name;
}

class SendMessage extends DefaultMessage {
  final String _topic;
  final int _qos;

  SendMessage({
    required final String clientId,
    required final String message,
    required final String name,
    required String topic,
    required int qos
  })
      :
        _topic = topic,
        _qos = qos,
        super(clientId, message, name);

  String get topic => _topic;

  int get qos => _qos;

  String get jsonSerialize => jsonEncode(this.jsonDeserialize);

  Map<String, dynamic> get jsonDeserialize =>
      {
        'clientId': super._clientId,
        'name': super._name,
        'message': super._message,
        'topic': this._topic,
        'qos': this._qos,
      };
}

class ReceiveMessage extends DefaultMessage {
  final DateTime _sendDateTime;

  ReceiveMessage({
    required final String clientId,
    required final String message,
    required final String name,
    required final DateTime sendDateTime
  })
      :
        _sendDateTime = sendDateTime,
        super(clientId, message, name);

  DateTime get sendDateTime => _sendDateTime;

  static ReceiveMessage jsonDeserialize(final json) {
    var object = jsonDecode(json);

    return ReceiveMessage(
        clientId: object['clientId'],
        message: object['message'],
        name: object['name'],
        sendDateTime: DateTime.parse(object['sendDateTime'])
    );
  }
}