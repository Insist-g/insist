import 'package:flutter/material.dart';
import 'dart:math';

class Iconfont {
  static const String _family = 'Iconfont';

  // iconName: share
  static const share = IconData(
    0xe60d,
    fontFamily: _family,
    matchTextDirection: true,
  );

  // iconName: fav
  static const fav = IconData(
    0xe60c,
    fontFamily: _family,
    matchTextDirection: true,
  );

  // iconName: social-linkedin
  static const sociallinkedin = IconData(
    0xe605,
    fontFamily: _family,
    matchTextDirection: true,
  );

  // iconName: social-apple
  static const socialapple = IconData(
    0xe606,
    fontFamily: _family,
    matchTextDirection: true,
  );

  // iconName: social-octocat
  static const socialoctocat = IconData(
    0xe607,
    fontFamily: _family,
    matchTextDirection: true,
  );

  // iconName: social-reddit
  static const socialreddit = IconData(
    0xe608,
    fontFamily: _family,
    matchTextDirection: true,
  );

  // iconName: social-snapchat
  static const socialsnapchat = IconData(
    0xe609,
    fontFamily: _family,
    matchTextDirection: true,
  );

  // iconName: social-skype
  static const socialskype = IconData(
    0xe60a,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );

  // iconName: social-twitter
  static const socialtwitter = IconData(
    0xe60b,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );

  // iconName: me
  static const me = IconData(
    0xe604,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );

  // iconName: tag
  static const tag = IconData(
    0xe603,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );

  // iconName: grid
  static const grid = IconData(
    0xe602,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );

  // iconName: home
  static const home = IconData(
    0xe601,
    fontFamily: 'Iconfont',
    matchTextDirection: true,
  );
}

class AlIcon {
  static const String _family = 'alIcons';
  static const IconData pig_chroma = IconData(0xe618, fontFamily: _family);
  static const IconData pig_black = IconData(0xe611, fontFamily: _family);
  static const IconData xy = IconData(0xe600, fontFamily: _family);
  static const IconData pxx = IconData(0xe602, fontFamily: _family);
  static const IconData kg = IconData(0xe601, fontFamily: _family);
  static const IconData logo = IconData(0xe661, fontFamily: _family);
}

class WeatherIcon {
  static const String _family = 'weatherIcons';
  static const IconData weather1 = IconData(0xe619, fontFamily: _family);
  static const IconData weather2 = IconData(0xe61a, fontFamily: _family);
  static const IconData weather3 = IconData(0xe61b, fontFamily: _family);
  static const IconData weather4 = IconData(0xe61c, fontFamily: _family);
  static const IconData weather5 = IconData(0xe61d, fontFamily: _family);
  static const IconData weather6 = IconData(0xe61e, fontFamily: _family);
  static const IconData weather7 = IconData(0xe61f, fontFamily: _family);
  static const IconData weather8 = IconData(0xe620, fontFamily: _family);
  static const IconData weather9 = IconData(0xe621, fontFamily: _family);
  static const IconData weather10 = IconData(0xe622, fontFamily: _family);
  static const IconData weather11 = IconData(0xe623, fontFamily: _family);
  static const IconData weather12 = IconData(0xe624, fontFamily: _family);
  static const IconData weather13 = IconData(0xe625, fontFamily: _family);
  static const IconData weather14 = IconData(0xe626, fontFamily: _family);
  static const IconData weather15 = IconData(0xe626, fontFamily: _family);
  static const IconData weather16 = IconData(0xe628, fontFamily: _family);
  static const IconData weather17 = IconData(0xe629, fontFamily: _family);
  static const IconData weather18 = IconData(0xe62a, fontFamily: _family);
  static const IconData weather19 = IconData(0xe62b, fontFamily: _family);
  static const IconData weather20 = IconData(0xe62c, fontFamily: _family);
  static const IconData weather21 = IconData(0xe62d, fontFamily: _family);
  static const IconData weather22 = IconData(0xe62e, fontFamily: _family);
  static const IconData weather23 = IconData(0xe62f, fontFamily: _family);
  static const IconData weather24 = IconData(0xe630, fontFamily: _family);

  static const list = [
    weather1,
    weather2,
    weather3,
    weather4,
    weather5,
    weather6,
    weather7,
    weather8,
    weather9,
    weather10,
    weather11,
    weather12,
    weather13,
    weather14,
    weather15,
    weather16,
    weather17,
    weather18,
    weather19,
    weather20,
    weather21,
    weather22,
    weather23,
    weather24,
  ];

  static getRandomIcon() {
    return list[Random().nextInt(list.length - 1)];
  }
}

class UnitIcon {
  static const String _family = 'unitIcons';
  static const IconData unit1 = IconData(0xe702, fontFamily: _family);
  static const IconData unit2 = IconData(0xe703, fontFamily: _family);
  static const IconData unit3 = IconData(0xe704, fontFamily: _family);
  static const IconData unit4 = IconData(0xe705, fontFamily: _family);
  static const IconData unit5 = IconData(0xe706, fontFamily: _family);
  static const IconData unit6 = IconData(0xe706, fontFamily: _family);
  static const IconData unit7 = IconData(0xe707, fontFamily: _family);
  static const IconData unit8 = IconData(0xe708, fontFamily: _family);
  static const IconData unit9 = IconData(0xe709, fontFamily: _family);
  static const IconData unit10 = IconData(0xe70a, fontFamily: _family);
  static const IconData unit11 = IconData(0xe70b, fontFamily: _family);
  static const IconData unit12 = IconData(0xe70c, fontFamily: _family);
  static const IconData unit13 = IconData(0xe70d, fontFamily: _family);
  static const IconData unit14 = IconData(0xe70e, fontFamily: _family);
  static const IconData unit15 = IconData(0xe70f, fontFamily: _family);
  static const IconData unit16 = IconData(0xe710, fontFamily: _family);
  static const IconData unit17 = IconData(0xe711, fontFamily: _family);
  static const IconData unit18 = IconData(0xe712, fontFamily: _family);
  static const IconData unit19 = IconData(0xe713, fontFamily: _family);
  static const IconData unit20 = IconData(0xe714, fontFamily: _family);
  static const IconData unit21 = IconData(0xe715, fontFamily: _family);
  static const IconData unit22 = IconData(0xe716, fontFamily: _family);
  static const IconData unit23 = IconData(0xe717, fontFamily: _family);
  static const IconData unit24 = IconData(0xe724, fontFamily: _family);
  static const IconData unit25 = IconData(0xe718, fontFamily: _family);
  static const IconData unit26 = IconData(0xe719, fontFamily: _family);
  static const IconData unit27 = IconData(0xe71a, fontFamily: _family);
  static const IconData unit28 = IconData(0xe71b, fontFamily: _family);
  static const IconData unit29 = IconData(0xe71c, fontFamily: _family);
  static const IconData unit30 = IconData(0xe71d, fontFamily: _family);
  static const IconData unit31 = IconData(0xe71e, fontFamily: _family);
  static const IconData unit32 = IconData(0xe71f, fontFamily: _family);
  static const IconData unit33 = IconData(0xe720, fontFamily: _family);
  static const IconData unit34 = IconData(0xe721, fontFamily: _family);
  static const IconData unit35 = IconData(0xe722, fontFamily: _family);
  static const IconData unit36 = IconData(0xe723, fontFamily: _family);

  static const list = [
    unit1,
    unit2,
    unit3,
    unit4,
    unit5,
    unit6,
    unit7,
    unit8,
    unit9,
    unit10,
    unit11,
    unit12,
    unit13,
    unit14,
    unit15,
    unit16,
    unit17,
    unit18,
    unit19,
    unit20,
    unit21,
    unit22,
    unit23,
    unit24,
    unit25,
    unit26,
    unit27,
    unit28,
    unit29,
    unit30,
    unit31,
    unit32,
    unit33,
    unit34,
    unit35,
    unit36,
  ];

  static getUnitIcon() {
    return list[Random().nextInt(list.length - 1)];
  }

  static List<IconData> getUnitIcons() {
    List<IconData> res = List.from(list);
    res.shuffle();
    return res.sublist(0, 8);
  }
}
