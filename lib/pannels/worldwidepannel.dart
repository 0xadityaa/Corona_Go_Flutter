import 'package:flutter/material.dart';

class Worldwidepannel extends StatelessWidget {

  final Map worldData;

  const Worldwidepannel({Key key, this.worldData}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: GridView(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,childAspectRatio: 2),
        children: <Widget>[
          StatusPannel(
            title: 'Confirmed',
            pannelColor: Colors.red[100],
            textColor: Colors.red,
            count: worldData['cases'].toString(),
          ),
          StatusPannel(
            title: 'Active',
            pannelColor: Colors.blue[100],
            textColor: Colors.blue[800],
            count: worldData['active'].toString(),
          ),
          StatusPannel(
            title: 'Recovered',
            pannelColor: Colors.green[100],
            textColor: Colors.green,
            count: worldData['recovered'].toString(),
          ),
          StatusPannel(
            title: 'Deaths',
            pannelColor: Colors.grey[400],
            textColor: Colors.grey[900],
            count: worldData['deaths'].toString(),
          ),
        ],
        )
    );
  }
}

class StatusPannel extends StatelessWidget {

  final Color pannelColor;
  final Color textColor;
  final String title;
  final String count;

  const StatusPannel({Key key, this.pannelColor, this.textColor, this.title, this.count}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Container(
      margin: EdgeInsets.all(10),
      height: 80,width: width/2,
      color: pannelColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(title,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: textColor)),
          Text(count,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20,color: textColor)),
        ],
      ),
    );
  }
}