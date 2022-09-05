

import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:covid_app/Controller/Export/export_screen.dart';
import 'package:covid_app/Models/ContryListModel.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CountryScreen extends StatefulWidget {
  const CountryScreen({Key? key}) : super(key: key);

  @override
  State<CountryScreen> createState() => _CountryScreenState();

}



class _CountryScreenState extends State<CountryScreen> with TickerProviderStateMixin {

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();
  final TextEditingController _searchController=TextEditingController();
  List<ContryListModel> getData=[];
  Future<List<ContryListModel>> fetchCountryListRecords() async {
    final response = await http.get(Uri.parse("https://disease.sh/v3/covid-19/countries"));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for(Map i in data){
        getData.add(ContryListModel.fromJson(i));
      }
      return  getData;
    } else {
      return  getData;
    }
  }
  @override
  void dispose() {
    _controller.dispose();
    _searchController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.kBGColor,
        title: const Text("Country List",textAlign: TextAlign.center,),
      ),
      body: SafeArea(child:
        Column(children: [
    Padding(
      padding: const EdgeInsets.all(9.0),
      child: TextFormField(

      controller: _searchController,
      onChanged: (value){
        setState((){});
      },
      decoration: InputDecoration(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20),
      border: OutlineInputBorder(

      borderRadius: BorderRadius.circular(50.0),
      ),
      hintText: 'Search with country name',
      )
      )),
        Expanded(
          child: FutureBuilder(
          future: fetchCountryListRecords(),
          builder: (context,snapshot){
        if(!snapshot.hasData){
        return SpinKitFadingCircle(
          color: AppColors.kBGColor,
          size: 50.0,
          controller: _controller,
    );
    }else{
      return ListView.builder(
          itemCount: getData.length,
            itemBuilder: (context, index){
            String name = getData[index].country.toString();
            if(_searchController.text.isEmpty){
              return  ListTile(
                leading: Image(
                    height: data.size.height * 0.22,
                    width: data.size.width * 0.22,
                    image: NetworkImage(getData[index].countryInfo!.flag.toString())),
                title: Text(getData[index].country.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(getData[index].cases.toString()),
              );
            }else if(name.toLowerCase().contains(_searchController.text.toLowerCase())){
              return  ListTile(
                leading: Image(
                    height: data.size.height * 0.22,
                    width: data.size.width * 0.22,
                    image: NetworkImage(getData[index].countryInfo!.flag.toString())),
                title: Text(getData[index].country.toString(),
                  style: const TextStyle(fontWeight: FontWeight.bold),),
                subtitle: Text(getData[index].cases.toString()),
              );
            }else{
              return Container();

              }
            }

      );
    }
          }
          ),
        ),
        ],
        ),
      ),
    );
  }
}
