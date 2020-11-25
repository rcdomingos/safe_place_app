import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import 'package:safe_place_app/core/models/comment.dart';
import 'package:safe_place_app/core/services/api.dart';
import 'package:safe_place_app/ui/pages/add_comment_page.dart';
import 'package:safe_place_app/ui/widgets/card_comment.dart';
import 'package:safe_place_app/ui/widgets/loading.dart';

import '../ui_constants.dart';

class CommentsPage extends StatefulWidget {
  final int placeId;

  const CommentsPage({Key key, this.placeId}) : super(key: key);

  @override
  _CommentsPageState createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isBusy = false;
  List<Comment> _comments = new List<Comment>();
  Api _api = new Api();
  final box = GetStorage();

  Future _getCommentsPlace() async {
    setBusy(true);
    _comments = await _api.getCommentPlace(this.widget.placeId);
    setBusy(false);
  }

  Future<bool> _deleteComment(int commentId) async {
    return await _api.deleteCommentPlace(commentId);
  }

  void setBusy(bool value) {
    setState(() {
      _isBusy = value;
    });
  }

  @override
  void initState() {
    _getCommentsPlace();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var userId = box.read('id');

    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text(
          'Comentários',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: primaryColor,
      ),
      body: Visibility(
        visible: !_isBusy,
        replacement: Loading(texto: 'Carregando comentários...'),
        child: ExpandableTheme(
          data: const ExpandableThemeData(
            iconColor: fontPrimaryColor,
            useInkWell: true,
          ),
          child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            itemCount: _comments.length,
            itemBuilder: (context, index) {
              Comment comment = _comments.elementAt(index);

              print(comment.userId);
              print(userId);

              if (comment.userId == userId) {
                return Dismissible(
                    background: Container(
                      alignment: AlignmentDirectional.centerStart,
                      color: Colors.red,
                      child: Row(
                        children: <Widget>[
                          SizedBox(width: 10),
                          Icon(Icons.delete, color: Colors.white),
                          Text(
                            'Excluir',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    key: Key(comment.id.toString()),
                    direction: DismissDirection.startToEnd,
                    onDismissed: (direction) {
                      _scaffoldKey.currentState.showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Text('Aguarde, excluindo cliente...'),
                        ),
                      );
                      setState(() {
                        _comments.removeAt(index);
                      });
                      _deleteComment(comment.id).then((_) => {
                            _scaffoldKey.currentState.hideCurrentSnackBar(),
                          });
                    },
                    child: CardComment(comment: comment));
              } else {
                return CardComment(comment: comment);
              }
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: primaryColor,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddCommentPage(placeId: widget.placeId),
            ),
          ).then((resp) {
            if (resp) this._getCommentsPlace();
          });
        },
        child: Icon(Icons.add_comment, color: Colors.white),
      ),
    );
  }
}
