import 'package:flutter/material.dart';
import 'package:skillboxdemoapp/locationdetails.dart';
import 'package:skillboxdemoapp/persondetails/loader.dart';

class PersonDetailsPage extends StatefulWidget {
  PersonDetailsPage({Key key, this.id}) : super(key: key);

  final int id;

  @override
  _State createState() => _State(id: id);
}

class _State extends State<PersonDetailsPage> {
  _State({this.id}) : super();

  int id;
  PersonDetails person;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    var personInfo = await loadPerson(id);
    setState(() {
      person = personInfo;
    });
  }

  MaterialColor getColor(String status) {
    Map<String, MaterialColor> statusColor = {
      'Alive': Colors.green,
      'Dead': Colors.red,
      'unknown': Colors.grey
    };

    return statusColor[status];
  }

  @override
  Widget build(BuildContext context) {
    var widget;
    Text title;

    if (person == null) {
      title = Text('Loading...');
      widget = Center(child: CircularProgressIndicator());
    } else {
      title = Text(person.name);
      widget = SafeArea(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Container(
                  width: double.infinity,
                  child: FittedBox(
                    child: Hero(
                      tag: '${person.name}-image',
                      child: Image.network(
                        person.avatar,
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Flexible(
                        child: Text(
                          person.name,
                          style: TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              shadows: [
                                Shadow(
                                  offset: Offset(3.0, 3.0),
                                  blurRadius: 0.0,
                                  color: getColor(person.status),
                                ),
                              ]),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 30,
                        height: 30,
                        decoration: BoxDecoration(
                            color: getColor(person.status),
                            shape: BoxShape.circle),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            ListTile(
                onTap: () {
                  showLocationDetails(context, person.name, person.episodes[0]);
                },
                title: Text(person.species),
                subtitle: Text(person.gender),
                trailing: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: Text(
                        'Last known location:',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                    Text(person.locationName),
                  ],
                ),
                leading: Icon(Icons.person)),
          ],
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        title: title,
      ),
      body: widget,
    );
  }
}
