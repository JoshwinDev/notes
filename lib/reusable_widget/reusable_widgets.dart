import 'package:flutter/material.dart';

Container signInButton(
BuildContext context, bool isLogin, Function onTap){
  return Container(
    width: MediaQuery.of(context).size.width,
    height: 50,
    margin: const EdgeInsets.fromLTRB(0, 10, 0, 20),
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(90)),
    child: ElevatedButton(
      onPressed: (){
        onTap();
      },
      child: Text(
        isLogin? 'LOG IN' : 'SIGN UP',
        style: const TextStyle(
          color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),
        ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.resolveWith((states) {
          if(states.contains(MaterialState.pressed)){
            return Colors.black;
  }
          return Color(0xFF0065FF);
  }),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(30))
      ),
      ),
    ),
  );
}