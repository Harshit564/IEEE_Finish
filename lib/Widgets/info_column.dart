import 'package:flutter/material.dart';

import 'attendance_button.dart';
import 'build_info_boxes.dart';
import 'ind_about_line.dart';
import 'ind_description_label.dart';
import 'ind_host_label.dart';
import 'ind_image_widget.dart';
import 'ind_name_label.dart';

Widget infoListView({
  @required BuildContext context,
  @required String imageUrl,
  @required String name,
  @required String hostName,
  @required String time,
  @required String date,
  @required String location,
  @required String description,
  @required Function attendanceButtonFunction,
}) {
  return ListView(
    children: <Widget>[
      imageWidget(context: context, url: imageUrl),
      indNameLabel(name: name),
      indHostLabel(hostName: hostName),
      SizedBox(
        height: 20,
      ),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          buildInfoBoxes(
            icon: Icon(
              Icons.access_time,
              color: Colors.black,
            ),
            value: time,
          ),
          buildInfoBoxes(
            icon: Icon(
              Icons.date_range,
              color: Colors.black,
            ),
            value: date,
          ),
          buildInfoBoxes(
            icon: Icon(
              Icons.location_on,
              color: Colors.black,
            ),
            value: location,
          ),
          SizedBox(
            height: 20.0,
          ),
          aboutLine(),
          indDescriptionLabel(
            description: description,
          ),
          SizedBox(
            height: 20,
          ),
          attendanceButton(
            function: attendanceButtonFunction,
          ),
        ],
      ),
    ],
  );
}
