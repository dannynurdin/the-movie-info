import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:dicoding_submission_danny/screens/MovieDetail.dart';

class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  String Query = null;
  TextEditingController _controller;
  double b;
  var data;


  _searchButton(){
    print(Query);
    _controller.clear();
  }
  _onSearch(String query){
    setState(() {
      Query = query;
      _controller.clear();
    });
  }

  searchMovie(String query) async {
    // https://api.themoviedb.org/3/trending/all/day?api_key=<<api_key>>
    // https://api.themoviedb.org/3/discover/movie?api_key=62b1bf944f74eeec527159433d39b68a&language=en-US&sort_by=popularity.desc&page=1&with_genres=10765
    // https://api.themoviedb.org/3/search/movie?api_key=62b1bf944f74eeec527159433d39b68a&language=en-US&page=1&include_adult=false&query=war
    var apikey = "62b1bf944f74eeec527159433d39b68a";
    var queryParameters = {
      'api_key': '${apikey}',
      'language': 'en_US',
      'page': "1",
      'query': query ?? 'love'
    };
    var url = Uri.https("api.themoviedb.org", "/3/search/movie", queryParameters);
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
    super.initState();
    searchMovie("love");
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void setState(fn) {
    // TODO: implement setState
    super.setState(fn);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title:
            TextField(
              decoration: InputDecoration(

                hintText: "Search Data...",
                hintStyle: TextStyle(color: Colors.black),
                prefixIcon: IconButton(
                  icon: Icon(Icons.search),
                  onPressed: _searchButton,

                )
              ),
              controller: _controller,
              style: TextStyle(color: Colors.black, fontSize: 16.0),
              onChanged: (query) => {
                Query = query,
              },
              onSubmitted: (query) => _onSearch(query),
              textInputAction: TextInputAction.search,
              keyboardType: TextInputType.text,
            ),
        backgroundColor: Colors.white,
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              FutureBuilder<dynamic>(
                future: searchMovie(Query),
                builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                  if (snapshot.hasData) {
                    return Column(
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height,
                          child: ListView.builder(
                            physics: AlwaysScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
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
                                  child: Row(
                                    children: [
                                      Container(

                                        width: 50,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage('https://image.tmdb.org/t/p/w500/${snapshot.data[index]["poster_path"].toString()}'),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                            padding: EdgeInsets.symmetric(vertical: 2, horizontal: 3),

                                            child: Text(
                                              (snapshot.data[index]["title"].toString()),
                                              overflow: TextOverflow.ellipsis,
                                            )),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  }else{
                    return Container(
                        width:  MediaQuery.of(context).size.width,
                        height:  MediaQuery.of(context).size.height,
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
