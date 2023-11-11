import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interviewgreet/View/common/CustomShimmer.dart';
import 'package:interviewgreet/View/common/cacheShimmerImage.dart';
import 'package:interviewgreet/View/common/cardIconTittle.dart';
import 'package:interviewgreet/View/common/customHorizontalScrollList.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

const secondaryColor = Color.fromARGB(255, 243, 243, 243);
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme().copyWith(
          bodyMedium: GoogleFonts.poppins(),
        ),
        colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 244, 132, 5)),
        useMaterial3: true,
      ),
      // home: const HomeScreen(),
      home: const MyHomePage(title: "fvfvfv"),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String formattedDate = " ";
  double viewPort = 0.94;
  bool loading = true;
  Map content = {
    "curousel": [
      {},
      {},
      {},
      {},
      {},
      {},
    ]
  };
  late PageController pageController;
  late PageController pageController2;
  date() async {
    // Assuming data coming from api
    Future.delayed(const Duration(seconds: 4)).whenComplete(() {
      setState(() {
        loading = false;
      });
    });
    pageController = PageController(viewportFraction: viewPort);
    pageController2 = PageController(viewportFraction: viewPort);
    final DateTime now = DateTime.now();
    final DateFormat formatter = DateFormat('dd MMM ,yyyy');
    setState(() {
      formattedDate = formatter.format(now);
    });

    Timer.periodic(const Duration(seconds: 4), (time) async {
      int nexPage = (pageController.page?.toInt() ?? 0) + 1;
      if (nexPage == content["curousel"].length) {
        nexPage = 0;
      }
      await pageController.animateToPage(
        nexPage,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });
    Timer.periodic(const Duration(seconds: 4), (time) async {
      int nexPage = (pageController2.page?.toInt() ?? 0) + 1;
      if (nexPage == content["curousel"].length) {
        nexPage = 0;
      }
      await pageController2.animateToPage(
        nexPage,
        duration: const Duration(seconds: 1),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  void initState() {
    date();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    final horizontalShimmer = SizedBox(
      height: 110,
      width: width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 13),
              child: CustomShimmer(
                height: 100,
                width: 100,
              ),
            );
          }),
    );
    return Container(
      color: Colors.white,
      child: SafeArea(
        bottom: false,
        child: Scaffold(
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.white,
              shape: const CircleBorder(),
              onPressed: () {},
              child: Image.asset("assets/icons/unnamed.webp")),
          backgroundColor: secondaryColor,
          body: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Container(
                color: Colors.white,
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(children: [
                    Padding(
                        padding: const EdgeInsets.only(left: 10, right: 15),
                        child: CacheShimmerImage(
                            height: 50,
                            width: 50,
                            boxDecoration:
                                const BoxDecoration(shape: BoxShape.circle),
                            url:
                                "https://source.unsplash.com/random/?avatar,snapchat")),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        // mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Jaspreet Singh",
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              Icon(
                                Icons.arrow_drop_down,
                              )
                            ],
                          ),
                          Text(
                            "Default",
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 16,
                                color: Color.fromARGB(255, 141, 141, 141),
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0).copyWith(right: 10),
                      child: Image.asset(
                        "assets/icons/Iconoir-Team-Iconoir-Frame-tool.512.png",
                        height: 35,
                      ),
                    )
                  ]),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    const Gap(10),
                    loading
                        ? CustomShimmer(height: 230, width: width)
                        : SizedBox(
                            width: width - 20,
                            height: 230,
                            child: PageView.builder(
                                clipBehavior: Clip.none,
                                itemCount: content["curousel"].length,
                                controller: pageController,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return AnimatedBuilder(
                                      animation: pageController,
                                      builder: (context, child) {
                                        double pageOffset = 0;
                                        if (pageController
                                            .position.haveDimensions) {
                                          pageOffset =
                                              pageController.page! - index;
                                        }
                                        double gauss = math.exp(-(math.pow(
                                                (pageOffset.abs() - 0.5), 2) /
                                            0.08));

                                        return Transform.translate(
                                          offset: Offset(
                                              -32 * gauss * pageOffset.sign, 0),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: CacheShimmerImage(
                                              height: 100,
                                              fit: BoxFit.none,
                                              alignment: Alignment(
                                                  -pageOffset.abs(), 0),
                                              boxDecoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: const Offset(8, 20),
                                                    blurRadius: 24,
                                                  ),
                                                ],
                                              ),
                                              //https://source.unsplash.com/random/900×700/?fruit
                                              url:
                                                  "https://source.unsplash.com/random/$width×100/?clouds&$index",
                                            ),
                                          ),
                                        );
                                      });
                                }),
                          ),
                    const Gap(10),
                    loading
                        ? CustomShimmer(height: 10, width: 60)
                        : SmoothPageIndicator(
                            controller: pageController,
                            count: content["curousel"].length,
                            effect: const WormEffect(
                                activeDotColor:
                                    Color.fromARGB(255, 244, 132, 5),
                                dotHeight: 3,
                                dotWidth: 20,
                                radius: 1,
                                type: WormType.normal,
                                dotColor: Color.fromARGB(255, 210, 208, 208)),
                          ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: loading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomShimmer(height: 10, width: 80),
                                CustomShimmer(height: 10, width: 80),
                              ],
                            )
                          : CardIconTittle(
                              tittle: "Today's Festivals",
                              tag: formattedDate,
                            ),
                    ),
                    const Gap(15),
                    loading
                        ? horizontalShimmer
                        : CustomHorizontalScrollList(
                            showtags: true,
                            filter: "Festivals",
                          ),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: loading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomShimmer(height: 10, width: 80),
                                //    CustomShimmer(height: 10, width: 80),
                              ],
                            )
                          : CardIconTittle(
                              tittle: "Today's Famous Personality",
                              // tag: formattedDate,
                            ),
                    ),
                    const Gap(15),
                    loading
                        ? horizontalShimmer
                        : CustomHorizontalScrollList(
                            itemCount: 1,
                            showtags: true,
                            filter: "Influencers,indian",
                          ),
                    const Gap(15),
                    Container(
                      // height: 180,
                      width: width - 16,
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.black, width: 0.1),
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(18))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 15)
                                .copyWith(top: 15),
                            child: loading
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomShimmer(height: 10, width: 80),
                                      CustomShimmer(height: 10, width: 80),
                                    ],
                                  )
                                : CardIconTittle(
                                    tittle: "Temples",
                                    tag: "View All   >",
                                    tagStyle: const TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 244, 132, 5),
                                        fontWeight: FontWeight.w700),
                                  ),
                          ),
                          loading
                              ? horizontalShimmer
                              : CustomHorizontalScrollList(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  filter: "Temples",
                                  radius: 80,
                                  showtags: true,
                                ),
                        ],
                      ),
                    ),
                    const Gap(15),
                    Container(
                      // height: 180,
                      width: width - 16,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10)
                                .copyWith(top: 15),
                            child: loading
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomShimmer(height: 10, width: 80),
                                      CustomShimmer(height: 10, width: 80),
                                    ],
                                  )
                                : CardIconTittle(
                                    tittle: "Good Morning",
                                    tag: "View All   >",
                                    tagStyle: const TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 244, 132, 5),
                                        fontWeight: FontWeight.w700),

                                    // tag: formattedDate,
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: loading
                                ? horizontalShimmer
                                : CustomHorizontalScrollList(
                                    showtags: false,
                                    filter: "Morning",
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(15),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: loading
                          ? CustomShimmer(height: 136, width: width)
                          : Container(
                              //   padding: const EdgeInsets.all(5),
                              height: 136,
                              width: width,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 251, 251, 251),
                                  border: Border.all(
                                      color: Colors.black, width: 0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(18)),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/IMG_5466.jpg"),
                                      fit: BoxFit.contain)),
                            ),
                    ),
                    const Gap(15),
                    Container(
                      // height: 180,
                      width: width - 16,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10)
                                .copyWith(top: 15),
                            child: loading
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomShimmer(height: 10, width: 80),
                                      CustomShimmer(height: 10, width: 80),
                                    ],
                                  )
                                : CardIconTittle(
                                    tittle: "Leadership quotes",
                                    tag: "View All   >",
                                    tagStyle: const TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 244, 132, 5),
                                        fontWeight: FontWeight.w700),

                                    // tag: formattedDate,
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: loading
                                ? horizontalShimmer
                                : CustomHorizontalScrollList(
                                    showtags: false,
                                    filter: "quotes",
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(15),
                    loading
                        ? CustomShimmer(height: 230, width: width - 20)
                        : SizedBox(
                            width: width,
                            height: 230,
                            child: PageView.builder(
                                clipBehavior: Clip.none,
                                itemCount: content["curousel"].length,
                                controller: pageController2,
                                scrollDirection: Axis.horizontal,
                                itemBuilder: (context, index) {
                                  return AnimatedBuilder(
                                      animation: pageController2,
                                      builder: (context, child) {
                                        double pageOffset = 0;
                                        if (pageController
                                            .position.haveDimensions) {
                                          pageOffset =
                                              pageController2.page! - index;
                                        }
                                        double gauss = math.exp(-(math.pow(
                                                (pageOffset.abs() - 0.5), 2) /
                                            0.08));

                                        return Transform.translate(
                                          offset: Offset(
                                              -32 * gauss * pageOffset.sign, 0),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 5),
                                            child: CacheShimmerImage(
                                              height: 100,
                                              fit: BoxFit.none,
                                              alignment: Alignment(
                                                  -pageOffset.abs(), 0),
                                              boxDecoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(16),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black
                                                        .withOpacity(0.1),
                                                    offset: const Offset(8, 20),
                                                    blurRadius: 24,
                                                  ),
                                                ],
                                              ),
                                              //https://source.unsplash.com/random/900×700/?fruit
                                              url:
                                                  "https://source.unsplash.com/random/?Technology&$index",
                                            ),
                                          ),
                                        );
                                      });
                                }),
                          ),
                    const Gap(10),
                    loading
                        ? CustomShimmer(height: 10, width: 60)
                        : SmoothPageIndicator(
                            controller: pageController2,
                            count: content["curousel"].length,
                            effect: const WormEffect(
                                activeDotColor:
                                    Color.fromARGB(255, 244, 132, 5),
                                dotHeight: 3,
                                dotWidth: 20,
                                radius: 1,
                                type: WormType.normal,
                                dotColor: Color.fromARGB(255, 210, 208, 208)),
                          ),
                    const Gap(20),
                    loading
                        ? CustomShimmer(height: 200, width: width - 20)
                        : Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Container(
                              constraints: const BoxConstraints(maxWidth: 540),
                              //   padding: const EdgeInsets.all(5),
                              height: 200,
                              width: width,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 251, 251, 251),
                                  border: Border.all(
                                      color: Colors.black, width: 0.1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(18)),
                                  image: const DecorationImage(
                                      image: AssetImage(
                                          "assets/icons/postOnWhatsApp.jpg"),
                                      fit: BoxFit.cover)),
                            ),
                          ),
                    const Gap(15),
                    Container(
                      // height: 180,
                      width: width - 16,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(18))),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10)
                                .copyWith(top: 15),
                            child: loading
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomShimmer(height: 10, width: 80),
                                      CustomShimmer(height: 10, width: 80),
                                    ],
                                  )
                                : CardIconTittle(
                                    tittle: "Fitness/Yoga",
                                    tag: "View All   >",
                                    tagStyle: const TextStyle(
                                        fontSize: 16,
                                        color: Color.fromARGB(255, 244, 132, 5),
                                        fontWeight: FontWeight.w700),

                                    // tag: formattedDate,
                                  ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: loading
                                ? horizontalShimmer
                                : CustomHorizontalScrollList(
                                    showtags: false,
                                    filter: "Fitness,Yoga",
                                  ),
                          ),
                        ],
                      ),
                    ),
                    const Gap(15),
                    const Gap(20),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: loading
                          ? Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                CustomShimmer(height: 10, width: 80),
                                CustomShimmer(height: 10, width: 80),
                              ],
                            )
                          : CardIconTittle(
                              tittle: "Upcoming Festivals / Personality",
                            ),
                    ),
                    const Gap(15),
                    loading
                        ? horizontalShimmer
                        : CustomHorizontalScrollList(
                            padding: const EdgeInsets.symmetric(horizontal: 3),
                            myHeight: 60,
                            showtags: true,
                            filter: "Festivals",
                          ),
                    const Gap(20),
                    if (width < 600)
                      SizedBox(
                          width: width,
                          height: 160,
                          child: Image.asset(
                            "assets/icons/1675071867893.jpeg",
                            fit: BoxFit.cover,
                            color: const Color.fromARGB(255, 245, 245, 245),
                            colorBlendMode: BlendMode.darken,
                          ))
                  ],
                )),
              ),
            ],
          ),
          // This trailing comma makes auto-formatting nicer for build methods.
        ),
      ),
    );
  }
}
