class InfixApi {
  static String root = 'https://infixedu.com/android/';
  static String base_api = root + 'api/';

  static String UPLOAD_HOMEWORK = base_api+"add-homework";

  static String STUDENT_DORMITORY_LIST = base_api + "student-dormitory";

  static String BOOK_LIST = base_api+"book-list";

  static String UPLOAD_CONTENT = base_api+"teacher-upload-content";

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

   static String getStudentClassExamName(int id){
    return base_api+"exam-list/$id";
  }

  static String getStudentClsExamShedule(int id,int code){
    return base_api+"exam-schedule/$id/$code";
  }

   static String getTeacherAttendence(int id,int month,int year){
    return base_api+"my-attendance/$id?month=$month&year=$year";
  }

  static String getStudentAttendence(int id,int month,int year){
    return base_api+"student-my-attendance/$id?month=$month&year=$year";
  }

  static String getStudentOnlineResult(int id,int exam_id){
    return base_api+"online-exam-result/$id/$exam_id";
  }
  static String getStudentClassExamResult(int id,int exam_id){
    return base_api+"exam-result/$id/$exam_id";
  }

  static String getStudentByClass(int mClass){
    return base_api+"search-student?class=$mClass";
  }
  static String getStudentByName(String name){
    return base_api+"search-student?name=$name";
  }
  static String getStudentByRoll(String roll){
    return base_api+"search-student?roll_no=$roll";
  }
  static String getStudentByClassAndSection(int mClass,int mSection){
    return base_api+"search-student?section=$mSection&class=$mClass";
  }
  static String getSectionById(int id,int classId){
    return base_api+"teacher-section-list?id=$id&class=$classId";
  }
  static String getClassById(int id){
    return base_api+"teacher-class-list?id=$id";
  }
   static String getChildren(String id){
    return base_api+"childInfo/$id";
  }
  static String getTeacherSubject(int id){
    return base_api+"subject/$id";
  }
  static String getTeacherMyRoutine(int id){
    return base_api+"my-routine/$id";
  }
  static String getRoutineByClassAndSection(int id,int mClass,int mSection){
    return base_api+"section-routine/$id/$mClass/$mSection";
  }
  static String getAllContent(){
    return base_api+"content-list";
  }
  static String deleteContent(int id){
    return base_api+"delete-content/$id";
  }
  static String attendance_data_send(String id,String atten,String date,String mClass,String mSection){
    return base_api+"student-attendance-store-second?id="+id+"&attendance="+atten+"&date="+date+"&class="+mClass+"&section="+mSection;
  }
  static String attendance_defalut_send(String date,String mClass,String mSection){
    return base_api+"student-attendance-store-first?date="+date+"&class="+mClass+"&section="+mSection;
  }
  static String attendance_check(String date,String mClass,String mSection){
    return base_api+"student-attendance-check?date="+date+"&class="+mClass+"&section="+mSection;
  }
  static String ABOUT = base_api+"parent-about";

   static String getHomeWorkListUrl(int id){
    return base_api+"homework-list/$id";
  }
  static String getLeaveList(int id){
    return base_api+"staff-apply-list/$id";
  }
  static String getParentChildList(String id){
    return base_api+"child-list/$id";
  }
  static String leaveType = base_api+"staff-leave-type";
  static String applyLeave = base_api+"staff-apply-leave";
  static String getEmail = base_api+"user-demo";
}
