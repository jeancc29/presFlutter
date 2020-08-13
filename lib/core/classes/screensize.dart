class ScreenSize{
  static final double sm = 400;
  static final double md = 700;
  static final double lg = 1000;
  static final double xlg = 1300;

  static isSmall(double size){
    return size <= sm;
  }

  static isMedium(double size){
    return  size > sm && size <= md;
  }

  static isLarge(double size){
    return  size > md && size <= lg;
  }

  static isXLarge(double size){
    return  size > lg && size <= xlg;
  }
}