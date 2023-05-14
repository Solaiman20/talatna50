import './friends_object.dart';
import './bills.dart';

class Talaa {
  final String date;
  final String location;
  final String name;
  final List<Friend> friends;
  Talaa(
    this.date,
    this.friends,
    this.location,
    this.name,
  );

  static Talaa fromJson(Map<String, dynamic> json) {
    return Talaa(json['date'], json['friends'], json['location'], json['name']);
  }
}
