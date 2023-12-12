import 'package:firebase_project/MovieApp/MvieApp2/Styles.dart';
import 'package:firebase_project/Shared%20preferenc/LoginPage.dart';
import 'package:firebase_project/Shared%20preferenc/sec_login_page.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


//import 'LoginPage.dart';

class MyDashBoard extends StatefulWidget {
  const MyDashBoard({Key? key}) : super(key: key);

  @override
  _MyDashBoardState createState() => _MyDashBoardState();
}

class _MyDashBoardState extends State<MyDashBoard> {
  late SharedPreferences logindata;
  late String username;
  late String password;
  late String email;
  late String number;

  @override
  void initState() {
    GetSecond();
    Getinitial();
    GetEmail();
    GetNumber();
    // TODO: implement initState
    super.initState();
  }

  void Getinitial() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      username = logindata.getString("username")!;
      // password = logindata.getString("password")!;
    });
  }

   void GetSecond() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      
      password = logindata.getString("password")!;
    });
  }

  void GetEmail() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      email = logindata.getString("email")!;
      // password = logindata.getString("password")!;
    });
  }

  void GetNumber() async {
    logindata = await SharedPreferences.getInstance();
    setState(() {
      number = logindata.getString("number")!;
      // password = logindata.getString("password")!;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Style.textColor,
            leading: IconButton(
              onPressed: (){
                Navigator.of(context).pop();
              },
                icon: Icon(Icons.arrow_back_ios)),
         ),
      body: ListView(
       
        children: [
          Container(
            height: 200,
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Container(
                  height: 140,
                  width: MediaQuery.of(context).size.width,
                  color: Style.textColor,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20,top: 60),
                  child: CircleAvatar(
                    radius: 400,
                    child:Icon(Icons.person,size: 125,color: Style.textColor,),
                    backgroundColor: Style.SecColor,
                  ),
                )
              ],
            ),
          ),

          
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Text("Profile",style: TextStyle(color:Style.textColor,fontSize: 20),),
          ),
          SizedBox(
            height: 15,
          ),
          Card(
             color:Style.textColor,
            child: ListTile(
              trailing: Icon(Icons.edit),
              title: Text("User name"),
              subtitle: Text(username,style: TextStyle(
                fontSize: 15,color: Colors.black
              ),),
            ),
          ),
          
         
          
          Card(
             color:Style.textColor,
            child: ListTile(
              trailing: Icon(Icons.edit),
              title: Text("Email adress" ),
              subtitle: Text("$email",style: TextStyle(
                fontSize: 15,
                color: Colors.black
              ),),
            ),
          ),
          //  Card(
          //   color: Style.textColor,
          //   child: ListTile(
          //     trailing: Icon(Icons.edit),
          //     title: Text("Password"),
          //     subtitle: Text("${password}",style: TextStyle(
          //       fontSize: 15,
          //         color: Colors.black
          //     ),),
          //   ),
          // ),
         
          Card(
            color: Style.textColor,
            child: ListTile(
              trailing: Icon(Icons.edit),
              title: Text("Phone number"),
              subtitle: Text("$number",style: TextStyle(
                fontSize: 15,color: Colors.black
              ),),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          Positioned(
            left: 200,
            child: TextButton(
                onPressed: () {
                  logindata.setBool("login", true);
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => LginPageDemo()));
                },
                child: Align(child: Text("Log out",style: TextStyle(color: Colors.red,fontSize: 15),))),
          ),
          SizedBox(
            height: 30,
          )
        ],
      ),
    );
  }
}