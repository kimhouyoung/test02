import 'package:test2/recent.dart';
import 'package:test2/telephone.dart';
import 'package:test2/telephone.dart';
import 'package:flutter/material.dart';

import 'keypad.dart';
import 'telephone.dart';

void main() {
  runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent
        ),
        home: DefaultTabController(
            initialIndex: 2,
            length: 3,
            child: SafeArea(
                child: Scaffold(
                    backgroundColor: Colors.black,
                    body: Column(
                        children: [
                          Expanded(
                            child: TabBarView(
                                children: [
                                  KeypadView(),
                                  SingleChildScrollView(
                                    child: Recent(),
                                  ),
                                  SingleChildScrollView(
                                    child: Telephone(),
                                  )
                                ]
                            ),
                          ),
                          SizedBox(
                              height: 70,
                            child: Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Colors.transparent,
                                    width: 0
                                  ),
                                )
                              ),
                                child: const TabBar(
                                  tabs: [
                                    Tab(text: '키패드'),
                                    Tab(text: '최근기록'),
                                    Tab(text: '연락처'),
                                  ],
                                  labelColor: Colors.white,
                                  labelStyle: TextStyle(
                                      fontSize: 22
                                  ),
                                  unselectedLabelColor: Color.fromARGB(240, 151, 151, 151),
                                  unselectedLabelStyle: TextStyle(
                                      fontSize: 20
                                  ),
                                  indicatorColor: Colors.white,
                                  indicatorWeight: 1,
                                )
                            ),
                          )
                        ]
                    )
                )
            )
        )
    );
  }
}