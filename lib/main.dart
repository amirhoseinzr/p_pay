import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Color surfaceColor = Color(0x0dfffffff);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: Colors.blue,
        brightness: Brightness.light,
        dividerColor: surfaceColor,
        scaffoldBackgroundColor: Colors.grey.shade200,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget{
  Widget build(BuildContext context){
     return Scaffold(
       appBar: AppBar(title: Text('HealthCare Center' , ) , backgroundColor: Colors.greenAccent.shade100,actions: [

         Icon(CupertinoIcons.chat_bubble),
         Padding(padding: const EdgeInsets.fromLTRB(1, 1, 1, 1)),
         SizedBox(width: 10,),
         Icon(CupertinoIcons.ellipsis_vertical),

       ],),
       body: Column(
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
            Padding(

              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
               ClipRRect(
                 borderRadius: BorderRadius.circular(8),
                 child: Image.asset(
                   'assets/images/images.jpg',
                   width: 100,
                   height: 100,
                   fit: BoxFit.cover

                 ),),
                  SizedBox(width: 20,),
                  Column(children: [
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.person_solid,  // Use a human icon, in this case, from Cupertino icons
                          size: 20,  // Adjust the size if needed
                          color: Colors.grey,  // Set the color if needed
                        ),
                        SizedBox(width: 5),  // Space between the icon and the text
                        Text(
                          'Dr naaeini Dental Clinic',  // The text beside the human icon
                          style: TextStyle(
                            fontSize: 16,  // Set the text size
                            color: Colors.black,  // Set the text color
                          ),
                        ),
                      ],
                    ),

                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Icon(
                          CupertinoIcons.location_solid,  // The icon
                          size: 20,  // Set the size of the icon if needed
                          color: Colors.grey,  // You can change the color if needed
                        ),
                        SizedBox(width: 5),  // Add some space between the icon and text
                        Text(
                          'Tehran, Iran',  // The text beside the icon
                          style: TextStyle(
                            fontSize: 16,  // Set font size
                            color: Colors.black,  // Set text color
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 50,)
                    
                  ],
                  )
              ],
              ),


            ),
           Divider(),
           Text(textAlign: TextAlign.right,'clinic Services & Prices'),

         ],
       ),

     );
  }
}


