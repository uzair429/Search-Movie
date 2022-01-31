import 'dart:async';
import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:movie_searcher/movie_display.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Search Movie'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  var moviecontroller = TextEditingController();
  late StreamController  streamcontroller;
  late Stream stream1;
  late Map<String , dynamic> movieMap;


  getMovieResult() async {
    var movieName = moviecontroller.text.trim();
    if(movieName.isEmpty){
      Fluttertoast.showToast(msg: 'Empty');
      streamcontroller.add("empty");
      return;
    }
    Fluttertoast.showToast(msg: "$movieName");
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      //Fluttertoast.showToast(msg: "connected with mobile");
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      //Fluttertoast.showToast(msg: "Connected with WiFi");
    }else{
      streamcontroller.add("no Internet");
      return;
    }

    // send server Request

    String url = 'http://www.omdbapi.com/?t=$movieName&apikey=d2deb805';

    streamcontroller.add("loading");
    http.Response response = await http.get(Uri.parse(url));
    if(response.statusCode == 200){
      var movieJason= json.decode(response.body);

      //print(movieJason);
      if(movieJason['response'] == "false"){
        streamcontroller.add('not Done');
      }else{
        streamcontroller.add('done');
        movieMap = movieJason;

      }

    }else{
      Fluttertoast.showToast(msg: "something went wrong");
    }

  }

  @override
  void initState(){
    streamcontroller = StreamController();
    stream1 = streamcontroller.stream;
    streamcontroller.add("empty");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {

       return Scaffold(
         backgroundColor: Colors.blue[50] ,
      appBar: AppBar(
         title: Text(widget.title),
      ),
      body:Padding(
        padding: EdgeInsets.all(18),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      color: Colors.white,
                    ),
                    child: TextField(
                      controller: moviecontroller,
                      decoration:  InputDecoration(
                        hintText: "Movie name",
                        border: OutlineInputBorder( borderRadius: BorderRadius.circular(16)),
                        
                      ),
                    ),
                  ),
                ),
                IconButton(onPressed: (){
                  getMovieResult();
                }, icon: Icon(Icons.search))
              ],
            ),
            const SizedBox(height: 12,),
            Expanded(
              child: StreamBuilder(
                stream: stream1,
                builder: (BuildContext context,AsyncSnapshot snapshot){
                  if(snapshot.hasData){
                    if(snapshot.data == 'empty'){
                      return const Center(child: Text("please Provide Movie Name"));
                    }
                    else if(snapshot.data == "no Internet"){
                      return  Center(child: Column(
                        children: const [
                          Text("you don't have Internet connection"),
                          Icon(Icons.cloud_off),
                        ],
                      ));

                    }else if(snapshot.data == 'loading'){
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }else if(snapshot.data == 'done'){
                      return movieDisplay(movieMap: movieMap);
                    }else{
                      return const Center(child: Text('Wrong Name'));
                    }
                  }else{
                    return const Text('Nothing Founded!');
                  }
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}



