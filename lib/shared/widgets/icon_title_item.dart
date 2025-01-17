import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mobile_bursar_android/shared/constants/constants.dart';

class IconTitleItem extends StatelessWidget {
  const IconTitleItem({
    super.key,
    required this.onTap,
    required this.title,
    required this.icon,
    this.backgroundColor = Colors.transparent,
    this.paddingTop = 8,
    this.paddingBottom = 8,
    this.paddingLeft = 16,
    this.paddingRight = 32,
    this.marginTop = 0,
    this.marginBottom = 0,
    this.marginLeft = 0,
    this.marginRight = 0,
    this.drawablePadding = 10,
  });

  final Function() onTap;
  final String icon;
  final String title;
  final Color backgroundColor;

  final double paddingLeft, paddingTop, paddingRight, paddingBottom;
  final double marginLeft, marginTop, marginRight, marginBottom;
  final double drawablePadding;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin:
          EdgeInsets.fromLTRB(marginLeft, marginTop, marginRight, marginBottom),
      child: Material(
        borderRadius: BorderRadius.circular(11),
        color: backgroundColor,
        child: InkWell(
          onTap: onTap,
          customBorder:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                paddingLeft, paddingTop, paddingRight, paddingBottom),
            child: Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 25,
                  height: 25,
                  colorFilter: ColorFilter.mode(
                    ColorConstants.secondaryAppColor,
                    BlendMode.srcIn,
                  ),
                ),
                SizedBox(
                  width: drawablePadding,
                ),
                Expanded(
                    child: Text(
                  title,
                  style:
                      TextStyle(color: ColorConstants.darkGray, fontSize: 16),
                )),
                Icon(
                  Icons.chevron_right,
                  color: ColorConstants.darkGray,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
