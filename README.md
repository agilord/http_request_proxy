# HTTP request proxy

Proxy HTTP requests to other server
(typically from Dart backend to pub serve during development).

## Usage

A simple usage example:

    import 'dart:io';
    import 'package:http_request_proxy/http_request_proxy.dart';

    main() {
      var proxy = new HttpRequestProxy('localhost', 8000);
      HttpServer server = await HttpServer.bind(InternetAddress.ANY_IP_V4, 3333);
      server.listen((request) {
        if (request.uri.path.startsWith('/api/')) {
          // handle API call
        } else {
          // proxy to local pub serve
          proxy.proxyHttpRequest(request);
        }
      });
    }

## Sources

Source code can be found on [GitHub](https://github.com/agilord/http_request_proxy).
