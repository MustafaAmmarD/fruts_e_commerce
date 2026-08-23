import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruts_e_commerce/core/utils/app_images.dart';

class SearchTextField extends StatelessWidget {
  const SearchTextField({
    super.key,
    this.onTap,
    this.onFilterTap,
    this.onChanged,
    this.onSubmitted,
    this.controller,
  });

  final VoidCallback? onTap;
  final VoidCallback? onFilterTap;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color(0x0A000000),
            spreadRadius: 0,
            blurRadius: 9,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        onTap: onTap,
        readOnly: onTap != null,
        autofocus: onTap == null,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: SizedBox(
            width: 20,
            child: Center(child: SvgPicture.asset(Assets.imagesSearchIcon))),
          suffixIcon: GestureDetector(
            onTap: onFilterTap,
            child: SizedBox(
              width: 20,
              child: Center(child: SvgPicture.asset(Assets.imagesFilter)),
            ),
          ),
          hintStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 13,
            color: Color(0xFF949D9E)
          ),
          hintText: ' ابحث عن الفواكه ',
          filled: true,
          fillColor: Colors.white,
          border: BuildBoarder(),
          enabledBorder: BuildBoarder(),
          focusedBorder: BuildBoarder(),
        ),
      ),
    );
  }

  OutlineInputBorder BuildBoarder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(4),
        borderSide: BorderSide(
          width: 1,
          color: Colors.white ,
        ),
      );
  }
}
