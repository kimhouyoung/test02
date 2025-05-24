import 'package:test2/button/toggle_button.dart';
import 'package:flutter/material.dart';

import 'button/toggle_button.dart';

class Telephone extends StatefulWidget {
  const Telephone({super.key});

  @override
  State<Telephone> createState() => Tel();
}

class Tel extends State<Telephone> {
  late List<ExpansionTileController> _controllers;
  static final int maximumRecent = 2;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this._controllers = [];
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 1000,
      child: ColoredBox(
        color: Colors.black,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 50),
          child: Column(
            children: [
              Text('전화', style: TextStyle(color: Colors.white, fontSize: 70)),
              Text(
                '전화번호가 저장된 연락처 ${maximumRecent}개',
                style: TextStyle(color: Colors.white38, fontSize: 30),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Icon(Icons.add, size: 45, color: Colors.white),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 13)),
                    Icon(Icons.search, size: 45, color: Colors.white),
                    Padding(padding: EdgeInsets.symmetric(horizontal: 13)),
                    Icon(Icons.more_vert, size: 45, color: Colors.white),
                  ],
                ),
              ),
              Column(
                children: [
                  for (int c = 1; c <= maximumRecent; c++)
                    TogButton(
                      onInit: (controller) {
                        this._controllers.add(controller);
                      },
                      onUpdate: (controller) {
                        int a = _controllers.length;
                        for(int i = 0; i < a; i++) {
                          var _con = this._controllers[i];
                          if(_con != controller) {
                            if(_con.isExpanded) {
                              _con.collapse();
                              break;
                            }
                          }
                        }
                      },
                    )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}