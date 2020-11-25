import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_place_app/core/models/user.dart';
import 'package:safe_place_app/core/services/api.dart';
import 'package:safe_place_app/ui/widgets/Button.dart';
import 'package:safe_place_app/ui/widgets/bottom_navigator.dart';
import 'package:safe_place_app/ui/widgets/loading.dart';

import '../ui_constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _ctrEmail = TextEditingController();
  TextEditingController _ctrPassword = TextEditingController();

  final UnfocusDisposition disposition = UnfocusDisposition.scope;

  bool _isBusy = false;

  Api _api = new Api();

  Future<bool> _userAutentication() async {
    setBusy(true);

    bool isAuthentic = false;
    User user = await _api.getUserApi(_ctrEmail.text, _ctrPassword.text);

    if (user != null) {
      await _saveUserLocalStorage(user);
      isAuthentic = true;
    }

    setBusy(false);
    return isAuthentic;
  }

  Future _saveUserLocalStorage(User user) async {
    final box = GetStorage();
    await box.write('id', user.id);
    await box.write('name', user.name);
    await box.write('email', user.email);
  }

  void setBusy(bool value) {
    setState(() {
      _isBusy = value;
    });
  }

  final snackBar = SnackBar(
    backgroundColor: Colors.red,
    content: Text('Não foi possivel efetuar o login!'),
    action: SnackBarAction(
      label: 'X',
      onPressed: () {
        // Some code to undo the change.
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomInset: false,
      backgroundColor: backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: primaryColor),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Visibility(
        visible: !_isBusy,
        replacement: Loading(texto: 'Pesquisando usuário...'),
        child: SafeArea(
          child: Container(
            padding: EdgeInsets.fromLTRB(18, 10, 18, 30),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Login', style: titleStyle),
                SizedBox(height: 10),
                Text('Entre com seu e-email e senha no SafePlace',
                    style: subtitleStyle),
                Expanded(
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _ctrEmail,
                            decoration: InputDecoration(labelText: 'E-mail'),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _ctrPassword,
                            keyboardType: TextInputType.visiblePassword,
                            obscureText: true,
                            decoration: InputDecoration(labelText: 'Senha'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                DefaultButton(
                  label: 'Entrar',
                  type: 'primary',
                  onPressed: () {
                    primaryFocus.unfocus(disposition: disposition);
                    _userAutentication().then(
                      (isAuthentic) => {
                        if (isAuthentic)
                          {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavigator(),
                              ),
                            ),
                          }
                        else
                          {
                            _scaffoldKey.currentState.showSnackBar(snackBar),
                          }
                      },
                    );
                  },
                ),
                SizedBox(height: 10),
                DefaultButton(
                  label: 'Esqueci minha senha',
                  type: 'secundary',
                  onPressed: () {
                    print(_ctrEmail.text);
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
