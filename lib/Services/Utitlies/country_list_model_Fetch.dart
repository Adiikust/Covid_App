import 'dart:convert';

import 'package:covid_app/Models/ContryListModel.dart';
import 'package:covid_app/Services/Utitlies/app_url_screen.dart';
import 'package:http/http.dart' as http;

class CountryListViewModel{

  List<ContryListModel> getData=[];
  Future<List<ContryListModel>> fetchCountryListRecords() async {
    final response = await http.get(Uri.parse(AppUrl.worldStateApi));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
    for(Map i in data){
      getData.add(ContryListModel.fromJson(i));
    }
    return  getData;
      //return ContryListModel.fromJson(data);

    } else {
      return  getData;
    }
  }

}