import 'package:mqtt5_client/mqtt5_server_client.dart';

Future<MqttServerClient> connectMqttBroker() async {
  var client = MqttServerClient.withPort('10.56.148.130', 'hoyeong', 11883);

  client.logging(on: true);
  await client.connect();

  return client;
}
