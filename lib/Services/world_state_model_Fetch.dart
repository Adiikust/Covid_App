import 'dart:convert';



import 'package:covid_app/Models/WorldStateModel.dart';
import 'package:covid_app/Services/Utitlies/app_url_screen.dart';
import 'package:http/http.dart' as http;

class WorldStatesViewModel {


  Future<WorldStateModel> fetchWorldRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return WorldStateModel.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

}
