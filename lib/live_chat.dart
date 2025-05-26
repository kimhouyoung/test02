import 'package:flutter/material.dart';
import 'package:mqtt5_client/mqtt5_server_client.dart';
import 'package:mqtt5_client/mqtt5_client.dart';
import 'package:test2/service/mqtt5_client_service.dart';

class LiveChat extends StatefulWidget {
  const LiveChat({super.key});

  @override
  State<LiveChat> createState() => _LiveChatState();
}

class _LiveChatState extends State<LiveChat> {
  late MqttServerClient client;
  final List<String> messages = [];

  @override
  void initState() {
    super.initState();
    connectMqttBroker().then((client) {
      this.client = client;
      this.client.subscribe('game/tile', MqttQos.atMostOnce);
      this.client.updates.listen((event) {
        final receive = event[0].payload as MqttPublishMessage;
        final message = MqttUtilities.bytesToStringAsString(receive.payload.message!);

        setState(() {
          messages.add(message);
        });

      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    this.client.disconnect();
  }

  @override
  Widget build(BuildContext context) {
    connectMqttBroker();
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
                  itemBuilder: (context, index) {
                    return SizedBox(
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        spacing: 10,
                        children: [
                          Icon(
                            Icons.account_circle_sharp,
                            size: 40,
                            color: Colors.purpleAccent,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'nickname',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                '$messages[$index]',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => Divider(height: 10),
                  itemCount: 7,
                ),
              ),
            ),
            BottomAppBar(
              color: Colors.black,
              height: size.height * 0.1,
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: TextField(
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white10,
                    enabledBorder: textFieldRadius,
                    focusedBorder: textFieldRadius,
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    suffixIcon: IconButton(
                      onPressed: () {},
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
