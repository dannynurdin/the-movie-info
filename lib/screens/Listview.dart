import 'package:dicoding_submission_danny/screens/MovieDetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:math';

class Example extends StatefulWidget {
  @override
  _ExampleState createState() => _ExampleState();
}

class _ExampleState extends State<Example> {
  double b;

  Trending() async {
    // https://api.themoviedb.org/3/trending/all/day?api_key=<<api_key>>
    https://api.themoviedb.org/3/discover/movie?api_key=62b1bf944f74eeec527159433d39b68a&language=en-US&sort_by=popularity.desc&page=1&with_genres=10765
    var apikey = "62b1bf944f74eeec527159433d39b68a";
    var queryParameters = {
      'api_key': '${apikey}',
    };
    var url = Uri.https("api.themoviedb.org", "/3/trending/all/day", queryParameters);
    var res = await http.get(url);
    if (res.statusCode == 200){
      var jsonResponse = json.decode(res.body) as Map<String, dynamic>;
      var results = jsonResponse['results'];

      return results;
    }
  }

  Action() async {
    //https://api.themoviedb.org/3/discover/movie?api_key=62b1bf944f74eeec527159433d39b68a&language=en-US&sort_by=popularity.desc&page=1&with_genres=10765
    Random random = new Random();
    int randomNumber = random.nextInt(10);
    var apikey = "62b1bf944f74eeec527159433d39b68a";
    var queryParameters = {
      'api_key': '${apikey}',
      'language': 'en_US',
      'sort_by': 'popularity.desc',
      'page': randomNumber.toString(),
      'with_genres': '878'
    };

    var url = Uri.https("api.themoviedb.org", "/3/discover/movie", queryParameters);
    print(url);
    var res = await http.get(url);

    if (res.statusCode == 200){
      var jsonResponse = json.decode(res.body) as Map<String, dynamic>;
      var results = jsonResponse['results'];

      return results;
    }
  }



  @override
  void initState() {
    Trending();
    Action();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<dynamic>(
                future: Trending(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                  Random random = new Random();
                  int randomNumber = random.nextInt(snapshot.data.length);
                  return Column(
                    children: [
                      SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            GestureDetector(
                              child: Container(
                                height: 300,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage('https://image.tmdb.org/t/p/w500/${snapshot.data[randomNumber]["poster_path"].toString()}'),
                                        fit: BoxFit.cover
                                    )
                                ),
                              ),
                              onTap: ()=>{
                                b = snapshot.data[randomNumber]["vote_average"]/2.toInt(),
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => MovieDetail(Title: snapshot.data[randomNumber]["title"].toString(),Overview: snapshot.data[randomNumber]["overview"].toString(), ReleaseDate: snapshot.data[randomNumber]["release_date"].toString(), Vote: b.ceil(), Image: snapshot.data[randomNumber]["poster_path"].toString()),
                                    ))
                              },
                            ),
                            Container(
                              width: double.infinity,
                              padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
                              child: Text(
                                'Trending Today',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ),
                                textAlign: TextAlign.left,
                              ),
                            ),
                            SizedBox(
                              height: 200.0,
                              child: ListView.builder(
                                physics: BouncingScrollPhysics(),
                                shrinkWrap: true,
                                scrollDirection: Axis.horizontal,
                                itemCount: snapshot.data.length,
                                itemBuilder: (BuildContext context, int index) => Card(
                                  child: GestureDetector(
                                    onTap: ()=>{
                                      b = snapshot.data[index]["vote_average"]/2.toInt(),
                                      Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                      builder: (context) => MovieDetail(Title: snapshot.data[index]["title"].toString(),Overview: snapshot.data[index]["overview"].toString(), ReleaseDate: snapshot.data[index]["release_date"].toString(), Vote: b.ceil(), Image: snapshot.data[index]["poster_path"].toString()),
                                      ))
                                    },
                                    child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            width: 100,
                                            height: 150,
                                            decoration: BoxDecoration(
                                                image: DecorationImage(
                                                    image: NetworkImage('https://image.tmdb.org/t/p/w500/${snapshot.data[index]["poster_path"].toString()}'),
                                                    fit: BoxFit.cover
                                                )
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),
                                            width: 100,
                                              child: Text(
                                                  (snapshot.data[index]["title"].toString()),
                                                overflow: TextOverflow.ellipsis,
                                              ))
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                  }else{
                    return Container(
                        width:  MediaQuery.of(context).size.width,
                        height:  MediaQuery.of(context).size.height/2,
                        child: Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        )));
                  }
                },
              ),
              FutureBuilder<dynamic>(
                future: Action(),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    Random random = new Random();
                    int randomNumber = random.nextInt(snapshot.data.length);
                    return Column(
                      children: [
                        SingleChildScrollView(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.fromLTRB(10, 10, 0, 5),
                                child: Text(
                                  'Actions',
                                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold ),
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              SizedBox(
                                height: 200.0,

                                child: ListView.builder(
                                  physics: BouncingScrollPhysics(),
                                  shrinkWrap: true,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: snapshot.data.length,
                                  itemBuilder: (BuildContext context, int index) => Card(
                                    child: GestureDetector(
                                      onTap: ()=>{
                                        b = snapshot.data[index]["vote_average"]/2.toInt(),
                                        print(snapshot.data[index]["vote_average"].toInt()),
                                        print(snapshot.data[index]["vote_average"].toInt().runtimeType),
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => MovieDetail(Title: snapshot.data[index]["title"].toString(),Overview: snapshot.data[index]["overview"].toString(), ReleaseDate: snapshot.data[index]["release_date"].toString(), Vote: b.ceil(), Image: snapshot.data[index]["poster_path"].toString()),
                                            ))
                                      },
                                      child: Container(
                                        child: Column(
                                          children: [
                                            Container(
                                              width: 100,
                                              height: 150,
                                              decoration: BoxDecoration(
                                                  image: DecorationImage(
                                                      image: NetworkImage('https://image.tmdb.org/t/p/w500/${snapshot.data[index]["poster_path"].toString()}'),
                                                      fit: BoxFit.cover
                                                  )
                                              ),
                                            ),
                                            Container(
                                                width: 100,
                                                child: Text(
                                                  (snapshot.data[index]["title"].toString()),
                                                  overflow: TextOverflow.ellipsis,
                                                )
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }else{
                    return Container(
                        width:  MediaQuery.of(context).size.width,
                        height:  MediaQuery.of(context).size.height/2,
                        child: Center(child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                          ],
                        )));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
