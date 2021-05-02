import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

import './apis/book.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<int> colorCodes = <int>[600, 500, 100];
  List<Book> books = [];

  void initState() {       
    super.initState();
    
    final dio = Dio();   // Provide a dio instance
    dio.options.headers["Demo-Header"] = "demo header";   // config your dio headers globally
    final bookClient = BookClient(dio);

    bookClient.getBooks().then((value) {  
      setState(() {
        books=value; 
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column( 
          children: [
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.all(8),
                itemCount: books.length,
                itemBuilder: (BuildContext context, int index) {
                  // return Text('1');
                  return Container(
                    height: 400,
                    // color: Colors.amber[colorCodes[0]],
                    child: Center(child: Text('title: ${books[index].title}, author: ${books[index].author}')),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('https://blogpfthumb-phinf.pstatic.net/MjAxOTEwMDJfMjky/MDAxNTY5OTg0OTAzNzQ4.CcZX4M4q6F0FIG3QiIBEIK-MLpAt8--5MX2KkojuIrkg.Ff5bzXJUUQWHLClks65v1HNbrA7qtISZYlrZqHvPKUwg.PNG.pjt3591oo/frog.png?type=w161'),
                        fit: BoxFit.cover,    // -> 02
                      ),
                    )
                  );
                },
                separatorBuilder: (BuildContext context, int index) => const Divider(),
              ), 
            )
          ]
        )
      ),
    );
  }
}