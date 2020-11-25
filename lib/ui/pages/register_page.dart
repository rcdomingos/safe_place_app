import 'package:flutter/material.dart';
import 'package:safe_place_app/core/models/user.dart';
import 'package:safe_place_app/core/services/api.dart';
import 'package:safe_place_app/ui/widgets/Button.dart';
import 'package:safe_place_app/ui/widgets/loading.dart';

import '../ui_constants.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _ctrName = TextEditingController();
  TextEditingController _ctrEmail = TextEditingController();
  TextEditingController _ctrPassword = TextEditingController();

  final UnfocusDisposition disposition = UnfocusDisposition.scope;

  String _resultRegisterError;
  bool _isBusy = false;

  Api _api = new Api();

  Future<bool> _userRegister() async {
    setBusy(true);

    bool isRegistered = true;
    User _user = new User(
        name: _ctrName.text,
        email: _ctrEmail.text,
        password: _ctrPassword.text);

    String resultRegister = await _api.sendUserRegister(_user);

    if (resultRegister != 'ok') {
      isRegistered = false;
      _resultRegisterError = resultRegister;
    }

    setBusy(false);
    return isRegistered;
  }

  void setBusy(bool value) {
    setState(() {
      _isBusy = value;
    });
  }

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
      body: SafeArea(
        child: Visibility(
          visible: !_isBusy,
          replacement: Loading(texto: 'Registrando...'),
          child: Container(
            padding: EdgeInsets.fromLTRB(18, 10, 18, 30),
            height: double.infinity,
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Cadastro', style: titleStyle),
                SizedBox(height: 10),
                Text('Informe seus dados para se cadastrar gratuitamente',
                    style: subtitleStyle),
                Expanded(
                  child: Container(
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextFormField(
                            controller: _ctrName,
                            decoration: InputDecoration(labelText: 'Nome'),
                            keyboardType: TextInputType.name,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _ctrEmail,
                            decoration: InputDecoration(labelText: 'E-mail'),
                            keyboardType: TextInputType.emailAddress,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            controller: _ctrPassword,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(labelText: 'Senha'),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 50),
                DefaultButton(
                  label: 'Cadastrar',
                  type: 'primary',
                  onPressed: () {
                    primaryFocus.unfocus(disposition: disposition);
                    _userRegister().then(
                      (isRegister) => {
                        if (isRegister)
                          {
                            Navigator.pop(context, true),
                          }
                        else
                          {
                            _scaffoldKey.currentState.showSnackBar(
                              SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(_resultRegisterError),
                                action: SnackBarAction(
                                  label: 'X',
                                  onPressed: () {
                                    // Some code to undo the change.
                                  },
                                ),
                              ),
                            ),
                          }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
