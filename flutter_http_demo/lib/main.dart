import 'package:flutter/material.dart';
import 'package:flutter_http/http_client_manager.dart';
import 'package:flutter_http_demo/response_entity.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Http Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Http Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ResponseEntity _responseEntity;

  void _request() {
    // 请求数据，泛型为返回数据类型
    HttpClientManager().get<ResponseEntity>(const ResponseEntity(),
        "http://123.56.84.189:12306/").then((responseEntity){
      setState(() {
        _responseEntity = responseEntity;
      });
    }).catchError((error){
      print(error.toString());
    });
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text(
              'Data requested:',
              style: Theme.of(context).textTheme.display2,
            ),
            new Text(
              '${_responseEntity == null ? "" : _responseEntity.title}',
              style: Theme.of(context).textTheme.display2,
            ),
            new Text(
              '${_responseEntity == null ? "" : _responseEntity.content}',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: new FloatingActionButton(
        onPressed: _request,
        tooltip: 'Request Data',
        child: new Icon(Icons.http),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
