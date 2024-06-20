import 'package:flutter/painting.dart';
import 'dart:math' as math;

class ColorUtils {
  static Color hslToColor(double hue, double saturation, double lightness) {
    double chroma = (1 - (2 * lightness - 1).abs()) * saturation;
    double x = chroma * (1 - ((hue / 60) % 2 - 1).abs());
    double m = lightness - chroma / 2;

    double r = 0, g = 0, b = 0;

    if (0 <= hue && hue < 60) {
      r = chroma;
      g = x;
      b = 0;
    } else if (60 <= hue && hue < 120) {
      r = x;
      g = chroma;
      b = 0;
    } else if (120 <= hue && hue < 180) {
      r = 0;
      g = chroma;
      b = x;
    } else if (180 <= hue && hue < 240) {
      r = 0;
      g = x;
      b = chroma;
    } else if (240 <= hue && hue < 300) {
      r = x;
      g = 0;
      b = chroma;
    } else if (300 <= hue && hue < 360) {
      r = chroma;
      g = 0;
      b = x;
    }

    return Color.fromARGB(
      255,
      ((r + m) * 255).round(),
      ((g + m) * 255).round(),
      ((b + m) * 255).round(),
    );
  }

  static Set<Color> generateLinearColors(int n) {
    Set<Color> colors = {};
    double hueStep = 360 / n; // Divide the color wheel into n steps

    for (int i = 0; i < n; i++) {
      double hue = i * hueStep;
      colors.add(
        hslToColor(
          hue,
          1.0,
          0.5,
        ),
      ); // Full saturation and 50% lightness for bright colors
    }

    return colors;
  }

  static List<double> rgbToHsl(Color color) {
    final r = color.red / 255;
    final g = color.green / 255;
    final b = color.blue / 255;

    final max = [r, g, b].reduce(math.max);
    final min = [r, g, b].reduce(math.min);
    final delta = max - min;

    double hue = 0.0;
    double saturation = 0.0;
    double lightness = (max + min) / 2;

    if (delta != 0) {
      saturation =
          lightness < 0.5 ? delta / (max + min) : delta / (2 - max - min);

      if (max == r) {
        hue = ((g - b) / delta + (g < b ? 6 : 0)) * 60;
      } else if (max == g) {
        hue = ((b - r) / delta + 2) * 60;
      } else if (max == b) {
        hue = ((r - g) / delta + 4) * 60;
      }
    }

    return [hue, saturation, lightness];
  }

  static Set<Color> generateShadesOfColor(Color baseColor, int n) {
    List<double> hsl = rgbToHsl(baseColor);
    double hue = hsl[0];
    double saturation = hsl[1];
    double baseLightness = hsl[2];

    Set<Color> shades = {};
    double startLightness =math.max(0.1, baseLightness - 0.4); // Ensure it doesn't go below 0.1
    double endLightness = math.min(0.9, baseLightness + 0.4);   // Ensure it doesn't go above 0.9

    for (int i = 0; i < n; i++) {
      double t = i / (n - 1);
      double newLightness = startLightness + (endLightness - startLightness) * t * t;
      shades.add(hslToColor(hue, saturation, newLightness));
    }

    return shades;
  }
}
