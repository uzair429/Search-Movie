import 'package:flutter/cupertino.dart';
import 'package:movie_searcher/movie_content.dart';

class movieDisplay extends StatelessWidget{

  final Map<String, dynamic> movieMap;
  const movieDisplay({required this.movieMap});

  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(movieMap['Poster']),
          MovieContent(title: "title", item: movieMap['Title']),
          MovieContent(title: 'Director', item: movieMap['Director']),
          MovieContent(title: 'Language', item: movieMap['Language']),
          MovieContent(title: 'Country', item: movieMap['Country']),
          MovieContent(title: 'Actors ', item: movieMap['Actors']),
          MovieContent(title: 'Plot', item: movieMap['Plot'])
          // Text("Movie Name ${movieMap['Title']}" , style: const TextStyle(fontSize: 20),),
          // Text("Director${movieMap['Director']}" ,style: TextStyle(fontSize: 20),),
          // Text("Language ${movieMap['Language']}" , style: TextStyle(fontSize: 20),),
          // Text("Country ${movieMap['Country']}" , style:  TextStyle(fontSize: 20),),
          // Text("Actors ${movieMap['Actors']}", style: TextStyle(fontSize: 20),),
          // Text("Plot ${movieMap['Plot']}", style: TextStyle(fontSize: 20),),

        ],
      )
    );
  }


}