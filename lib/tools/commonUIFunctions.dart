import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:glassmorphism_ui/glassmorphism_ui.dart';

TextStyle homePageTextStyle({
  bool isClicked = false,
}) {
  return TextStyle(
      fontSize: isClicked ? 25 : 18,
      fontWeight: isClicked ? FontWeight.bold : FontWeight.w200);
}

List<BoxShadow> bxShadow = [
  BoxShadow(
      color: Colors.grey.shade600,
      spreadRadius: 0.3,
      blurRadius: 8,
      offset: Offset(4, 4)),
  BoxShadow(
      color: Colors.white,
      spreadRadius: 0.5,
      blurRadius: 5,
      offset: Offset(-4, -4)),
];
buildSignUpLoginButton(
    {@required BuildContext? context,
    @required String? btnText,
    String? assetImage,
    bool hasIcon = false,
    double fontSize = 20,
    Color color = Colors.white,
    double leftRightPadding = 20.0,
    textColor = Colors.black}) {
  return Padding(
    padding: const EdgeInsets.all(8),
    child: GlassContainer(
      width: MediaQuery.of(context!).size.width * 0.9,
      opacity: 0.3,
      shadowStrength: 8,
      // padding: EdgeInsets.all(8),
      // color: color,
      // intensity: 0.35,
      // style: NeuomorphicStyle.Concave,
      // borderRadius: BorderRadius.circular(20),
      child: hasIcon
          ? Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 8, bottom: 8),
                  child: SvgPicture.asset(
                    assetImage!,
                    height: 25,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    btnText!,
                    style: TextStyle(
                        color: textColor,
                        fontSize: fontSize,
                        fontWeight: FontWeight.bold),
                  ),
                )
              ],
            )
          : Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  btnText!,
                  style: TextStyle(
                      color: textColor,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
    ),
  );
}
