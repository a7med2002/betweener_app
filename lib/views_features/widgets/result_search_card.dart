import 'package:betweeener_app/core/util/constants.dart';
import 'package:flutter/material.dart';

class ResultSearchCard extends StatelessWidget {
  final String name;
  final String email;
  final Function()? ontap;
  const ResultSearchCard({super.key, required this.name, required this.email, required this.ontap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        color: kLightSecondaryColor,
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: kPrimaryColor,
                child: Text(
                  name[0].toUpperCase(),
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: kPrimaryColor,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      email,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                    ),
                  ],
                ),
              ),
              Icon(Icons.arrow_forward_ios, color: kRedColor, size: 18),
            ],
          ),
        ),
      ),
    );
  }
}
