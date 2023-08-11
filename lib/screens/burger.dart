import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class Burger extends StatefulWidget {
  const Burger({Key? key}) : super(key: key);

  @override
  State<Burger> createState() => _BurgerState();
}

class _BurgerState extends State<Burger> {

  double total = 20;

  List<double> bottom = [];
  List<String> name = [];

  set(double b,String s){
    bottom.add(MediaQuery.of(context).size.height-150);
    total = total + b;
    name.add(s);
    Future.delayed(const Duration(milliseconds: 50),(){
      setState(() {
        bottom[bottom.length-1] = total;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xffF27121),Color(0xffE94057)],
                begin: Alignment.topCenter,
                end: Alignment.bottomRight,
                stops: [0,1]
            )
        ),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              top: 30,
              child: SizedBox(
                height: 150,
                width: MediaQuery.of(context).size.width,
                child: CarouselSlider(
                    items: List.generate(5, (index) =>
                        GestureDetector(
                          onTap: (){
                            setState(() {
                              set(30,"assets/burger/burger${index+2}.png");
                            });
                          },
                          child: Container(
                            width: 250,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Image.asset("assets/burger/burger${index+2}.png"),
                            ),
                          ),
                        ),),
                    options: CarouselOptions(
                      height: 400,
                      aspectRatio: 16/9,
                      viewportFraction: 0.8,
                      initialPage: 0,
                      enableInfiniteScroll: true,
                      reverse: false,
                      autoPlay: true,
                      autoPlayInterval: const Duration(seconds: 3),
                      autoPlayAnimationDuration: const Duration(milliseconds: 800),
                      autoPlayCurve: Curves.fastOutSlowIn,
                      enlargeCenterPage: true,
                      enlargeFactor: 2,
                      scrollDirection: Axis.horizontal,
                    )
                ),
              ),
            ),

            Positioned(
              bottom: -30,
              width: 280,
              child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child: Center(child: Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset("assets/burger/burger1.png"),
                  ))),),

            for(int i = 0; i < bottom.length; i++)
              position(bottom[i], name[i],i),

          ],
        ),
      ),
    );
  }

  position(double b, String s,int inx){
    return s != "assets/burger/burger6.png" ?
    AnimatedPositioned(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeIn,
      bottom: b,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(child: Image.asset(s,width: 250,)),
      ),
    ) : AnimatedPositioned(
      duration: const Duration(milliseconds: 800),
      curve: Curves.easeIn,
      left: -10,
      bottom: b,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Center(child: Image.asset(s,width: 220,)),
      ),
    );
  }
}
