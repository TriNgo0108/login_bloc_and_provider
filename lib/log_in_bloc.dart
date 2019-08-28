import 'dart:async';

import 'package:flutter/material.dart';
import 'package:login_app_bloc/validation.dart';
import 'package:provider/provider.dart';
import 'package:rxdart/rxdart.dart';

class LoginBloc extends ChangeNotifier{
  final _emailSubject = BehaviorSubject<String>();
  final _passSubject = BehaviorSubject<String>();
  final _btnSubject = BehaviorSubject<bool>();
  Stream<String> get emailStream =>_emailSubject.stream.transform(emailValidation).skip(1);
  Sink<String> get emailSink=>_emailSubject.sink;

  Stream<String> get passStream =>_passSubject.stream.transform(passValidation).skip(1);
  Sink<String> get passSink=>_passSubject.sink;

  Stream<bool> get btnStream =>_btnSubject.stream;
  Sink<bool> get btnSink=>_btnSubject.sink;

  var emailValidation = StreamTransformer<String,String>.fromHandlers(
    handleData: (email,sink){
      sink.add(Validation.validateEmail(email));
    }
  );
  var passValidation = StreamTransformer<String,String>.fromHandlers(
      handleData: (pass,sink){
        sink.add(Validation.validatePass(pass));
      }
  );
  LoginBloc(){
    Observable.combineLatest2(_emailSubject, _passSubject, (email,pass){
      return Validation.validateEmail(email)== null && Validation.validatePass(pass)== null;
    }).listen((enable){
      btnSink.add(enable);
    });
  }
  static LoginBloc of(BuildContext context){
    return Provider.of<LoginBloc>(context);
  }
  void dispose(){
    _emailSubject.close();
    _passSubject.close();
    _btnSubject.close();
    super.dispose();
  }
}