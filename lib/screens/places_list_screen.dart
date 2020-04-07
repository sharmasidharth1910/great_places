import 'package:flutter/material.dart';
import 'package:great_places/providers/great_places.dart';
import 'package:great_places/screens/add_place_screen.dart';
import 'package:provider/provider.dart';

class PlacesListScreen extends StatelessWidget {
  static const id = "PlacesListScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Your Places"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, AddPlaceScreen.id);
            },
          )
        ],
      ),
      body: FutureBuilder(
        future: Provider.of<GreatPlaces>(context, listen: false)
            .fetchAndSetPlaces(),
        builder: (context, snapshot) => snapshot.connectionState ==
                ConnectionState.waiting
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Consumer<GreatPlaces>(
                child: Center(
                  child: const Text(
                      "Got no places yet, start adding new places.."),
                ),
                builder: (context, greatPlaces, child) =>
                    greatPlaces.items.length <= 0
                        ? child
                        : ListView.builder(
                            itemCount: greatPlaces.items.length,
                            itemBuilder: (context, index) => ListTile(
                              leading: CircleAvatar(
                                backgroundImage:
                                    FileImage(greatPlaces.items[index].image),
                              ),
                              title: Text(greatPlaces.items[index].title),
                              onTap: () {
                                //Go to details page
                              },
                            ),
                          ),
              ),
      ),
    );
  }
}
