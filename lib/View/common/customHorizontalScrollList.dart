import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:interviewgreet/View/common/cacheShimmerImage.dart';

class CustomHorizontalScrollList extends StatefulWidget {
  bool showtags = false;
  String filter;
  double? radius;
  int? itemCount;
  double? myHeight;
  EdgeInsetsGeometry? padding;
  CustomHorizontalScrollList(
      {Key? key,
      required this.showtags,
      this.padding,
      this.radius,
      this.itemCount,
      this.myHeight,
      required this.filter})
      : super(key: key);

  @override
  _CustomHorizontalScrollListState createState() =>
      _CustomHorizontalScrollListState();
}

class _CustomHorizontalScrollListState
    extends State<CustomHorizontalScrollList> {
  final double height = 100;
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return SizedBox(
      width: width,
      height: widget.showtags
          ? (widget.myHeight ?? height) + 34
          : (widget.myHeight ?? height),
      child: ListView.builder(
          itemCount: widget.itemCount,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            var faker = Faker();
            return Padding(
              padding:
                  widget.padding ?? const EdgeInsets.symmetric(horizontal: 4),
              child: SizedBox(
                width: widget.radius ?? (widget.myHeight ?? height),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    CacheShimmerImage(
                        height: widget.radius ?? (widget.myHeight ?? height),
                        width: widget.radius ?? (widget.myHeight ?? height),
                        boxDecoration: widget.radius == null
                            ? BoxDecoration(
                                color: const Color.fromARGB(255, 215, 214, 214),
                                borderRadius: BorderRadius.circular(16))
                            : const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color.fromARGB(255, 215, 214, 214),
                                // borderRadius: BorderRadius.circular(16)
                              ),
                        url:
                            "https://source.unsplash.com/random/$i/?${widget.filter}"),
                    widget.showtags
                        ? Expanded(
                            child: Center(
                                child: Text(
                            faker.person.name(),
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: widget.radius == null
                                ? GoogleFonts.poppins(
                                    fontSize: 11,
                                    color: const Color.fromARGB(
                                        255, 116, 116, 116))
                                : const TextStyle(fontSize: 13),
                          )))
                        : Container(),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
