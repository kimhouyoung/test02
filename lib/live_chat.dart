import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:test2/model/message.dart';
import 'package:test2/service/mqtt5_client_service.dart';

var payloadBuilder = MqttPayloadBuilder();
var clientId = '30401';
var name = '김영호';
var publishTopic = 'chat/pub/sdh-3-4';
var subscribeTopic = 'chat/sub/sdh-3-4';
bool a = true;
final _textEditingController = TextEditingController();

var scrollController = ScrollController();
class LiveChat extends StatefulWidget {
  const LiveChat({super.key});

  @override
  State<LiveChat> createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  late MqttServerClient client;
  final List<ReceiveMessage> messages = [];

  @override
  void initState() {
    super.initState();
    connectMqttBroker().then((client) {
      this.client = client;
      this.client.subscribe(subscribeTopic, MqttQos.atMostOnce);
      this.client.updates.listen((receives) {
        final receive =
            receives
                    .firstWhere((receives) => receives.topic == subscribeTopic)
                    .payload
                as MqttPublishMessage;
        final message = MqttUtilities.bytesToStringAsString(
          receive.payload.message!,
        );
        final receiveMessage = ReceiveMessage.jsonDeserialize(message);

        setState(() {
          messages.insert(0, receiveMessage);
        });
        scrollController.animateTo(0, duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    this.client.unsubscribeStringTopic(subscribeTopic);
    this.client.disconnect();
    _textEditingController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final textFieldRadius = OutlineInputBorder(
      borderRadius: BorderRadius.circular(80),
    );
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(double.infinity, size.height * 0.095),
        child: ColoredBox(
          color: Colors.black,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AppBar(
                backgroundColor: Colors.transparent,
                title: Align(
                  alignment: Alignment.centerLeft,
                  child: Row(
                    children: [
                      Icon(Icons.arrow_back, color: Colors.white, size: 30),
                      SizedBox(width: 25),
                      RichText(
                        text: TextSpan(
                          style: TextStyle(
                            fontFamily: 'Jua',
                            fontSize: size.height * 0.026,
                          ),
                          children: [
                            TextSpan(
                              text: '# ',
                              style: TextStyle(color: Colors.white),
                            ),
                            TextSpan(
                              text: '서울디지텍고 3학년 4반',
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 60),
                      Icon(Icons.search, color: Colors.white, size: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: ColoredBox(
                color: Colors.black87,
                child: ListView.separated(
                  controller: scrollController,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final bool me = message.clientId == clientId;
                    if(me) {
                      return SizedBox(
                        child:Padding(
                            padding: EdgeInsets.all(10),
                          child:Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      message.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      message.message,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      DateFormat(
                                        "yyyy년 MM월 dd일",
                                      ).format(message.sendDateTime),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      );
                    }else {
                      return SizedBox(
                        child: Padding(
                            padding: EdgeInsets.all(10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            spacing: 10,
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      message.name,
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      message.message,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                      ),
                                    ),
                                    Text(
                                      DateFormat(
                                        "yyyy년 MM월 dd일",
                                      ).format(message.sendDateTime),
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.white70,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                      );
                    }
                  },
                  itemCount: messages.length,
                  reverse: true,
                  separatorBuilder: (context, index) =>
                      Divider(height: 5, color: Colors.transparent),
                ),
              ),
            ),
            BottomAppBar(
              color: Colors.black,
              height: size.height * 0.1,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  controller: _textEditingController,
                  onSubmitted: (text) {
                    final message = SendMessage(
                      clientId: clientId,
                      message: text,
                      name: name,
                      topic: publishTopic,
                      qos: MqttQos.atMostOnce.index,
                    ).jsonSerialize;

                    payloadBuilder.clear();
                    payloadBuilder.addUTF8String(message);
                    this.client.publishMessage(
                      publishTopic,
                      MqttQos.atMostOnce,
                      payloadBuilder.payload!,
                    );
                    _textEditingController.clear();
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    enabledBorder: textFieldRadius,
                    focusedBorder: textFieldRadius,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    suffixIcon: IconButton(
                      onPressed: () {
                      },
                      icon: Icon(Icons.arrow_forward),
                    ),
                  ),
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      resizeToAvoidBottomInset: true,
    );
  }
}
