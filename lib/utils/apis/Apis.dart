class InfixApi {
  static String root = 'https://infixedu.com/android/';
  static String baseApi = root + 'api/';

  static String uploadHomework = baseApi+"add-homework";

  static String studentDormitoryList = baseApi + "student-dormitory";

  static String bookList = baseApi+"book-list";
  static String adminFeeList = baseApi+"fees-group";

  static String uploadContent = baseApi+"teacher-upload-content";
  static String currentPermission = baseApi+"privacy-permission-status";

  static String login(String email, String password) {
    return baseApi + 'login?email=' + email + '&password=' + password;
  }

  static String getFeesUrl(int id) {
    return baseApi + 'fees-collect-student-wise/$id';
  }

  static String getRoutineUrl(int id) {
    return baseApi + "student-class-routine/$id";
  }

  static String getStudenthomeWorksUrl(int id) {
    return baseApi + "student-homework/$id";
  }

  static String driverList = baseApi + "driver-list";
  static String studentTransportList = baseApi + "student-transport-report";

  static String getSubjectsUrl(int id) {
    return baseApi + "studentSubject/$id";
  }

  static String getStudentTeacherUrl(int id) {
    return baseApi + "studentTeacher/$id";
  }
  static String getTeacherPhonePermission(int mPerm) {
    return baseApi + "privacy-permission/$mPerm";
  }

  static String getStudentIssuedBook(int id){
    return baseApi+"student-library/$id";
  }

  static String getNoticeUrl(int id){
    return baseApi+"student-noticeboard/$id";
  }

   static String getStudentTimeline(int id){
    return baseApi+"student-timeline/$id";
  }

   static String getStudentClassExamName(var id){
    return baseApi+"exam-list/$id";
  }

  static String getStudentClsExamShedule(var id,int code){
    return baseApi+"exam-schedule/$id/$code";
  }

   static String getTeacherAttendence(int id,int month,int year){
    return baseApi+"my-attendance/$id?month=$month&year=$year";
  }

  static String getStudentAttendence(var id,int month,int year){
    return baseApi+"student-my-attendance/$id?month=$month&year=$year";
  }

  static String getStudentOnlineResult(int id,int examId){
    return baseApi+"online-exam-result/$id/$examId";
  }
  static String getStudentClassExamResult(var id,int examId){
    return baseApi+"exam-result/$id/$examId";
  }

  static String getStudentByClass(int mClass){
    return baseApi+"search-student?class=$mClass";
  }
  static String getStudentByName(String name){
    return baseApi+"search-student?name=$name";
  }
  static String getStudentByRoll(String roll){
    return baseApi+"search-student?roll_no=$roll";
  }
  static String getStudentByClassAndSection(int mClass,int mSection){
    return baseApi+"search-student?section=$mSection&class=$mClass";
  }
  static String getSectionById(int id,int classId){
    return baseApi+"teacher-section-list?id=$id&class=$classId";
  }
  static String getClassById(int id){
    return baseApi+"teacher-class-list?id=$id";
  }
   static String getChildren(String id){
    return baseApi+"childInfo/$id";
  }
  static String getTeacherSubject(int id){
    return baseApi+"subject/$id";
  }
  static String getTeacherMyRoutine(int id){
    return baseApi+"my-routine/$id";
  }
  static String getRoutineByClassAndSection(int id,int mClass,int mSection){
    return baseApi+"section-routine/$id/$mClass/$mSection";
  }
  static String getAllContent(){
    return baseApi+"content-list";
  }
  static String deleteContent(int id){
    return baseApi+"delete-content/$id";
  }
  static String attendanceDataSend(String id,String atten,String date,String mClass,String mSection){
    return baseApi+"student-attendance-store-second?id="+id+"&attendance="+atten+"&date="+date+"&class="+mClass+"&section="+mSection;
  }
  static String attendanceDefaultSent(String date,String mClass,String mSection){
    return baseApi+"student-attendance-store-first?date="+date+"&class="+mClass+"&section="+mSection;
  }
  static String attendanceCheck(String date,String mClass,String mSection){
    return baseApi+"student-attendance-check?date="+date+"&class="+mClass+"&section="+mSection;
  }
  static String studentFeePayment(String stuId,int feesType,String amount,String paidBy,String paymentMethod){
    return baseApi+"student-fees-payment?student_id=$stuId&fees_type_id=$feesType&amount=$amount&paid_by=$paidBy&payment_mode=C";
  }
  static String about = baseApi+"parent-about";

   static String getHomeWorkListUrl(int id){
    return baseApi+"homework-list/$id";
  }
  static String getLeaveList(int id){
    return baseApi+"staff-apply-list/$id";
  }
  static String getParentChildList(String id){
    return baseApi+"child-list/$id";
  }
  static String getStudentOnlineActiveExam(var id){
    return baseApi+"student-online-exam/$id";
  }
  static String getStudentOnlineActiveExamName(var id){
    return baseApi+"choose-exam/$id";
  }
  static String getStudentOnlineActiveExamResult(var id,var examId){
    return baseApi+"online-exam-result/$id/$examId";
  }

  static String feesDataSend(String name,String description){
    return baseApi+"fees-group-store?name="+name+"&description="+description;
  }
  static String feesDataUpdate(String name,String description,int id){
    return baseApi+"fees-group-update?name="+name+"&description="+description+"&id=$id";
  }

  static String addBook(String title,String categoryId,String bookNo, String isbn,String publisherName,String authorName,String subjectId,String reckNo,String quantity,String price,String details,String date,String userId){
    return baseApi+"save-book-data?book_title="+title+"&book_category_id="+categoryId+"&book_number="+bookNo+"&isbn_no="+isbn+"&publisher_name="+
        publisherName+"&author_name="+authorName+"&subject_id="+subjectId+"&rack_number="+reckNo+"&quantity="+quantity+"&book_price="+price+"&details="+details+"&post_date="+date+"&user_id=$userId";

  }

  static String bookCategory = baseApi+"book-category";
  static String subjectList = baseApi+"subject";
  static String leaveType = baseApi+"staff-leave-type";
  static String applyLeave = baseApi+"staff-apply-leave";
  static String getEmail = baseApi+"user-demo";
  static String getLibraryMemberCategory = baseApi+"library-member-role";
}
