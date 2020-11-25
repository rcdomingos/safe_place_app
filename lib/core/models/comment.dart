class Comment {
  int id;
  String userName;
  int userId;
  String title;
  String commentText;

  Comment({this.id, this.userName, this.userId, this.title, this.commentText});

  Comment.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userName = json['UserName'];
    userId = json['UserId'];
    title = json['Title'];
    commentText = json['CommentText'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserName'] = this.userName;
    data['UserId'] = this.userId;
    data['Title'] = this.title;
    data['CommentText'] = this.commentText;
    return data;
  }
}
