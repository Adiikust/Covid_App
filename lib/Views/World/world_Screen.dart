
import 'package:covid_app/Controller/Export/export_screen.dart';
import 'package:covid_app/Models/WorldStateModel.dart';
import 'package:covid_app/Services/world_state_model_Fetch.dart';
import 'package:covid_app/Views/Countries/country_Screen.dart';
import 'package:covid_app/Widget/build_Row.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WorldScreen extends StatefulWidget {
  const WorldScreen({Key? key}) : super(key: key);

  @override

  State<WorldScreen> createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> with TickerProviderStateMixin{

  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 10),
    vsync: this,
  )..repeat();

  WorldStatesViewModel worldStatesViewModel=WorldStatesViewModel();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();

  }

  @override
  Widget build(BuildContext context) {

    final data =MediaQuery.of(context);
    return Scaffold(
      //backgroundColor:AppColors.kBGColor,
      body: SafeArea(
       child:Padding(
         padding: const EdgeInsets.all(8.0),
         child: Column(
           children:[
             SizedBox(height: data.size.height * 0.02,),

             FutureBuilder(
               future: worldStatesViewModel.fetchWorldRecords(),
                 builder: (context,AsyncSnapshot<WorldStateModel>snapshot){
                 if(!snapshot.hasData){
                   return Expanded(
                     flex: 1,
                     child: SpinKitFadingCircle(
                       color: AppColors.kBGColor,
                       size: 50.0,
                       controller: _controller,
                     ),
                   );
                 }else{
                   return Column(children: [
                     PieChart(
                       centerTextStyle: const TextStyle(color: AppColors.kWhite),
                       dataMap: {
                         "TodayCases": double.parse(snapshot.data!.recovered.toString()),
                         "Deaths":double.parse(snapshot.data!.recovered.toString()),
                         "Recovered":double.parse(snapshot.data!.recovered.toString()),

                         // double.parse(snapshot.data!.recovered.toString()),
                       },
                       colorList: const [
                         Color(0xff4285F4),
                         Color(0xff1aa260),
                         Color(0xffde5246),
                       ],

                     ),
                     SizedBox(height: data.size.height * 0.04,),
                     Card(elevation: 5,
                       child: Padding(
                         padding:  EdgeInsets.symmetric(vertical: data.size.height *0.02,horizontal: data.size.width *0.02),
                         child: Column(
                           children: [
                             BuildRow(title: "TodayCases", value: snapshot.data!.todayCases.toString()),
                             BuildRow(title: "TodayDeaths", value: snapshot.data!.todayDeaths.toString()),
                             BuildRow(title: "Recovered", value: snapshot.data!.recovered.toString()),
                             BuildRow(title: "todayRecovered", value: snapshot.data!.todayRecovered.toString()),
                             BuildRow(title: "Deaths", value: snapshot.data!.deaths.toString()),
                             BuildRow(title: "Critical", value: snapshot.data!.critical.toString()),
                           ],
                         ),
                       ),
                     ),
                     SizedBox(height: data.size.height * 0.04,),
                     GestureDetector(
                       onTap: (){
                         Navigator.push(context, MaterialPageRoute(builder: (context) => const CountryScreen()));
                       },
                       child: Container(
                         height: 50,
                         decoration: BoxDecoration(
                             color: AppColors.kButton,
                             borderRadius:BorderRadius.circular(10)
                         ),
                         child: const Center(
                           child: Text('Track Countries',
                             style: TextStyle(
                                 color: AppColors.kWhite,
                                 fontSize: 18,
                                 fontWeight: FontWeight.bold),
                           ),
                         ),
                       ),
                     ),

                   ],);
                 }
                 },
             ),
      ]
    ),
    ),
      ),
    );
    }
}
