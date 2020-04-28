class Weather {
  num id;
  String main;
  String description;
  String icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon
  });

  Weather.fromJson(Map<String, dynamic> json) {
    this.id = json['id'];
    this.main = json['main'];
    this.description = json['description'];
    this.icon = json['icon'];
  }

  Map<String, dynamic> toJson() => {
    "id": this.id,
    "main": this.main,
    "description": this.description,
    "icon": this.icon
  };
}