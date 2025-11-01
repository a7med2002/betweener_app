import 'package:betweeener_app/controllers/link_controller.dart';
import 'package:betweeener_app/views_features/profile/profile_view.dart';
import 'package:betweeener_app/views_features/widgets/custom_text_form_field.dart';
import 'package:betweeener_app/views_features/widgets/secondary_button_widget.dart';
import 'package:flutter/material.dart';

class EditLinkView extends StatefulWidget {
  static String id = "/editLink";
  const EditLinkView({super.key});

  @override
  State<EditLinkView> createState() => _AddLinkViewState();
}

class _AddLinkViewState extends State<EditLinkView> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController linkController = TextEditingController();
  late int idLink;

  void _updateLink(int idLink) {
    if (_key.currentState!.validate()) {
      final body = {'title': titleController.text, 'link': linkController.text};

      updateLink(context, body, idLink)
          .then((value) {
            Navigator.pop(context);
          })
          .catchError((error) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(error.toString())));
          });
    }
  }

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
                },
              ),
              SizedBox(height: 8),
              SecondaryButtonWidget(
                onTap: () => _updateLink(idLink),
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
