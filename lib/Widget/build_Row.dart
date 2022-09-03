

import 'package:covid_app/Controller/Export/export_screen.dart';

class BuildRow extends StatelessWidget {
  String title,value;
   BuildRow({Key? key,required this.title, required this.value}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final data =MediaQuery.of(context);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Text(title,style: const TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
            Text(value,style: const TextStyle(fontSize: 18),),
          ],
        ),
        SizedBox(height: data.size.height * 0.03),

      ],
    );
  }
}
