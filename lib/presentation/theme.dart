import 'package:basic_template/basic_template.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:folldy_student/utils/constants.dart';

class AppTheme {
  static setSystemOverlay() {
    if (kIsWeb) return;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
    ));
  }

  static ThemeData get theme => ThemeData.light().copyWith(
      textTheme: GoogleFonts.rubikTextTheme(),
      scaffoldBackgroundColor: athensGrey,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      chipTheme: const ChipThemeData(
          // backgroundColor: frenchGrey,
          selectedColor: fernGreen,
          disabledColor: altoGrey,
          labelStyle: TextStyle(color: Colors.black)),
      platform: TargetPlatform.iOS,
      sliderTheme: const SliderThemeData(
        thumbColor: Colors.red,
        activeTrackColor: Colors.red,
        trackHeight: 2,
        thumbShape:
            RoundSliderThumbShape(enabledThumbRadius: defaultPaddingSmall),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              primary: contessa, shape: const StadiumBorder())),
      appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          iconTheme: IconThemeData(color: Colors.black),
          centerTitle: false,
          backgroundColor: zircon,
          elevation: 0,
          titleTextStyle: TextStyle(fontSize: 20, color: Colors.black)),
      tabBarTheme: const TabBarTheme(
          labelColor: Colors.black, unselectedLabelColor: Colors.grey));
}

List<String> get availableFonts => [
      GoogleFonts.roboto().fontFamily!,
      GoogleFonts.openSans().fontFamily!,
      GoogleFonts.tinos().fontFamily!,
      GoogleFonts.lato().fontFamily!,
      GoogleFonts.montserrat().fontFamily!,
      GoogleFonts.ubuntu().fontFamily!,
      GoogleFonts.poppins().fontFamily!,
      GoogleFonts.raleway().fontFamily!,
      GoogleFonts.notoSans().fontFamily!,
      GoogleFonts.merriweather().fontFamily!,
      GoogleFonts.playfairDisplay().fontFamily!,
      GoogleFonts.lora().fontFamily!,
      GoogleFonts.ptSerif().fontFamily!,
    ];
