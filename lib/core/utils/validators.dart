class Validators {
  // Email validator
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }

    return null;
  }

  // Password validator
  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one lowercase letter
    if (!value.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter';
    }

    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    return null;
  }

  // Confirm password validator
  static String? Function(String?) confirmPassword(String password) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Please confirm your password';
      }

      if (value != password) {
        return 'Passwords do not match';
      }

      return null;
    };
  }

  // Required field validator
  static String? required(String? value, [String fieldName = 'This field']) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  // Age validator
  static String? age(String? value) {
    if (value == null || value.isEmpty) {
      return 'Age is required';
    }

    final age = int.tryParse(value);
    if (age == null) {
      return 'Enter a valid age';
    }

    if (age < 13) {
      return 'You must be at least 13 years old';
    }

    if (age > 120) {
      return 'Please enter a valid age';
    }

    return null;
  }

  // Weight validator (in kg or lbs)
  static String? weight(String? value, {bool isMetric = true}) {
    if (value == null || value.isEmpty) {
      return null; // Weight is optional
    }

    final weight = double.tryParse(value);
    if (weight == null) {
      return 'Enter a valid weight';
    }

    if (isMetric) {
      if (weight < 20 || weight > 300) {
        return 'Enter a weight between 20-300 kg';
      }
    } else {
      if (weight < 44 || weight > 661) {
        return 'Enter a weight between 44-661 lbs';
      }
    }

    return null;
  }

  // Height validator (in cm or inches)
  static String? height(String? value, {bool isMetric = true}) {
    if (value == null || value.isEmpty) {
      return null; // Height is optional
    }

    final height = double.tryParse(value);
    if (height == null) {
      return 'Enter a valid height';
    }

    if (isMetric) {
      if (height < 100 || height > 250) {
        return 'Enter a height between 100-250 cm';
      }
    } else {
      if (height < 39 || height > 98) {
        return 'Enter a height between 39-98 inches';
      }
    }

    return null;
  }

  // Reps validator
  static String? reps(String? value) {
    if (value == null || value.isEmpty) {
      return 'Reps are required';
    }

    final reps = int.tryParse(value);
    if (reps == null) {
      return 'Enter a valid number';
    }

    if (reps < 1 || reps > 100) {
      return 'Enter reps between 1-100';
    }

    return null;
  }

  // Sets validator
  static String? sets(String? value) {
    if (value == null || value.isEmpty) {
      return 'Sets are required';
    }

    final sets = int.tryParse(value);
    if (sets == null) {
      return 'Enter a valid number';
    }

    if (sets < 1 || sets > 20) {
      return 'Enter sets between 1-20';
    }

    return null;
  }

  // Exercise weight validator
  static String? exerciseWeight(String? value, {bool isMetric = true}) {
    if (value == null || value.isEmpty) {
      return 'Weight is required';
    }

    final weight = double.tryParse(value);
    if (weight == null) {
      return 'Enter a valid weight';
    }

    if (weight < 0) {
      return 'Weight cannot be negative';
    }

    if (isMetric) {
      if (weight > 500) {
        return 'Maximum weight is 500 kg';
      }
    } else {
      if (weight > 1102) {
        return 'Maximum weight is 1102 lbs';
      }
    }

    return null;
  }

  // Min/Max length validators
  static String? minLength(
    String? value,
    int minLength, [
    String fieldName = 'Field',
  ]) {
    if (value == null || value.length < minLength) {
      return '$fieldName must be at least $minLength characters';
    }
    return null;
  }

  static String? maxLength(
    String? value,
    int maxLength, [
    String fieldName = 'Field',
  ]) {
    if (value != null && value.length > maxLength) {
      return '$fieldName must be less than $maxLength characters';
    }
    return null;
  }
}
