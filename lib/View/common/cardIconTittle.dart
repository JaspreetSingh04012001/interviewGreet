import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';

class CardIconTittle extends StatelessWidget {
  String tittle;
  String? tag;
  TextStyle? tagStyle;
  CardIconTittle({Key? key, required this.tittle, this.tag, this.tagStyle})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(
          Icons.emoji_symbols_outlined,
          color: Color.fromARGB(255, 244, 132, 5),
          size: 16,
        ),
        const Gap(8),
        Text(
          tittle,
          style: GoogleFonts.poppins(
              fontSize: 18, fontWeight: FontWeight.w600, letterSpacing: 0),
        ),
        Expanded(child: Container()),
        Text(
          tag ?? "",
          style: tagStyle,
        ),
      ],
    );
  }
}
