import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:fruts_e_commerce/core/utils/app_images.dart';
import 'package:fruts_e_commerce/features/home/presentation/views/widgets/featured_item_button.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart' as svg;

class FeaturedItem extends StatelessWidget {
  const FeaturedItem({super.key});

  @override
  Widget build(BuildContext context) {
    var itemWidth= MediaQuery.sizeOf(context).width-32;
    return ClipRRect(
      borderRadius: BorderRadius.circular(4),
      child: SizedBox(
        width: itemWidth,
        child: AspectRatio(
          aspectRatio: 342/158,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                bottom: 0,
                top: 0,
                right: itemWidth * .4,
                child: SvgPicture.asset(
                  Assets.imagesPageViewItem2Image ,
                  fit: BoxFit.fill,
                  )),
              Container(
                width: itemWidth * .5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: svg.Svg(Assets.imagesFeaturedItemBackground),
                    fit: BoxFit.fill
                    )
                ),
                child: Padding(
                  padding: const EdgeInsets.only(right: 33),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 25,),
                      Text( ' عروض العيد  ' , style: TextStyle(
                        color: Colors.white,
                        fontSize: 13,
                        fontWeight: FontWeight.w400
                      ),),
                      Spacer(),
                      Text( ' خصم 25%' , style: TextStyle(
                        color: Colors.white,
                        fontSize: 19,
                        fontWeight: FontWeight.w700
                      ),),
                  
                      SizedBox(height: 11,),
                      FeaturedItemButton(onPressed: (){}),
                      SizedBox(height: 29)
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}