import 'dart:convert';

import 'package:Corona_Go/Datasource.dart';
import 'package:Corona_Go/pages/countryPage.dart';
import 'package:Corona_Go/pannels/infopannel.dart';
import 'package:Corona_Go/pannels/mosteffectedcountries.dart';
import 'package:Corona_Go/pannels/worldwidepannel.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  Map worldData;
fetchWorldwideData()async{
  http.Response response = await http.get('https://corona.lmao.ninja/v3/covid-19/all');
  setState((){
    worldData = json.decode(response.body);
  });
}

 List countryData;
fetchCountryData()async{
  http.Response response = await http.get('https://corona.lmao.ninja/v3/covid-19/countries?sort=deaths');
  setState((){
    countryData = json.decode(response.body);
  });
}

@override
  void initState() {
    fetchWorldwideData();
    fetchCountryData();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
        actions: <Widget>[
          IconButton(icon: Icon(Theme.of(context).brightness==Brightness.light?Icons.lightbulb_outline:Icons.highlight), onPressed: (){
            DynamicTheme.of(context).setBrightness(Theme.of(context).brightness==Brightness.light?Brightness.dark:Brightness.light);
          })
        ],
        centerTitle: false,
        title: Text("Corona Go "),
      ),
      body: SingleChildScrollView(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            height: 100,
            alignment: Alignment.center,
            padding: EdgeInsets.all(10),
            color: Colors.orange[100],
            child: Text(DataSource.quote,style: TextStyle(color: Colors.orange[800],fontWeight: FontWeight.bold,fontSize: 16),),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0,horizontal: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text('Worldwide',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>CountryPage()));
                  },
                                  child: Container(
                    decoration: BoxDecoration(
                       color: primaryBlack,
                       borderRadius: BorderRadius.circular(20)
                    ),
                    padding: EdgeInsets.all(10),
                    child: Text('Regional',style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 16),)),
                ),
              ],
            ),
          ),
         worldData == null ? CircularProgressIndicator() : Worldwidepannel(worldData: worldData,),
         Padding(
           padding: const EdgeInsets.symmetric(vertical:10.0,horizontal: 10),
           child: Text('Most Affected Countries',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22),),
         ),
         SizedBox(height: 10,),
        countryData==null?CircularProgressIndicator(): MostAffectedPannel(countryData: countryData,),
        SizedBox(height: 10,),

        InfoPanel(),

        SizedBox(height: 30),

        Center(child: Text('WE ARE TOGATHER IN THIS FIGHT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16),)),

        SizedBox(height: 40,),
        ],
      )),
    );
  }
}