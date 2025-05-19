class Validators {
  /// Email
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) return 'Email енгізіңіз';
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value.trim())) return 'Email дұрыс емес';
    return null;
  }

  /// Пароль
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.trim().isEmpty) return 'Құпиясөз енгізіңіз';
    if (value.length < minLength) return 'Құпиясөз кемінде $minLength таңбадан тұруы керек';
    return null;
  }

  /// Подтверждение пароля
  static String? confirmPassword(String? value, String original) {
    if (value == null || value.isEmpty) return 'Қайта енгізіңіз';
    if (value != original) return 'Құпиясөздер сәйкес емес';
    return null;
  }

  /// Обязательное поле
  static String? required(String? value, {String field = 'Бұл өріс'}) {
    if (value == null || value.trim().isEmpty) return '$field бос болмауы керек';
    return null;
  }

  /// Телефон
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) return 'Телефон нөмірін енгізіңіз';
    if (!RegExp(r'^\+?[0-9]{10,15}$').hasMatch(value)) return 'Телефон нөмірі дұрыс емес';
    return null;
  }

  /// ИИН (Казахстан)
  static String? iin(String? value) {
    if (value == null || value.trim().isEmpty) return 'ИИН енгізіңіз';
    if (!RegExp(r'^\d{12}$').hasMatch(value)) return 'ИИН 12 саннан тұруы керек';
    return null;
  }

  /// Только число
  static String? number(String? value) {
    if (value == null || value.trim().isEmpty) return 'Сан енгізіңіз';
    if (double.tryParse(value) == null) return 'Дұрыс емес сан';
    return null;
  }

  /// Минимальная длина
  static String? minLength(String? value, int min, {String field = 'Мәтін'}) {
    if (value == null || value.length < min) return '$field кемінде $min таңба болуы керек';
    return null;
  }

  /// Максимальная длина
  static String? maxLength(String? value, int max, {String field = 'Мәтін'}) {
    if (value != null && value.length > max) return '$field $max таңбадан аспауы керек';
    return null;
  }

  /// Имя/ФИО
  static String? name(String? value, {String field = 'Аты'}) {
    if (value == null || value.trim().isEmpty) return '$field енгізіңіз';
    if (!RegExp(r"^[a-zA-Zа-яА-ЯёЁіІңҢүҮұҰқҚөӨәӘ\s'-]+$").hasMatch(value)) {
      return '$field тек әріптерден тұруы керек';
    }
    return null;
  }

  /// URL
  static String? url(String? value) {
    if (value == null || value.trim().isEmpty) return 'Сілтеме енгізіңіз';
    final uri = Uri.tryParse(value);
    if (uri == null || (!uri.isScheme('http') && !uri.isScheme('https'))) {
      return 'Сілтеме дұрыс емес';
    }
    return null;
  }

  /// Custom замыкание
  static String? Function(String?) custom(bool Function(String?) validatorFn, String errorMessage) {
    return (value) {
      if (!validatorFn(value)) return errorMessage;
      return null;
    };
  }
}