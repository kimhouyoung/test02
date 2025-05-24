
import 'package:test2/icons/chat.dart';
import 'package:test2/icons/info.dart';
import 'package:test2/icons/tell.dart';
import 'package:test2/icons/video.dart';
import 'package:flutter/material.dart';

typedef OnInitCallback = void Function(ExpansibleController);
typedef OnUpdateCallback = void Function(ExpansibleController);
class ToggleButton extends StatelessWidget {
  final OnInitCallback _onInit;
  final ExpansibleController _controller = ExpansibleController();
  final OnUpdateCallback _onUpdate;

  ToggleButton({
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
                Icon(Icons.phone_missed, size: 30, color: Colors.red),
                SizedBox(width: 14),
                Text(
                  '이항선 선생님',
                  style: TextStyle(color: Colors.white, fontSize: 25),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 36),
                  child: Text(
                    '오후 3:21',
                    style: TextStyle(color: Colors.grey, fontSize: 19),
                  ),
                ),
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
