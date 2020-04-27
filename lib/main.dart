import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/*
行李重量 + 头等舱 + 国外客人 + 残疾人
 */
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text("航空托运费用计算"),
            centerTitle: true,
          ),
          body: CalculatorShow()),
    );
  }
}

class CalculatorShow extends StatelessWidget {
  final uri =
      "https://ae01.alicdn.com/kf/H9579745812714ef2ac9a947f8a8893f4t.jpg";
  double weight = 0.0;
  bool isTopSeat = false;
  bool isNotChinese = false;
  bool isDisable = false;

  double ans = 0.0;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
      child: Container(
        height: 560,
        width: 400,
        color: Colors.grey,
        child: Stack(
          children: <Widget>[
            Align(
                alignment: Alignment.center,
                child: Stack(
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(this.uri),
                          fit: BoxFit.cover,
                          colorFilter: ColorFilter.mode(
                            Colors.black54,
                            BlendMode.overlay,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Opacity(
                          opacity: 0.05,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey.shade900,
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Align(
                alignment: Alignment(0, -0.8),
                child: Text(
                  "请输入托运行李的重量",
                  style: TextStyle(fontSize: 16),
                )),
            Align(
                alignment: Alignment(0, -0.5),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: TextField(
                    keyboardType: TextInputType.numberWithOptions(),
                    autofocus: false,
                    maxLength: 5,
                    decoration: const InputDecoration(
                      hintText: "单位是千克哟",
                      contentPadding: const EdgeInsets.all(15.0),
                    ),
                    onChanged: (val) {
                      this.weight = double.parse(val);
                      print(this.weight);
                    },
                  ),
                )),
            Align(
              alignment: Alignment(-0.6, 0),
              child: Switch(
                value: this.isTopSeat,
                activeColor: Colors.blueAccent,
                onChanged: (bool val) {
                  this.isTopSeat = !this.isTopSeat;
                  print(this.isTopSeat);
                },
              ),
            ),
            Align(
              alignment: Alignment(0.3, 0),
              child: Text("您是否为头等舱乘客", textAlign: TextAlign.left),
            ),
            Align(
              alignment: Alignment(-0.6, 0.25),
              child: Switch(
                value: this.isNotChinese,
                activeColor: Colors.blueAccent,
                onChanged: (bool val) {
                  this.isNotChinese = !this.isNotChinese;
                  print(this.isNotChinese);
                },
              ),
            ),
            Align(
              alignment: Alignment(0.3, 0.25),
              child: Text("您是否为国外游客    ", textAlign: TextAlign.left),
            ),
            Align(
              alignment: Alignment(-0.6, 0.5),
              child: Switch(
                value: this.isDisable,
                activeColor: Colors.blueAccent,
                onChanged: (bool val) {
                  this.isDisable = !this.isDisable;
                  print(this.isDisable);
                },
              ),
            ),
            Align(
              alignment: Alignment(0.3, 0.5),
              child: Text("您是否为残疾人        ", textAlign: TextAlign.left),
            ),
            Align(
                alignment: Alignment(0, 0.8),
                child: SizedBox(
                  width: 300,
                  height: 50,
                  child: FlatButton(
                    color: Colors.blueAccent,
                    highlightColor: Colors.blue[700],
                    colorBrightness: Brightness.dark,
                    splashColor: Colors.grey,
                    child: Text("计算费用"),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0)),
                    onPressed: () {
                      if (this.weight <= 30) {
                        this.ans = 0.0;
                      } else {
                        double overflowWeight = this.weight - 30.0;
                        if (this.isTopSeat == true) {
                          this.ans = 4 * overflowWeight;
                        } else {
                          this.ans = 6 * overflowWeight;
                        }
                        if (this.isNotChinese == true) {
                          this.ans *= 2.0;
                        }
                        if (this.isDisable == true) {
                          this.ans /= 2.0;
                        }
                      }
                      print("This is the answer: !!!!");
                      print(this.ans);
//                    showModalBottomSheet(
//                        context: context,
//                        builder: (BuildContext context) {
//                          return Container(
//                            height: 200,
//                            child: Text("您的缴费金额应为${this.ans}"),
//                          );
//                        }).then((val) {
//                      print(val);
//                    });
                      showDialog<Null>(
                          context: context,
                          barrierDismissible: false,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("结算"),
                              content: SingleChildScrollView(
                                child: ListBody(
                                  children: <Widget>[
                                    Text(
                                        "您的缴费金额为${this.ans.toStringAsFixed(1)}")
                                  ],
                                ),
                              ),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("确认"),
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                )
                              ],
                            );
                          }).then((onValue) {
                        print(onValue);
                      });
                    },
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
