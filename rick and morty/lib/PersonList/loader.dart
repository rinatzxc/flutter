import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class Person {
  int id;
  String name;
  String status;
  String avatar;
  String species;
  String locationName;
}

Stream loadPersonsByEpisode(List charters) async* {
  for (var i = 0; i < charters.length; i++) {
    yield await http.get(Uri.parse(charters[i]));
  }
}

Future<List<Person>> loadPersons(String uri) async {
  var response = await http.get(Uri.parse(uri));
  List<Person> persons = [];

  if (response.statusCode == 200) {
    var jsonResponse = convert.jsonDecode(response.body);
    List<dynamic> resultsList = jsonResponse["results"];

    for (var result in resultsList) {
      Person person = Person();
      person.id = result["id"];
      person.name = result["name"];
      person.status = result["status"];
      person.species = result["species"];
      person.avatar = result["image"];
      person.locationName = result["location"]["name"];

      persons.add(person);
    }
  } else {}

  return persons;
}
