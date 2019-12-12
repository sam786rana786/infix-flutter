import 'dart:io';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:file_utils/file_utils.dart';
import 'package:infixedu/utils/FunctinsData.dart';
import 'package:infixedu/utils/Utils.dart';
import 'package:flutter/material.dart';
import 'package:infixedu/utils/apis/Apis.dart';
import 'package:infixedu/utils/modal/StudentHomework.dart';
import 'package:path_provider/path_provider.dart';
import 'package:simple_permissions/simple_permissions.dart';

class Student_homework_row extends StatelessWidget {
  Homework homework;

  Student_homework_row(this.homework);

  Permission permission1 = Permission.WriteExternalStorage;
  Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Text(
                    homework.subjectName,
                    style: Theme.of(context)
                        .textTheme
                        .title
                        .copyWith(fontSize: 15.0),
                    maxLines: 1,
                  ),
                ),
                Container(
                  width: 80.0,
                  child: GestureDetector(
                    onTap: () {
                      showDownloadAlertDialog(context);
                    },
                    child: Text(
                      'download',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.deepPurpleAccent,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
                Container(
                  width: 80.0,
                  child: GestureDetector(
                    onTap: () {
                      showAlertDialog(context);
                    },
                    child: Text(
                      'view',
                      textAlign: TextAlign.end,
                      style: Theme.of(context).textTheme.title.copyWith(
                          color: Colors.deepPurpleAccent,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Created',
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          homework.homeworkDate == null
                              ? 'not assigned'
                              : homework.homeworkDate,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Submission',
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          homework.submissionDate == null
                              ? 'not assigned'
                              : homework.submissionDate,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Evaluation',
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          homework.evaluationDate == null
                              ? 'not assigned'
                              : homework.evaluationDate,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.display1,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Status',
                          maxLines: 1,
                          style: Theme.of(context)
                              .textTheme
                              .display1
                              .copyWith(fontWeight: FontWeight.w500),
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                        getStatus(context, homework.status),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 0.5,
              margin: EdgeInsets.only(top: 10.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerRight,
                    end: Alignment.centerLeft,
                    colors: [Colors.purple, Colors.deepPurple]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    showDialog<void>(
      barrierDismissible: true,
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(0),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: Text(
                              homework.subjectName,
                              style: Theme.of(context).textTheme.headline,
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Created',
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    homework.homeworkDate,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.display1,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Submission',
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    homework.submissionDate,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.display1,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Evaluation',
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  Text(
                                    homework.evaluationDate,
                                    maxLines: 1,
                                    style: Theme.of(context).textTheme.display1,
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    'Status',
                                    maxLines: 1,
                                    style: Theme.of(context)
                                        .textTheme
                                        .display1
                                        .copyWith(fontWeight: FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 10.0,
                                  ),
                                  getStatus(context, homework.status),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              homework.description,
                              maxLines: 10,
                              style: Theme.of(context).textTheme.display1,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        );
      },
    );
  }

  Widget getStatus(BuildContext context, String status) {
    if (status == 'I') {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.redAccent),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Text(
            'Incomplete',
            textAlign: TextAlign.center,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
    if (status == 'C') {
      return Container(
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(color: Colors.greenAccent),
        child: Padding(
          padding: const EdgeInsets.only(left: 5.0, right: 5.0),
          child: Text(
            'Completed',
            textAlign: TextAlign.center,
            maxLines: 1,
            style: Theme.of(context)
                .textTheme
                .display1
                .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
      );
    }
  }

  showDownloadAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("no"),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );
    Widget yesButton = FlatButton(
      child: Text("download"),
      onPressed: () {
        homework.fileUrl != null
            ? downloadFile(homework.fileUrl)
            : Utils.showToast('no file found');
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(
        "Download",
        style: Theme.of(context).textTheme.headline,
      ),
      content: Text("Would you like to download the file?"),
      actions: [
        cancelButton,
        yesButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> downloadFile(String url) async {
    bool downloading = false;
    var progress = "";
    var path = "No Data";
    var platformVersion = "Unknown";
    Dio dio = Dio();
    bool checkPermission1 =
        await SimplePermissions.checkPermission(permission1);
    // print(checkPermission1);
    if (checkPermission1 == false) {
      await SimplePermissions.requestPermission(permission1);
      checkPermission1 = await SimplePermissions.checkPermission(permission1);
    }
    if (checkPermission1 == true) {
      String dirloc = "";
      if (Platform.isAndroid) {
        dirloc = "/sdcard/download/";
      } else {
        dirloc = (await getApplicationDocumentsDirectory()).path;
      }

      var randid = random.nextInt(10000);

      try {
        FileUtils.mkdir([dirloc]);

        await dio
            .download(InfixApi.root + url, dirloc + AppFunction.getExtention(url),
                onReceiveProgress: (receivedBytes, totalBytes) {
          downloading = true;
          progress =
              ((receivedBytes / totalBytes) * 100).toStringAsFixed(0) + "%";
        });
      } catch (e) {
        print(e);
      }
      progress = "Download Completed.Go to the download folder to find the file";
      Utils.showToast(progress);
    } else {
      progress = "Permission Denied!";
    }
  }
}
