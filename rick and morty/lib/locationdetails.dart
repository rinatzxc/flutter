import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

// import 'PersonDetails/loader.dart';
import 'PersonDetails/widget.dart';
import 'PersonList/loader.dart';

void showLocationDetails(BuildContext context, String name, String url) async {
  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var episode = convert.jsonDecode(response.body);

    List<Person> persons = [];
    Stream myStream = loadPersonsByEpisode(episode['characters']);

    await for (var response in myStream) {
      var character = convert.jsonDecode(response.body);
      Person person = Person();
      person.avatar = character['image'];
      person.id = character["id"];
      person.name = character["name"];
      person.status = character["status"];
      persons.add(person);
    }

    MaterialColor getColor(String status) {
      Map<String, MaterialColor> statusColor = {
        'Alive': Colors.green,
        'Dead': Colors.red,
        'unknown': Colors.grey
      };

      return statusColor[status];
    }

    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        height: 500,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),

            // Text(persons[index].locationName),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'First seen in:',
                  style: TextStyle(color: Colors.grey),
                ),
                Text(episode['name'], style: TextStyle(fontSize: 18)),
                Text(episode['air_date'], style: TextStyle(fontSize: 18)),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'With:',
                  style: TextStyle(color: Colors.grey),
                ),
                CarouselSlider(
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: false,
                    viewportFraction: 0.6,
                  ),
                  items: persons
                      .map((person) => Container(
                            width: 200,
                            height: 300,
                            child: Stack(
                              alignment: AlignmentDirectional.bottomStart,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (_) {
                                      return PersonDetailsPage(id: person.id);
                                    }));
                                  },
                                  child: FadeInImage.assetNetwork(
                                      fit: BoxFit.contain,
                                      placeholder:
                                          'assets/images/place_holder.jpg',
                                      image: person.avatar),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: [
                                      Flexible(
                                        child: Text(
                                          person.name,
                                          style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                              shadows: [
                                                Shadow(
                                                  offset: Offset(3.0, 3.0),
                                                  blurRadius: 0.0,
                                                  color:
                                                      getColor(person.status),
                                                ),
                                              ]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Container(
                                        width: 10,
                                        height: 10,
                                        decoration: BoxDecoration(
                                            color: getColor(person.status),
                                            shape: BoxShape.circle),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                          ))
                      .toList(),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
