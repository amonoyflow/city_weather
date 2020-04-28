class Temp {
  num day;
  num min;
  num max;
  num night;
  num eve;
  num morn;

  Temp({
    this.day,
    this.min,
    this.max,
    this.night,
    this.eve,
    this.morn
  });

  Temp.fromJson(Map<String, dynamic> json) {
    this.day = json["day"];
    this.min = json["min"];
    this.max = json["max"];
    this.night = json["night"];
    this.eve = json["eve"];
    this.morn = json["morn"];
  }

  Map<String, dynamic> toJson() => {
    "day": this.day,
    "min": this.min,
    "max": this.max,
    "night": this.night,
    "eve": this.eve,
    "morn": this.morn,
  };
}