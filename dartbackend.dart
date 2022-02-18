import 'dart:convert';

import 'package:dartbackend/DB/connectionSettings.dart';
import 'package:dartbackend/dartbackend.dart' as dartbackend;
import 'package:galileo_mysql/galileo_mysql.dart';
import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_static/shelf_static.dart';

void main(List<String> arguments) {
  final staticHandler = createStaticHandler(
    "./../public/",
    defaultDocument: "index.html",
    serveFilesOutsidePath: true,
  );

  final app = Router(notFoundHandler: staticHandler);

  /* app.get(
    "/",
    indexRouter,
  ); */

  // app.post("/", indexPostRoute);

  serve(app, "localhost", 8080);
}

Response indexPostRoute(Request request) {
  print("indexPostRoute");
  return Response.ok("created");
}

Future<Response> indexRouter(Request request) async {
  var conn = await MySqlConnection.connect(settings);
  var results = await conn.query('select * from users;');
  print(results.first.fields);
  // var userdata = results.first.fields;
  var userdata = results.map((e) {
    e.fields.remove("created_at");
    return e.fields;
  }).toList();
  // userdata["created_at"] = null;
  // userdata.remove("created_at");

  print("index route.");
  final map = {
    "user": {
      "id": 1,
      "email": "emre@surk.net",
    },
  };
  return Response.ok(jsonEncode(userdata));
}
