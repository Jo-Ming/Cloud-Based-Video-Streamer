import 'package:flutter/material.dart';
import '../Models/Course.dart';
import '../Screens/course_display.dart';
import '../Screens/purchase_course.dart';

class CourseTile extends StatelessWidget {
  final Course course;
  final bool isPurchased;

  const CourseTile({required this.course, required this.isPurchased});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context),
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(course.thumbnail),
                ),
              ),
            ),
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        course.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      isPurchased
                          ? Icon(Icons.check_circle, color: Colors.green)
                          : Icon(Icons.add_shopping_cart, color: Colors.blue),
                    ],
                  ),
                  SizedBox(height: 5),
                  Text(
                    course.description,
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Time: ${course.time}",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    "Price: ${course.price}",
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onTap(BuildContext context) {
    if (isPurchased) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => CourseDisplayPage(course: course),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => PurchaseCoursePage(course: course),
        ),
      );
    }
  }
}
