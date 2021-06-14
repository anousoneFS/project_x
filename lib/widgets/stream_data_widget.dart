import 'package:flutter/material.dart';

class StreamCardWidget extends StatelessWidget {
  final Map<String, dynamic> json;
  StreamCardWidget({this.json});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: ListView.builder(
          itemCount: json.values.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              child: ListTile(
                title: Text('${json.keys.toList()[index]}'),
                leading: Text('${json.values.toList()[index]}'),
              ),
            );
          }),
    );
  }
}
