class SpecificDay{
  int year;
  int month;
  int day;
  SpecificDay(this.year,this.month,this.day);
  SpecificDay.fromJson(Map<String, dynamic> json)
      : year = json['year'],
        month = json['month'],
        day = json['day'];
  Map<String,dynamic>toJson() => {
    'year':year,
    'month':month,
    'day':day,
  };
}