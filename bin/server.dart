// Copyright (c) 2017, Eric Li. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:io';

import 'package:args/args.dart';
import 'package:cf_mock_api/dashboard_api.dart';
import 'package:rpc/rpc.dart';
import 'package:shelf/shelf.dart' as shelf;
import 'package:shelf/shelf_io.dart' as io;
import 'package:shelf_route/shelf_route.dart' as shelf_route;
import 'package:shelf_rpc/shelf_rpc.dart' as shelf_rpc;

const _API_PREFIX = '/rest';
final ApiServer _apiServer = new ApiServer(apiPrefix: _API_PREFIX, prettyPrint: true);

void main(List<String> args) {
  var parser = new ArgParser()
    ..addOption('port', abbr: 'p', defaultsTo: '31415');

  var result = parser.parse(args);

  var port = int.parse(result['port'], onError: (val) {
    stdout.writeln('Could not parse port value "$val" into a number.');
    exit(1);
  });

  _apiServer.addApi(new Dashboard());
  _apiServer.enableDiscoveryApi();

  var apiHandler = shelf_rpc.createRpcHandler(_apiServer);

  var apiRouter = shelf_route.router();
  apiRouter.add(_API_PREFIX, null, apiHandler, exactMatch: false);
  var handler = const shelf.Pipeline()
      .addMiddleware(shelf.logRequests())
      .addHandler(apiRouter.handler);

  io.serve(handler, '127.0.0.1', port).then((server) {
    print('Serving at http://${server.address.host}:${server.port}');
  });

}
