import 'dart:async';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import './countdown.dart';

// class SpacecatLogin {
//   static const MethodChannel _channel =
//       const MethodChannel('spacecat_login');

//   static Future<String> get platformVersion async {
//     final String version = await _channel.invokeMethod('getPlatformVersion');
//     return version;
//   }
// }

class SpacecatLogin extends StatefulWidget {
  @override
  _SpacecatLoginState createState() => _SpacecatLoginState();
}

class _SpacecatLoginState extends State<SpacecatLogin> {

  // final _formKey = GlobalKey<FormState>();
  String _phone, _smscode;
  bool _isObscure = true;
  Color _eyeColor;


  FocusNode focusNodePhone = new FocusNode();
  FocusNode focusNodePassword = new FocusNode();
  // ScrollController _controller = new ScrollController();
  // bool swiper = true;
  bool isLoading = false;
  String loginTitle;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isLoading = false;
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        reverse: true,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height:40),
            FlatButton.icon(
              label: Text('返回',style:TextStyle(color:Colors.grey[50])),
              icon: Icon(Icons.arrow_back,size:26),
              onPressed: (){
                
                Navigator.of(context).pushNamedAndRemoveUntil("/login", (Route<dynamic> route) => false);
              },
            ),
            buildTitle(),
            
            buildPhone(),
            buildPassword(),
            SizedBox(height:60),
            // buildSecurityGuardIDText(),
            buildLoginButton(context)
            
          ],
        ),
      )
    );
  }
  

  // 登录按钮
  Align buildLoginButton(BuildContext context) {
    return Align(
      child: isLoading == true
      ? Container(
          margin: EdgeInsets.fromLTRB(20,10,20,20),
          width: 1000,
          height: 40,
          child: FlatButton(
            child: Image.asset('assets/images/loadingIcon.gif',width:20,height:20),
            color: Colors.grey[300],
            onPressed: () {},
            // shape: StadiumBorder(side: BorderSide.none),
          ),
        )
      
      
      : Container(
        margin: EdgeInsets.fromLTRB(20,10,20,20),
        width: 1000,
        height: 40,
        child: FlatButton(
          child: Text(
            '登录',
            style: TextStyle(color:Colors.white,fontSize:18)
          ),
          color: Colors.blue[400],
          onPressed: () {},
          // shape: StadiumBorder(side: BorderSide.none),
        ),
      )
    );
  }


  Widget buildTitle() {
    return GestureDetector(
      child: Container(
        color: Colors.grey[50],
        padding: EdgeInsets.only(left: 20.0, top:40, bottom:20),
        child: Row(
          children: <Widget>[
            Text(
              '验证码登录',
              style: TextStyle(
                fontSize: 22.0,
                fontWeight:FontWeight.w500
                // color: Colors.blue
              ),
            ),
          ],
        )
      ),
      onTap: (){
        FocusScope.of(context).requestFocus(FocusNode());
      }
    );
  }


  // TODO: 账号登录
  Padding buildPhone() {
    return Padding(
      padding: EdgeInsets.only(left:20, top:0, bottom:10, right:20),
      child: TextField(
        keyboardType: TextInputType.phone,
        decoration: InputDecoration(
          // hintText: '+86 ${Provider.of<LoginData>(context).phone}',
          // hintStyle: TextStyle(color:Colors.black),
          contentPadding: EdgeInsets.only(top:12),
          prefixIcon: Container(
            padding: EdgeInsets.fromLTRB(0,12,10,0),
            child: Text('账号              +86',style:TextStyle(fontSize:16))
          ),
          prefixStyle: TextStyle(fontSize:18),
          hintText: '请输入手机号码',
          hintStyle: TextStyle(color: Colors.grey[350]),
        ),
        // readOnly: true,
        onChanged: (value){
          if ( value.length >= 11 ) {
            setState(() {
              _phone = value;
            });
          } else {
            setState(() {
              _phone = '';
            });
          }
        },
      )
    );
  }


  // TODO: 输入密码
  Padding buildPassword() {
    return Padding(
      padding: EdgeInsets.only(left:20, top:0, bottom:10, right:20),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Container(
            padding: EdgeInsets.fromLTRB(0,12,10,0),
            child: Text('验证码       ',style:TextStyle(fontSize:16))
          ),
          // prefixStyle: TextStyle(fontSize:18),
          hintText: '请输入验证码',
          hintStyle: TextStyle(color: Colors.grey[350]),
          suffixIcon: Container(
            padding: EdgeInsets.only(top:12),
            child: _phone == null || _phone == ''
            ? GestureDetector(
              child: Container(
                padding: EdgeInsets.fromLTRB(0,0,8,0),
                child: Text('获取验证码', style: TextStyle(color: Colors.grey[500],fontSize:16.0))
              ),
              onTap: (){
                Fluttertoast.showToast(msg: "请输入11位有效手机号码");
              }
            )
            : LoginFormCode(
              countdown: 60,
              available: true,
              onTapCallback: (){
                // TODO:回调验证码接口

              },
          ))
        ),
        focusNode: focusNodePhone,
        onChanged: (value){
          _smscode = value;
        },
        
      )
    );
  }
}
