import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:safe_place_app/core/models/comment.dart';
import 'package:safe_place_app/ui/ui_constants.dart';

class CardComment extends StatelessWidget {
  final Comment comment;
  const CardComment({Key key, this.comment}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (comment.userName == null) {
      return null;
    }

    return ExpandableNotifier(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Card(
          clipBehavior: Clip.antiAlias,
          child: Column(
            children: <Widget>[
              ScrollOnExpand(
                scrollOnExpand: true,
                scrollOnCollapse: false,
                child: ExpandablePanel(
                  theme: const ExpandableThemeData(
                    headerAlignment: ExpandablePanelHeaderAlignment.center,
                    tapBodyToCollapse: true,
                  ),
                  header: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 15.0,
                            backgroundColor: fontPrimaryColor,
                            backgroundImage: AssetImage('assets/pessoa_1.jpg'),
                          ),
                          SizedBox(width: 6.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                comment.userName,
                                style: TextStyle(
                                    fontSize: 16,
                                    color: fontPrimaryColor,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      )),
                  collapsed: Text(
                    comment.title,
                    softWrap: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  expanded: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              comment.title,
                            )),
                        Padding(
                            padding: EdgeInsets.only(bottom: 10),
                            child: Text(
                              comment.commentText,
                              softWrap: true,
                              overflow: TextOverflow.fade,
                            )),
                      ]),
                  builder: (_, collapsed, expanded) {
                    return Padding(
                      padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                      child: Expandable(
                        collapsed: collapsed,
                        expanded: expanded,
                        theme: const ExpandableThemeData(crossFadePoint: 0),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
