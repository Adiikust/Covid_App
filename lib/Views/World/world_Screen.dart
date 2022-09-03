

import 'package:covid_app/Controller/Export/export_screen.dart';
import 'package:covid_app/Widget/build_Row.dart';
import 'package:pie_chart/pie_chart.dart';

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
            const PieChart(
              centerTextStyle: TextStyle(color: AppColors.kWhite),
              dataMap: {
                "TodayCases": 13,
                "Deaths": 65,
                "Recovered": 58,
              },
              colorList: [
                Color(0xff4285F4),
                Color(0xff1aa260),
                Color(0xffde5246),
              ],

            ),
             SizedBox(height: data.size.height * 0.04,),
             Card(elevation: 5,
               //color: AppColors.kCardColor,
               child: Padding(
                 padding:  EdgeInsets.symmetric(vertical: data.size.height *0.02,horizontal: data.size.width *0.02),
                 child: Column(
                   children: [
                     BuildRow(title: "Cases", value: "609581728"),
                     BuildRow(title: "TodayCases", value: "233528"),
                     BuildRow(title: "Deaths", value: "6501641"),
                     BuildRow(title: "Recovered", value: "585879869"),
                     BuildRow(title: "TodayDeaths", value: "536"),

                   ],
                 ),
               ),
             ),
             SizedBox(height: data.size.height * 0.04,),
        GestureDetector(
          onTap: (){
           // Navigator.push(context, MaterialPageRoute(builder: (context) => const CountriesListScreen()));
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
           ],
         ),
       ),
     ),

    );
  }
}
