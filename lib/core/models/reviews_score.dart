class ReviewsScore {
  int id;
  int userId;
  String userName;
  int totalScore;
  int cleanScore;
  int distanceScore;
  int maskScore;

  ReviewsScore(
      {this.id,
      this.userId,
      this.userName,
      this.totalScore,
      this.cleanScore,
      this.distanceScore,
      this.maskScore});

  ReviewsScore.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    userId = json['UserId'];
    userName = json['UserName'];
    totalScore = json['TotalScore'];
    cleanScore = json['CleanScore'];
    distanceScore = json['DistanceScore'];
    maskScore = json['MaskScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['UserId'] = this.userId;
    data['UserName'] = this.userName;
    data['TotalScore'] = this.totalScore;
    data['CleanScore'] = this.cleanScore;
    data['DistanceScore'] = this.distanceScore;
    data['MaskScore'] = this.maskScore;
    return data;
  }
}
