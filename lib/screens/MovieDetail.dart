import 'dart:ffi';


import 'package:dicoding_submission_danny/model/StarDisplay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieDetail extends StatelessWidget {
  final String Title;
  final String Image;
  final String ReleaseDate;
  final String Overview;
  final int Vote;
  int Rating;

  MovieDetail({Key key, @required this.Title, this.Overview, this.ReleaseDate, this.Vote, this.Image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print('rating: ${Vote}');
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black
        ),
        title: Text(Title,overflow: TextOverflow.ellipsis, style: TextStyle(
            color: Colors.black54
        )),
        backgroundColor: Colors.white,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Poster Image
            Container(
              width: double.infinity,
              height: 250,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image:  NetworkImage('https://image.tmdb.org/t/p/w500/${Image}'),
                      fit: BoxFit.cover
                  )
              ),
            ),

            // Title and Rating
            Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.fromLTRB(10, 10, 10, 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      child: Text(
                        Title,
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: IconTheme(
                      data: IconThemeData(
                        color: Colors.amber,
                        size: 20,
                      ),
                      child: StarDisplay(value: Vote),
                    ),
                  ),
                ],
              ),
            ),

            // Release Date
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Release Date:',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700 ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    ReleaseDate,
                    style: TextStyle(fontSize: 14,  ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),

            // Overview
            Container(
              width: double.infinity,
              padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Overview :',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700 ),
                    textAlign: TextAlign.left,
                  ),
                  Text(
                    Overview,
                    style: TextStyle(fontSize: 14,  ),
                    textAlign: TextAlign.left,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
