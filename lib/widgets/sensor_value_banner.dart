import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:project_x/style/app_text_theme.dart';

class SensorValueBanner extends StatelessWidget {
  final String title;
  final String value;
  final String image;

  const SensorValueBanner({
    @required this.image,
    @required this.title,
    @required this.value,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height * 0.09,
      width: size.width * 0.45,
      padding:
          EdgeInsets.symmetric(horizontal: size.width * 0.044, vertical: 0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Theme.of(context).scaffoldBackgroundColor,
        border: Border.all(
          color: Theme.of(context).primaryColor,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            image,
            height: 40,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Spacer(flex: 4),
              Text(
                value,
                overflow: TextOverflow.ellipsis,
                style: AppTextTheme.kSub2HeadTextStyle.copyWith(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: "NotoSansLao",
                ),
              ),
              Spacer(flex: 2),
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: AppTextTheme.kSub2HeadTextStyle.copyWith(
                  color: Theme.of(context).primaryColorDark,
                  fontSize: 14,
                  fontFamily: "NotoSansLao",
                ),
              ),
              Spacer(flex: 4),
            ],
          ),
        ],
      ),
    );
  }
}
