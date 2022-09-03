

import 'dart:async';

import 'package:covid_app/Controller/Export/export_screen.dart';
import 'dart:math' as math;




class SplashScreen extends StatefulWidget {
   const SplashScreen({Key? key}) : super(key: key);


  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with TickerProviderStateMixin{

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
  void initState() {
    // TODO: implement initState
    super.initState();
   Timer(const Duration(seconds: 3), () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WorldScreen())));
  }


  @override
  Widget build(BuildContext context) {
    final data =MediaQuery.of(context);
    return Scaffold(
      backgroundColor:AppColors.kBGColor,
      body: SafeArea(child:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          AnimatedBuilder(
              animation: _controller,
              child: SizedBox(
                width: data.size.width * 0.2,
                height: data.size.height * 0.2,
                child: Image.asset("images/img1.png"),
              ),
              builder: (BuildContext context, Widget? child){
                return Transform.rotate(
                    angle: _controller.value * 2.0 * math.pi,
                    child:child,
                );

              },
              ),
          SizedBox(height: data.size.height * 0.001,),
          const Align(
            child: Text("Covid\nTracker App",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                color:AppColors.kWhite
              ),
            ),
          ),
        ],
      ),
    ),
    );
  }
}
