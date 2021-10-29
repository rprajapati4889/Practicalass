import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:practical/Services/auth.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({Key? key, required this.auth}) : super(key: key);
  final AuthBase auth;

  Future<void> _signInWithGoogle() async {
    try {
      await auth.signInWithGoogle();
    }catch(e){
      print(e.toString());
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('News Info'),
          elevation: 2.0,
        ),
        body: buildContent(),
      backgroundColor: Colors.grey[200],
    );
  }

  Widget buildContent() {
    return Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text('Sign In',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 40),
            Container(
              height: 50,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(6.0))
                ),
                color: Colors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.asset('images/Google-logo.png',
                    height: 45),
                    const Text('Sign In With Google',
                      style: TextStyle(fontSize: 18,color: Colors.black87),
                    ),
                    Opacity(
                      opacity: 0.0,
                      child: Image.asset('images/Google-logo.png',height: 25,),

                    ),],
                ),
                onPressed: _signInWithGoogle,

              ),
            )

          ],
        ),
      );
  }
}
