import 'dart:async';
import 'package:flutter/material.dart';

/// 墨水瓶（`InkWell`）可用时使用的字体样式。
final TextStyle _availableStyle = TextStyle(
  fontSize: 16.0,
  // color: const Color(0xFF00CACE),
  color: Colors.blue
);

/// 墨水瓶（`InkWell`）不可用时使用的样式。
final TextStyle _unavailableStyle = TextStyle(
  fontSize: 16.0,
  color: const Color(0xFFCCCCCC),
);

class LoginFormCode extends StatefulWidget {
  /// 倒计时的秒数，默认60秒。
  final int countdown;
  /// 用户点击时的回调函数。
  final Function onTapCallback;
  /// 是否可以获取验证码，默认为`false`。
  final bool available;

  LoginFormCode({
    this.countdown: 60,
    this.onTapCallback,
    this.available: false,
  });

  @override
  _LoginFormCodeState createState() => _LoginFormCodeState();
}

class _LoginFormCodeState extends State<LoginFormCode> {
  /// 倒计时的计时器。
  Timer _timer;
  /// 当前倒计时的秒数。
  int _seconds;
  /// 当前墨水瓶（`InkWell`）的字体样式。
  TextStyle inkWellStyle = _availableStyle;
  /// 当前墨水瓶（`InkWell`）的文本。
  String _verifyStr = '获取验证码';

  @override
  void initState() {
    super.initState();
    _seconds = widget.countdown;
  }

  /// 启动倒计时的计时器。
  void _startTimer() {
    // 计时器（`Timer`）组件的定期（`periodic`）构造函数，创建一个新的重复计时器。
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
      if (_seconds == 0) {
        _cancelTimer();
        _seconds = widget.countdown;
        inkWellStyle = _availableStyle;
        setState(() {});
        _verifyStr = '重新发送';
        return;
      }
      //! 内存泄漏
      //! E/flutter (12234): [ERROR:flutter/lib/ui/ui_dart_state.cc(148)] Unhandled Exception: setState() called after dispose()
      // flutter通过消息通道发送一个消息，然后await等待消息返回，最终宿主app会调用reply.reply(obj)方法返回数据。
      // 如果在这个过程中，flutter页面关闭，就会出现如下异常，类似Android中的内存泄漏。
      // 也就是说，在seconds倒计时的同时如果页面退出，就会导致内存泄漏
      // 解决方法：在setState方法之前调用mouted属性进行判断即可
      if(mounted){
        setState(() {
          _seconds--;
          _verifyStr = '已发送$_seconds'+'s';
        });
      }
      
    });
  }

  /// 取消倒计时的计时器。
  void _cancelTimer() {
    // 计时器（`Timer`）组件的取消（`cancel`）方法，取消计时器。
    _timer?.cancel();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 墨水瓶（`InkWell`）组件，响应触摸的矩形区域。
    return widget.available ? InkWell(
      child: Text(
        '  $_verifyStr  ',
        style: inkWellStyle,
      ),
      onTap: (_seconds == widget.countdown) ? () {
        _startTimer();
        inkWellStyle = _unavailableStyle;
        _verifyStr = '已发送$_seconds'+'s';
        setState(() {});
        widget.onTapCallback();
      } : null,
    ): InkWell(
      child: Text(
        '  获取验证码  ',
        style: _unavailableStyle,
      ),
    );
  }
}
