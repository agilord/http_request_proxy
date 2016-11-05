// Copyright (c) 2016, Agilord. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

library http_request_proxy;

import 'dart:async';
import 'dart:io';

/// Proxy HTTP requests to other server
/// (typically from Dart backend to pub serve during development).
class HttpRequestProxy {
  /// Target server hostname.
  final String host;

  /// Target server port.
  final int port;

  final HttpClient _client = new HttpClient();

  ///
  HttpRequestProxy(this.host, this.port);

  /// Proxy the HTTP request to the specified server.
  Future proxyHttpRequest(HttpRequest request) async {
    HttpClientRequest rq =
    await _client.open(request.method, host, port, request.uri.path);
    await rq.addStream(request);
    HttpClientResponse rs = await rq.close();
    HttpResponse r = request.response;
    r.statusCode = rs.statusCode;
    r.headers.contentType = rs.headers.contentType;
    await r.addStream(rs);
    await r.flush();
    await r.close();
  }

  /// Close active connections.
  void close() {
    _client.close(force: true);
  }
}
