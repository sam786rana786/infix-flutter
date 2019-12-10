class InfixApi {
  static String root = 'https://infixedu.com/android/';
  static String base_api = root + 'api/';

  static String login(String email, String password) {
    return base_api + 'login?email=' + email + '&password=' + password;
  }

  static String getFeesUrl(int id) {
    return base_api + 'fees-collect-student-wise/$id';
  }

   static String getRoutineUrl(int id){
    return base_api+"student-class-routine/$id";
  }
   static String getStudenthomeWorksUrl(int id){
    return base_api+"student-homework/$id";
  }

}
