import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:great_places/helpers/db_helper.dart';
import 'package:great_places/models/place.dart';

class GreatPlaces with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  void addPlace(String pickedTitle, File pickedImage) {
    final newPlace = Place(
      id: DateTime.now().toString(),
      image: pickedImage,
      title: pickedTitle,
      location: null,
    );
    _items.add(newPlace);
    notifyListeners();
    DBHelper.insert("user_places", {
      "id": newPlace.id,
      "image": newPlace.image.path,
      "title": newPlace.title,
    });
  }

  Future<void> fetchAndSetPlaces() async {
    final dataList = await DBHelper.getData("user_places");
    _items = dataList
        .map(
          (item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: null,
          ),
        )
        .toList();
        notifyListeners();
  }
}
