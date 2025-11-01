import 'package:betweeener_app/core/util/constants.dart';
import 'package:betweeener_app/views_features/links/edit_link_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class LinkCard extends StatelessWidget {
  final String title;
  final String link;
  final Color color;
  final int idLink;
  final Function()? onDelete;
  final bool isSlidable;
  const LinkCard({
    super.key,
    required this.title,
    required this.link,
    required this.color,
    required this.idLink,
    this.onDelete,
    required this.isSlidable,
  });

  @override
  Widget build(BuildContext context) {
    return isSlidable
        ? Slidable(
            endActionPane: ActionPane(
              motion: const ScrollMotion(),
              extentRatio: 0.4,
              children: [
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 4),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      color: kSecondaryColor,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: IconButton(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        EditLinkView.id,
                        arguments: {
                          'title': title,
                          'link': link,
                          'idLink': idLink,
                        },
                      ),
                      icon: Icon(Icons.edit, color: Colors.white, size: 28),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsetsGeometry.symmetric(horizontal: 4),
                  child: Container(
                    width: 60,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: kDangerColor,
                    ),
                    child: IconButton(
                      onPressed: onDelete,
                      icon: Icon(Icons.delete, color: Colors.white, size: 28),
                    ),
                  ),
                ),
              ],
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 12),
              width: double.infinity,
              height: 60,
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
              decoration: BoxDecoration(
                color: color,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title.toUpperCase(),
                    style: TextStyle(
                      fontSize: 14,
                      letterSpacing: 2,
                      color: color == kLightPrimaryColor
                          ? kPrimaryColor
                          : kRedColor,
                    ),
                  ),
                  Text(
                    link,
                    style: TextStyle(
                      fontSize: 14,
                      color: color == kLightPrimaryColor
                          ? kPrimaryColor.withOpacity(0.5)
                          : kRedColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          )
        : Container(
            margin: const EdgeInsets.symmetric(vertical: 12),
            width: double.infinity,
            height: 60,
            padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title.toUpperCase(),
                  style: TextStyle(
                    fontSize: 14,
                    letterSpacing: 2,
                    color: color == kLightPrimaryColor
                        ? kPrimaryColor
                        : kRedColor,
                  ),
                ),
                Text(
                  link,
                  style: TextStyle(
                    fontSize: 14,
                    color: color == kLightPrimaryColor
                        ? kPrimaryColor.withOpacity(0.5)
                        : kRedColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          );
  }
}