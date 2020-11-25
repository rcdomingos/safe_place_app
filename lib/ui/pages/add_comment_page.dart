import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_place_app/core/services/api.dart';
import 'package:safe_place_app/ui/widgets/Button.dart';

import '../ui_constants.dart';

class AddCommentPage extends StatefulWidget {
  final int placeId;
  const AddCommentPage({Key key, this.placeId}) : super(key: key);

  @override
  _AddCommentPageState createState() => _AddCommentPageState();
}

class _AddCommentPageState extends State<AddCommentPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  var _ctrTitle = TextEditingController();
  var _ctrComment = TextEditingController();
  var _formKey = GlobalKey<FormState>();
  bool _isBusy = false;
  final box = GetStorage();

  Api _api = new Api();

  Future _saveComment() async {
    setBusy(true);
    bool resultAddComment;
    var userId = box.read('id');

    resultAddComment = await _api.addPlaceComment(
      placeId: this.widget.placeId,
      userId: userId,
      title: _ctrTitle.text,
      comment: _ctrComment.text,
    );
    setBusy(false);

    return resultAddComment;
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
      appBar: AppBar(
        title: Text(
          'Adicionar Comentário',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
      body: Visibility(
        visible: !_isBusy,
        replacement: Center(
          child: CircularProgressIndicator(),
        ),
        child: SingleChildScrollView(
          child: Center(
            child: Padding(
              padding: EdgeInsets.all(25),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Text(
                        'Deixe um comentário sobre o lugar para ajudar os outros usuários',
                        style: subtitleStyle),
                    SizedBox(height: 24),
                    TextFormField(
                      controller: _ctrTitle,
                      enabled: true,
                      decoration: InputDecoration(labelText: 'Titulo'),
                    ),
                    TextFormField(
                      controller: _ctrComment,
                      enabled: true,
                      decoration: InputDecoration(labelText: 'Comentário'),
                    ),
                    SizedBox(height: 20),
                    DefaultButton(
                      label: 'Enviar comentário',
                      type: 'primary',
                      onPressed: () {
                        _saveComment().then(
                          (result) {
                            if (result) {
                              Navigator.of(context).pop(true);
                            } else {
                              _scaffoldKey.currentState.showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Erro ao salvar o comentário'),
                                  action: SnackBarAction(
                                    label: 'X',
                                    onPressed: () {
                                      // Some code to undo the change.
                                    },
                                  ),
                                ),
                              );
                            }
                          },
                        );
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
