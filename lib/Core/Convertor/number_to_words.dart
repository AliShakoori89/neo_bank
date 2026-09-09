// Core/Utils/number_to_words.dart
class NumberToWords {
  static const List<String> _units = [
    '', 'یک', 'دو', 'سه', 'چهار', 'پنج', 'شش', 'هفت', 'هشت', 'نه'
  ];

  static const List<String> _teens = [
    'ده', 'یازده', 'دوازده', 'سیزده', 'چهارده', 'پانزده',
    'شانزده', 'هفده', 'هجده', 'نوزده'
  ];

  static const List<String> _tens = [
    '', '', 'بیست', 'سی', 'چهل', 'پنجاه', 'شصت', 'هفتاد', 'هشتاد', 'نود'
  ];

  static const List<String> _thousands = [
    '', 'هزار', 'میلیون', 'میلیارد', 'بیلیون', 'بیلیارد', 'تریلیون'
  ];

  static String convert(int number) {
    if (number == 0) return 'صفر';
    if (number < 0) return 'منفی ${convert(-number)}';

    String result = '';
    int index = 0;

    while (number > 0) {
      int remainder = number % 1000;
      if (remainder != 0) {
        String segment = _convertSegment(remainder);
        if (_thousands[index].isNotEmpty) {
          segment += ' ${_thousands[index]}';
        }
        result = segment + (result.isNotEmpty ? ' و $result' : result);
      }
      number ~/= 1000;
      index++;
    }

    return '$result تومان';
  }

  static String _convertSegment(int number) {
    if (number == 0) return '';

    String result = '';

    int hundred = number ~/ 100;
    if (hundred > 0) {
      result += '${_units[hundred]} صد';
      number %= 100;
      if (number > 0) result += ' و ';
    }

    if (number >= 10 && number <= 19) {
      result += _teens[number - 10];
    } else {
      int ten = number ~/ 10;
      if (ten > 0) {
        result += _tens[ten];
        number %= 10;
        if (number > 0) result += ' و ';
      }

      if (number > 0) {
        result += _units[number];
      }
    }

    return result;
  }
}