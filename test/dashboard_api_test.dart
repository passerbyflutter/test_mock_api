import 'dart:async';
import 'dart:convert';
import 'package:cf_mock_api/dashboard_api.dart';
import 'package:test/test.dart';

main() {
  Dashboard dashboard;


  setUp(() {
    dashboard = new Dashboard();
  });

  test('test test', () async {
    List<Map<String, String>> target = await dashboard.getDashboardList();
    expect(JSON.encode(target), '[{"location":"Tokyo","vmCount":2,"rdsCount":1,"slbCount":2,"recentlyCount":2,"expireCount":0},{"location":"Singapore","vmCount":3,"rdsCount":2,"slbCount":2,"recentlyCount":1,"expireCount":1},{"location":"Taiwan","vmCount":1,"rdsCount":0,"slbCount":0,"recentlyCount":1,"expireCount":0}]');
  });


  tearDown(() {
    dashboard = null;
  });
}