class SettingsDto {
  bool isImperial;

  SettingsDto({
    this.isImperial
  });

  SettingsDto.fromMapObject(Map<String, dynamic> json) {
    this.isImperial = json["is_imperial"] == 1;
  }

  Map<String, dynamic> toMap() => {
    "is_imperial": this.isImperial,
  };
}