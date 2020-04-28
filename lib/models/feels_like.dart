class FeelsLike {
  num day;
  num night;
  num eve;
  num morn;

  FeelsLike({
    this.day,
    this.night,
    this.eve,
    this.morn
  });

  FeelsLike.fromJson(Map<String, dynamic> json) {
    this.day = json["day"];
    this.night = json["night"];
    this.eve = json["eve"];
    this.morn = json["morn"];
  }

  Map<String, dynamic> toJson() => {
    "day": this.day,
    "night": this.night,
    "eve": this.eve,
    "morn": this.morn,
  };
}