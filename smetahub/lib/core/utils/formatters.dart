import 'package:flutter/services.dart';

// class NumberTextInputFormatter extends TextInputFormatter {
//   @override
//   TextEditingValue formatEditUpdate(
//     TextEditingValue oldValue,
//     TextEditingValue newValue,
//   ) {
//     // Check if we're deleting text
//     bool isDeleting = newValue.text.length < oldValue.text.length;

//     // Get only digits from the input
//     String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

//     // If deleting and no digits left, return empty
//     if (isDeleting && digitsOnly.isEmpty) {
//       return const TextEditingValue(
//           text: '', selection: TextSelection.collapsed(offset: 0));
//     }

//     // Format the digits
//     return _formatDigits(digitsOnly);
//   }

//   // Helper method to format digits with proper spacing
//   TextEditingValue _formatDigits(String digits) {
//     if (digits.isEmpty) {
//       return const TextEditingValue(
//           text: '', selection: TextSelection.collapsed(offset: 0));
//     }

//     // Start with empty buffer
//     final StringBuffer formattedText = StringBuffer();

//     // Format in groups of 3-3-2-2
//     for (int i = 0; i < digits.length; i++) {
//       // Add spaces after specific positions

//       if (i == 3 || i == 6 || i == 8) {
//         formattedText.write(' ');
//       }

//       // Add the digit
//       formattedText.write(digits[i]);
//     }

//     return TextEditingValue(
//       text: formattedText.toString(),
//       selection: TextSelection.collapsed(offset: formattedText.length),
//     );
//   }
// }

class NumberTextInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Check if we're deleting text
    bool isDeleting = newValue.text.length < oldValue.text.length;

    // Get only digits from the input
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    // If we're accepting input from scratch, prefix with 7
    if (digitsOnly.isNotEmpty && !digitsOnly.startsWith('7')) {
      digitsOnly = '7' + digitsOnly;
    }

    // If deleting and no digits left, return empty
    if (isDeleting && digitsOnly.isEmpty) {
      return const TextEditingValue(
          text: '', selection: TextSelection.collapsed(offset: 0));
    }

    // Format the digits
    return _formatDigits(digitsOnly);
  }

  // Helper method to format digits with proper spacing
  TextEditingValue _formatDigits(String digits) {
    if (digits.isEmpty) {
      return const TextEditingValue(
          text: '', selection: TextSelection.collapsed(offset: 0));
    }

    // Start with empty buffer
    final StringBuffer formattedText = StringBuffer('+');

    // Format in groups: +7 XXX XXX XX XX
    for (int i = 0; i < digits.length; i++) {
      // Add spaces after specific positions
      if (i == 1 || i == 4 || i == 7 || i == 9) {
        formattedText.write(' ');
      }

      // Add the digit
      formattedText.write(digits[i]);
    }

    return TextEditingValue(
      text: formattedText.toString(),
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
