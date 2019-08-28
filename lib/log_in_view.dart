import 'package:flutter/material.dart';
import 'package:login_app_bloc/log_in_bloc.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Login',
          style: TextStyle(fontSize: 18),
        ),
      ),
      body: ChangeNotifierProvider(
        builder: (_)=>LoginBloc(),
          child: LoginPage()),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    emailController.addListener(() {
      LoginBloc.of(context).emailSink.add(emailController.text);
    });
    passController.addListener(() {
      LoginBloc.of(context).passSink.add(passController.text);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final heightScreen = MediaQuery.of(context).size.height;
    final widthScreen = MediaQuery.of(context).size.width;
    var loginBloc = LoginBloc.of(context);
    return Container(
      padding:
          EdgeInsets.only(left: widthScreen * 0.04, right: widthScreen * 0.04),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          StreamBuilder<String>(
              stream: loginBloc.emailStream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                      icon: Icon(Icons.email),
                      hintText: "example@gmail.com",
                      labelText: 'email',
                      errorText: snapshot.data,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffCED0D2)),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      )),
                );
              }),
          SizedBox(
            height: heightScreen * 0.02,
          ),
          StreamBuilder<String>(
              stream: loginBloc.passStream,
              builder: (context, snapshot) {
                return TextFormField(
                  controller: passController,
                  obscureText: true,
                  decoration: InputDecoration(
                      icon: Icon(Icons.lock),
                      hintText: "your password",
                      labelText: 'password',
                      errorText: snapshot.data,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Color(0xffCED0D2)),
                        borderRadius: BorderRadius.all(Radius.circular(6)),
                      )),
                );
              }),
          SizedBox(
            height: heightScreen * 0.02,
          ),
          SizedBox(
            height: heightScreen * 0.05,
            width: widthScreen * 0.5,
            child: StreamBuilder<bool>(
                stream: loginBloc.btnStream,
                builder: (context, snapshot) {
                  return RaisedButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    child: Text(
                      'Log in',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    onPressed: snapshot.data == true ? () {} : null,
                    color: Colors.lightBlue,
                  );
                }),
          )
        ],
      ),
    );
  }
}
