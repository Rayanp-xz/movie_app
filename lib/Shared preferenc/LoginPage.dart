
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../movie-app-main/MovieApp/MvieApp2/Styles.dart';
import 'ProfilePage.dart';





class Logil extends StatefulWidget {
  const Logil({Key? key}) : super(key: key);

  @override
  _LogilState createState() => _LogilState();
}

class _LogilState extends State<Logil> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController EmailController = TextEditingController();
  TextEditingController PhoneController = TextEditingController();
  

  late SharedPreferences loginData;
  late bool newUser;

  @override
  void initState() {
    checkLogin();
    // TODO: implement initState
    super.initState();
  }

  void checkLogin() async
  {
    loginData = await SharedPreferences.getInstance();
    newUser = (loginData.getBool("login")??true);
    print(newUser);
    if(newUser==false)
    {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>MyDashBoard()));

    }
  }
  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    // TODO: implement dispose
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login in to your account',style: TextStyle(color: Style.textColor),),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 340),
            child: Text("Enter your name",style: TextStyle(color:Style.textColor),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(color:Colors.amber),
               cursorColor: Colors.white,
               
              controller: nameController,
              decoration: InputDecoration(
                  hintText: "Username",fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28)
      
                  )
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(right:300),
            child: Text("Enter a valid password",style: TextStyle(color:Style.textColor),),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              style: TextStyle(color:Colors.amber),
              obscureText: true,
              cursorColor: Colors.white,
              controller: passwordController,
              decoration: InputDecoration(
                
                  hintText: "password",fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(28)
      
                  )
              ),
            ),
          ),


           SizedBox(
            height: 20,
          ),

      


      
      
          Container(
            width: 250,
            decoration: BoxDecoration(
              color: Colors.amber,
              borderRadius: BorderRadius.circular(30)
            ),
            
            child: TextButton( 
                onPressed: (){
            
                  String username = nameController.text;
                  String password = passwordController.text;

                  if(username!= " " && password!= ""  )
                  {
                    print("successful");
                    loginData.setBool("login",false);
                    loginData.setString("username", nameController.text);
                    loginData.setString("password", passwordController.text);

                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>ColorContainer()));
                  }
                },
                child: Text("Login")),
          ),
      
        ],
      ),
    );
  }
}