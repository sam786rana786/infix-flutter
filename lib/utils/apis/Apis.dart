class InfixApi {
  static String root = 'https://infixedu.com/android/';
  static String base_api = root + 'api/';

  static String STUDENT_DORMITORY_LIST = base_api + "student-dormitory";

  static String BOOK_LIST = base_api+"book-list";

  static String login(String email, String password) {
    return base_api + 'login?email=' + email + '&password=' + password;
  }

  static String getFeesUrl(int id) {
    return base_api + 'fees-collect-student-wise/$id';
  }

  static String getRoutineUrl(int id) {
    return base_api + "student-class-routine/$id";
  }

  static String getStudenthomeWorksUrl(int id) {
    return base_api + "student-homework/$id";
  }

  static String DRIVER_LIST = base_api + "driver-list";
  static String STUDENT_TRANSPORT_LIST = base_api + "student-transport-report";

  static String getSubjectsUrl(int id) {
    return base_api + "studentSubject/$id";
  }

  static String getStudentTeacherUrl(int id) {
    return base_api + "studentTeacher/$id";
  }

  static String getStudentIssuedBook(int id){
    return base_api+"student-library/$id";
  }

  static String getNoticeUrl(int id){
    return base_api+"student-noticeboard/$id";
  }

   static String getStudentTimeline(int id){
    return base_api+"student-timeline/$id";
  }

}
