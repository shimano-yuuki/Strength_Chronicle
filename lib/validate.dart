class ValidateText {
  static ValidateText validate = ValidateText();
  static String? email(String? value) {
    if(value != null){
      String pattern = r'^[0-9a-z_./?-]+@([0-9a-z-]+\.)+[0-9a-z-]+$';
      RegExp regExp = RegExp(pattern);
      if(!regExp.hasMatch(value)){
        return '正しいメールアドレスを入力してください';
      }
    }
    return null;
  }

  static String? password(String? value) {
    if(value != null){
      const pattern = r'^[a-zA-Z0-9]{8,}$';
      final regExp = RegExp(pattern);
      if(!regExp.hasMatch(value)){
        return '8文字以上の英数字を入力してください';
      }
    }
    return null;
  }
}