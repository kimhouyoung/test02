import 'package:test2/icons/info.dart';
import 'package:test2/icons/video.dart';
import 'package:test2/icons/chat.dart';
import 'package:test2/icons/tell.dart';
import 'package:flutter/material.dart';

typedef OnInitCallback = void Function(ExpansionTileController);
typedef OnUpdateCallback = void Function(ExpansionTileController);
class TogButton extends StatelessWidget {
  final OnInitCallback _onInit;
  final ExpansionTileController _controller = ExpansionTileController();
  final OnUpdateCallback _onUpdate;

  TogButton({
    super.key,
    required OnInitCallback onInit,
    required OnUpdateCallback onUpdate
  }) :
        this._onInit = onInit,
        this._onUpdate = onUpdate;

  @override
  Widget build(BuildContext context) {
    this._onInit(this._controller);
    return SizedBox(
      width: 440,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 10),
        child: ExpansionTile(
          controller: _controller,
          backgroundColor: Color.fromARGB(255, 43, 43, 43),
          childrenPadding: EdgeInsets.all(20),
          collapsedBackgroundColor: Color.fromARGB(255, 43, 43, 43),
          collapsedShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100),
          ),
          onExpansionChanged: (isExpand) {
            if(isExpand) {
              this._onUpdate(this._controller);
            }
          },
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          title: SingleChildScrollView(
            child: Row(
              children: [
                SizedBox(width: 12),
                Icon(
                  Icons.account_circle_sharp,
                  size: 30,
                  color: Color.fromARGB(255, 157, 127, 193),
                ),
                SizedBox(width: 30),
                Text(
                    '이예찬', style: TextStyle(color: Colors.white, fontSize: 25)),
              ],
            ),
          ),
          children: [
            Row(
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 15)),
                Text(
                  '전화번호 1661-4523',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              spacing: 20,
              children: [tell(), chat(), video(), info()],
            ),
          ],
        ),
      ),
    );
  }
}