import '../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'widgets/CircularLoadingWidget.dart';
export 'package:font_awesome_flutter/font_awesome_flutter.dart';

/* APP VARIABLES or CONSTANTS */
class Helper {
  static const appTitle = 'Laxia project';
  static const mainColor = Color(0xFF00cde7); //72ea3a
  static const appTxtColor = Color(0xFF181a3c);
  static const green = Color(0xFF1ec760);
  static const bodyBgColor = Color(0xFFf7f9fc);
  static const lightGrey = Color(0xFFe8e8e8);
  static const darkGrey = Color(0xFFbdbfca);
  static const extraGrey = Color(0xFF828282);
  static const notifyBadgeBgColor = Colors.yellowAccent;
  static const golden = Color(0xFFFFDF00);
  static const notifyBadgeTxtColor = appTxtColor;

  late BuildContext context;
  DateTime? currentBackPressTime;

  Helper.of(BuildContext _context) {
    this.context = _context;
  }

  // for mapping data retrieved form json array
  static getData(Map<String, dynamic> data) {
    return data['data'] ?? [];
  }

  Color getColorFromHex(String hex) {
    if (hex.contains('#')) {
      return Color(int.parse(hex.replaceAll("#", "0xFF")));
    } else {
      return Color(int.parse("0xFF" + hex));
    }
  }

  static BoxFit getBoxFit(String? boxFit) {
    switch (boxFit) {
      case 'cover':
        return BoxFit.cover;
      case 'fill':
        return BoxFit.fill;
      case 'contain':
        return BoxFit.contain;
      case 'fit_height':
        return BoxFit.fitHeight;
      case 'fit_width':
        return BoxFit.fitWidth;
      case 'none':
        return BoxFit.none;
      case 'scale_down':
        return BoxFit.scaleDown;
      default:
        return BoxFit.cover;
    }
  }

  static String? getDiscountPercentage(dynamic offerPrice, dynamic originalPrice, BuildContext context) {
    return "${((offerPrice.toDouble() / originalPrice.toDouble()) * 100).toStringAsFixed(0)} % ${Trans.of(context).offer_off}";
  }

  static AlignmentDirectional getAlignmentDirectional(String? alignmentDirectional) {
    switch (alignmentDirectional) {
      case 'top_start':
        return AlignmentDirectional.topStart;
      case 'top_center':
        return AlignmentDirectional.topCenter;
      case 'top_end':
        return AlignmentDirectional.topEnd;
      case 'center_start':
        return AlignmentDirectional.centerStart;
      case 'center':
        return AlignmentDirectional.topCenter;
      case 'center_end':
        return AlignmentDirectional.centerEnd;
      case 'bottom_start':
        return AlignmentDirectional.bottomStart;
      case 'bottom_center':
        return AlignmentDirectional.bottomCenter;
      case 'bottom_end':
        return AlignmentDirectional.bottomEnd;
      default:
        return AlignmentDirectional.bottomEnd;
    }
  }

  Future<bool> onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null || now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(msg: Trans.of(context).tapAgainToLeave);
      return Future.value(false);
    }
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    return Future.value(true);
  }

  static OverlayEntry overlayLoader(context) {
    OverlayEntry loader = OverlayEntry(builder: (context) {
      final size = MediaQuery.of(context).size;
      return Positioned(
        height: size.height,
        width: size.width,
        top: 0,
        left: 0,
        child: Material(
          color: Theme.of(context).primaryColor.withOpacity(0.85),
          child: CircularLoadingWidget(height: 200),
        ),
      );
    });
    return loader;
  }

  static String convertMilitryTime(String time) {
    String hours = time.substring(0, 2);
    String minutes = time.substring(2, 4);
    String meridian = "AM";
    if (int.parse(hours) < 12) {
      meridian = "AM";
    } else {
      meridian = "PM";
    }

    return "$hours:$minutes $meridian";
  }
}

/* GLOBAL WIDGETS */
// Text Styles - please do not overwrite below code unless you know what you are doing

TextStyle defaultTextStyle(Color color, FontWeight fontWeight,
    {double size = 18, FontStyle fontStyle = FontStyle.normal, String fontFamily = 'Hiragino Kaku Gothic Pro W6'}) {
  return TextStyle(color: color, fontWeight: fontWeight, fontSize: size,fontStyle: fontStyle);
}

// function to check whether the screen is Portrait or Landscape

bool isScreenPortrait(BuildContext context) {
  if (MediaQuery.of(context).orientation == Orientation.landscape) {
    return false;
  } else {
    return true;
  }
}

class Drawhorizontalline extends CustomPainter {
  late Paint _paint;
  bool reverse;

  Drawhorizontalline(this.reverse) {
    _paint = Paint()
      ..color = Colors.white30
      ..strokeWidth = 2
      ..strokeCap = StrokeCap.round;
  }

  @override
  void paint(Canvas canvas, Size size) {
    if (reverse) {
      canvas.drawLine(const Offset(-80.0, 0.0), const Offset(-10.0, 0.0), _paint);
    } else {
      canvas.drawLine(const Offset(10.0, 0.0), const Offset(80.0, 0.0), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
