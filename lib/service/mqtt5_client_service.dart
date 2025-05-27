import 'package:mqtt5_client/mqtt5_server_client.dart';

Future<MqttServerClient> connectMqttBroker() async {
  var client = MqttServerClient.withPort('10.56.148.130', 'hoyeong', 11883);

  client.logging(on: true);
  client.onConnected = () => print('[MQTT Client] Connected successful');
  client.onSubscribed = (subscription) => print('[MQTT Client] On subscribe ${subscription.topic}');
  client.onDisconnected = () => print('[MQTT Client] Drisconnected successful');
  await client.connect('sdh-flutter', '1234');
  return client;
}
