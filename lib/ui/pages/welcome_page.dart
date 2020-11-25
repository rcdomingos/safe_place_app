import 'package:flutter/material.dart';
import 'package:safe_place_app/ui/pages/login_page.dart';
import 'package:safe_place_app/ui/pages/register_page.dart';
import 'package:safe_place_app/ui/widgets/Button.dart';

import '../ui_constants.dart';

class WelcomePage extends StatelessWidget {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final snackBar = SnackBar(
    backgroundColor: Colors.green,
    content: Text('Cadastro efetuado com sucesso!'),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 50.0, horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(right: 0.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/logoSafePlace600X240.png'),
                    SizedBox(height: 30.0),
                    Text('Bem vindo ao aplicativo\nSafe Place',
                        style: TextStyle(fontSize: 24)),
                    SizedBox(height: 20),
                    Text(
                      'Verique quais lugares seguem as recomendações de segurança',
                      style: TextStyle(fontSize: 18, color: fontSecundaryColor),
                    ),
                  ],
                ),
              ),
              Spacer(),
              DefaultButton(
                label: 'Já tenho cadastro',
                type: 'primary',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                ),
              ),
              SizedBox(height: 15),
              DefaultButton(
                label: 'Quero me cadastrar',
                type: 'secundary',
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RegisterPage(),
                  ),
                ).then((result) {
                  if (result == true) {
                    _scaffoldKey.currentState.showSnackBar(snackBar);
                  }
                }),
              ),
              SizedBox(height: 30),
              Center(
                child: Text(
                  'Developed by Reginaldo e Thais',
                  style: TextStyle(fontSize: 11, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
