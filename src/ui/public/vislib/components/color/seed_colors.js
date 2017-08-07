define(function () {
  /*
   * Using a random color generator presented awful colors and unpredictable color schemes.
   * So we needed to come up with a color scheme of our own that creates consistent, pleasing color patterns.
   * The order allows us to guarantee that 1st, 2nd, 3rd, etc values always get the same color.
   * Returns an array of 72 colors.
   */

  return function SeedColorUtilService() {
    return [
        '#bdbdbd',
        '#78909c',
        '#757575',
        '#546e7a',
        '#424242',
        '#37474f',
        '#2c3e50'
    ];
  };
});