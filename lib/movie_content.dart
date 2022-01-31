import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MovieContent extends StatelessWidget{
  final String title , item;
  const MovieContent({required this.title, required this.item, });
  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.all(9),
      child: Card(
        child: ListTile(
          title: Text(title),
          subtitle: Text(item),
        ),
      ),
    );
  }

}