import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        'ar': {
          'lgn': 'تسجيل الدخول',
          'sgn': 'انشاء حساب',
          'docorbi1': 'طبيب',
          'docorbi2': 'موظف',
          'email': 'البريد الالكتروني',
          'password': 'الكلمة السرية',
          'phone': 'رقم الهاتف',
          'idn': 'الرقم القومي',
          'name': 'الاسم بالكامل',
          'do you': 'هل تمتلك حساب بالفعل ؟',
          'mesg': 'الرسائل',
          'rep': 'التقارير',
          'spec': 'التخصص',
          'prof': 'الحساب الشخصي'
        },
        'en': {
          'lgn': 'login',
          'sgn': 'sign up',
          'docorbi1': 'doctor',
          'docorbi2': 'empeloyee',
          'email': 'email',
          'password': 'password',
          'phone': 'phone number',
          'idn': 'ID Number',
          'name': 'username',
          'do you': 'do you have an account ?',
          'mesg': 'Messages',
          'rep': 'Reports',
          'spec': 'specialty',
          'prof': 'profile'
        }
      };
}
