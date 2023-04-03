import 'package:flutter/material.dart';
import 'package:skillboxdemoapp/persondetails/widget.dart';
import 'package:skillboxdemoapp/personlist/loader.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Person> persons = [];
  int page = 1;
  bool isLoading = false;

  @override
  void initState() {
    loadProcess();
    super.initState();
  }

  void loadProcess() async {
    var loadedPersons = await loadPersons(
        'https://rickandmortyapi.com/api/character?page=${this.page}');
    setState(() {
      this.persons.addAll(loadedPersons);
      isLoading = false;
    });
  }

  void navigateToDetails(int personId) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PersonDetailsPage(id: personId),
        ));
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
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text(widget.title)),
      ),
      body: SafeArea(
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (!isLoading &&
                scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent) {
              setState(() {
                this.page++;
                isLoading = true;
              });
              loadProcess();
            }
          },
          child: ListView.builder(
              itemCount: persons.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: SizedBox(
                    height: 150,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (_) {
                          return PersonDetailsPage(id: persons[index].id);
                        }));
                      },
                      child: Card(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Hero(
                              tag: '${persons[index].name}-image',
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(8),
                                    bottomLeft: Radius.circular(8)),
                                child: FadeInImage.assetNetwork(
                                    placeholder:
                                        'assets/images/place_holder.jpg',
                                    image: persons[index].avatar),
                              ),
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      persons[index].name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              width: 10,
                                              height: 10,
                                              decoration: BoxDecoration(
                                                  color: getColor(
                                                      persons[index].status),
                                                  shape: BoxShape.circle),
                                            ),
                                            SizedBox(width: 10),
                                            Text(persons[index].status ?? ''),
                                            Text(' - '),
                                            Text(persons[index].species ?? '')
                                          ],
                                        ),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          'Last known location:',
                                          style: TextStyle(color: Colors.grey),
                                        ),
                                        Text(persons[index].locationName),
                                        SizedBox(
                                          height: 5,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              }),
        ),
      ),
    );
  }
}
