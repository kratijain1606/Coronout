import 'package:flutter/material.dart';



class Require extends StatefulWidget {
  @override
  _RequireState createState() => _RequireState();
}

class _RequireState extends State<Require>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Requirements",style: Theme.of(context).textTheme.title,),
      backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(color: Colors.black),
        centerTitle: true,),
      body:Column(children: <Widget>[
         getRequirementItems(context: context, text: 'Mask',color:Colors.white, imgSrc: 'mask', bgColor: Colors.red[100], imgColor: Colors.red[700]),
        getRequirementItems(context: context, text: 'Gloves',color:Colors.white, imgSrc: 'gloves', bgColor: Colors.amber[100], imgColor: Colors.amber[700]),
        getRequirementItems(context: context, text: 'Sanitizer',color:Colors.white, imgSrc: 'alchohol', bgColor: Colors.blue[100], imgColor: Colors.blue[700]),
        getRequirementItems(context: context, text: 'Soap',color:Colors.white, imgSrc: 'soap', bgColor: Colors.grey[300], imgColor: Colors.grey[700]),
      
      ],) 
      );
  }
  
}


Widget getRequirementItems({BuildContext context, String text,Color color, String imgSrc, Color bgColor, Color imgColor}) {
  return Material(
    child:Row(
    children: <Widget>[
      Container(
        child:(
          Container(
            margin: const EdgeInsets.all(12.0),
        
        padding: EdgeInsets.all(5.0),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // borderRadius: BorderRadius.all(Radius.circular(5.0),
          color: bgColor,
            
        ),
        child: Container(
           padding:EdgeInsets.all(40),
        child:Image(image: AssetImage('assets/images/$imgSrc.png'), height: 25, color: imgColor,),
      ))
      )
      ),
      SizedBox(
        height: 10.0,
        
      ), Container(
      padding:EdgeInsets.all(40),
      child: 
      Text(text, style: TextStyle(fontSize:30,color: Colors.black.withOpacity(1)),
      ))
    ],
    )  );
}
