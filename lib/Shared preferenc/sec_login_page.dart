import 'package:firebase_project/MovieApp/MvieApp2/MovieMain.dart';
import 'package:firebase_project/MovieApp/MvieApp2/Styles.dart';
import 'package:firebase_project/Shared%20preferenc/ProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';



class LginPageDemo extends StatefulWidget {
  const LginPageDemo({Key? key}) : super(key: key);

  @override
  _LginPageDemoState createState() => _LginPageDemoState();
}

class _LginPageDemoState extends State<LginPageDemo> {
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
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> MovieMain()));

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

      body: Padding(
        padding: const EdgeInsets.only(left: 30,right: 30),
        child: ListView(

          children: [
            SizedBox(
              height: 0,
            ),
            Container(
              height: 220,
              width: 220,
              child: Image.asset('assets/images/movie_logo.png'),
            ),
            SizedBox(
              height: 0,
            ),
            Padding(
              padding: const EdgeInsets.only(left:120 ),
              child: Text("Login into your account",style: TextStyle(color: Style.textColor,fontSize: 20),),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 290),
              child: Text("Enter your name",style: TextStyle(color:Style.textColor),),
            ),
            TextField(

              style: TextStyle(color:Colors.black),
              cursorColor: Colors.white,

              controller: nameController,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.person),
                  hoverColor: Colors.amber,
                  filled: true,
                  fillColor: Colors.grey,
                  hintText: "username",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28)

                  )
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right:290),
              child: Text("Enter a valid password",style: TextStyle(color:Style.textColor),),
            ),
            TextField(
              style: TextStyle(color:Colors.black),
              obscureText: true,
              cursorColor: Colors.white,
              controller: passwordController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.lock),
                  filled: true,
                  fillColor: Colors.grey,
                  hoverColor: Colors.amber,
                  hintText: "password",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28)

                  )
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 270),
              child: Text("Enter your Email address",style: TextStyle(color:Style.textColor),),
            ),
            TextField(

              style: TextStyle(color:Colors.black),


              cursorColor: Colors.white,
              controller: EmailController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.email),
                filled: true,
                  fillColor: Colors.grey,
                  hintText: "Email address",focusColor: Colors.amber,hoverColor: Colors.amber,iconColor: Colors.amber,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28)

                  )
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 270),
              child: Text("Enter your phone number",style: TextStyle(color:Style.textColor),),
            ),

            TextField(
              style: TextStyle(color:Colors.black),


              controller: PhoneController,
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.phone),
                  enabled: true,
                  filled: true,
                  fillColor: Colors.grey,
                  hoverColor: Colors.amber,

                  hintText: "Phone number",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(28)
                  )
              ),
            ),
            SizedBox(
              height: 50,
            ),


            Padding(
              padding: const EdgeInsets.only(left: 80,right: 80),
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                    color: Colors.amber,
                    borderRadius: BorderRadius.circular(30)
                ),

                child: TextButton(
                    onPressed: (){

                      String username = nameController.text;
                      String password = passwordController.text;
                      String email = EmailController.text;
                      String number=PhoneController.text;
                      if(username!= " " && password!= "" && email !="" && number !="")
                      {
                        print("successful");
                        loginData.setBool("login",false);
                        loginData.setString("username", nameController.text);
                        loginData.setString("password", passwordController.text);
                        loginData.setString("email",EmailController.text);
                        loginData.setString("number", PhoneController.text);
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>const MovieMain()));
                      }
                    },
                    child: Text("Login")),
              ),
            ),
            SizedBox(
              height: 100,
            )

          ],
        ),
      ),
    );
  }
}