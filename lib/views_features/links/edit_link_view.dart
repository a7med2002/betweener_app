import 'package:betweeener_app/providers/link_provider.dart';
import 'package:betweeener_app/views_features/widgets/custom_text_form_field.dart';
import 'package:betweeener_app/views_features/widgets/secondary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditLinkView extends StatelessWidget {
  static String id = "/editLink";
  EditLinkView({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController linkController = TextEditingController();

  late int idLink;

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;

    titleController.text = args['title']!;
    linkController.text = args['link']!;
    idLink = args['idLink']!;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Link"),
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios),
        ),
      ),
      body: Padding(
        padding: EdgeInsetsGeometry.all(24),
        child: Form(
          key: _key,
          child: Column(
            spacing: 16,
            children: [
              CustomTextFormField(
                label: "Title",
                hint: "Example",
                controller: titleController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "title can't be empty";
                  }
                  return null;
                },
              ),
              CustomTextFormField(
                label: "Link",
                hint: "https://www.Example.com",
                controller: linkController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "link can't be empty";
                  }
                  return null;
                },
              ),
              SizedBox(height: 8),
              SecondaryButtonWidget(
                onTap: () async {
                  if (_key.currentState!.validate()) {
                    final body = {
                      'title': titleController.text,
                      'link': linkController.text,
                    };
                    try {
                      await Provider.of<LinkProvider>(
                        context,
                        listen: false,
                      ).updateLinkList(body, idLink);
                      Navigator.pop(context);
                    } catch (e) {
                      print("Error: ${e.toString()}");
                    }
                  }
                },
                text: "SAVE",
                width: MediaQuery.of(context).size.width / 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
