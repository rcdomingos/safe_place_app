class Place {
  int id;
  String name;
  String description;
  String image;
  String category;
  String latitude;
  String longitude;
  double averageTotalScore;
  double averageCleaningScore;
  double averageDistanceScore;
  double averageMaskUseScore;

  Place(
      {this.id,
      this.name,
      this.description,
      this.image,
      this.category,
      this.latitude,
      this.longitude,
      this.averageTotalScore,
      this.averageCleaningScore,
      this.averageDistanceScore,
      this.averageMaskUseScore});

  Place.fromJson(Map<String, dynamic> json) {
    id = json['Id'];
    name = json['Name'];
    description = json['Description'];
    image = json['Image'];
    category = json['Category'];
    latitude = json['Latitude'];
    longitude = json['Longitude'];
    averageTotalScore = json['AverageTotalScore'];
    averageCleaningScore = json['AverageCleaningScore'];
    averageDistanceScore = json['AverageDistanceScore'];
    averageMaskUseScore = json['AverageMaskUseScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['Id'] = this.id;
    data['Name'] = this.name;
    data['Description'] = this.description;
    data['Image'] = this.image;
    data['Category'] = this.category;
    data['Latitude'] = this.latitude;
    data['Longitude'] = this.longitude;
    data['AverageTotalScore'] = this.averageTotalScore;
    data['AverageCleaningScore'] = this.averageCleaningScore;
    data['AverageDistanceScore'] = this.averageDistanceScore;
    data['AverageMaskUseScore'] = this.averageMaskUseScore;
    return data;
  }
}
