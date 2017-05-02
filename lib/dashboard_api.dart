import 'dart:async';
import 'dart:convert';
import 'package:rpc/rpc.dart';

@ApiClass(version: 'v1', name: 'dashboard')
class Dashboard {

  JsonDecoder _decoder = new JsonDecoder();

  Dashboard();

  // API 文件範例僅給 Tokyo 資料，自行補入 Singapore 與 Taiwan
  ///儀表板各服務數量計算
  @ApiMethod(path: 'dashboard/serviceCount', method: 'GET')
  Future<List<Map<String, String>>> getDashboardList() async {
    await new Future.delayed(new Duration(seconds: 1));
    return _decoder.convert('[{"location":"Tokyo","vmCount":2,"rdsCount":1,"slbCount":2,"recentlyCount":2,"expireCount":0},{"location":"Singapore","vmCount":3,"rdsCount":2,"slbCount":2,"recentlyCount":1,"expireCount":1},{"location":"Taiwan","vmCount":1,"rdsCount":0,"slbCount":0,"recentlyCount":1,"expireCount":0}]');
  }

}