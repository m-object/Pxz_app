import 'package:flutter/material.dart';

import 'UserChangePhome2.dart';

class UserChangePhomePage extends StatefulWidget {
  UserChangePhomePage({Key key}) : super(key: key);

  @override
  _UserChangePhomePageState createState() => _UserChangePhomePageState();
}

class _UserChangePhomePageState extends State<UserChangePhomePage> {
  FocusNode _oldPhome = FocusNode();

  @override
  void initState() {
    _oldPhome.addListener(() {
      if (!_oldPhome.hasFocus) {
        print("失去焦点");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("修改手机号")),
      backgroundColor: Color(0xffededed),
      body: SingleChildScrollView(
        child: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: <Widget>[
                  SizedBox(
                      width: 80,
                      child: Text("原手机号",
                          style: TextStyle(color: Color(0xff606060)))),
                  Expanded(
                    child: TextField(
                      focusNode: _oldPhome,
                      decoration: null,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 60,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(4)),
              child: Row(
                children: <Widget>[
                  SizedBox(
                      width: 80,
                      child: Text("验证码",
                          style: TextStyle(color: Color(0xff606060)))),
                  Expanded(
                    child: TextField(
                      decoration: null,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      "获取验证码",
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text("如果原手机号无法接受短信，请联系客服。"),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: FlatButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => UserChangePhomePage2()
                    ));
                  },
                  color: Color(0xfff3d72f),
                  child: Text("下一步", style: TextStyle(color: Colors.white))),
            )
          ],
        ),
      ),
    ));
  }
}