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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
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
       appBar: AppBar(title: Text('Profession' , ) , backgroundColor: Colors.greenAccent.shade200,actions: [

         Icon(CupertinoIcons.chat_bubble),
         Padding(padding: const EdgeInsets.fromLTRB(1, 1, 1, 1)),
         SizedBox(width: 10,),
         Icon(CupertinoIcons.ellipsis_vertical),

       ],),
       body: Column(
         children: [
            Padding(

              padding: const EdgeInsets.all(32),
              child: Row(
                children: [
               ClipRRect(
                 borderRadius: BorderRadius.circular(8),
                 child: Image.asset(
                   '/Users/amirhosein/StudioProjects/p_pay/assets/images/images.jpg',



                 ),),
                  SizedBox(width: 20,),
                  Column(children: [
                      Text('Doctor Alex'),
                      SizedBox(height: 8,),
                      Text('Dentist'),
                    SizedBox(height: 8,),
                    Row(
                      children: [
                        Icon(CupertinoIcons.location_solid),
                        Text('tehran, Iran')
                      ],
                    ),
                    SizedBox(height: 50,)
                    
                  ],
                  )
              ],
              ),


            ),
           Text('10 years experienced dentist'),

         ],
       ),

     );
  }
}


