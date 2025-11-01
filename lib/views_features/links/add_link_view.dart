import 'package:betweeener_app/controllers/link_controller.dart';
import 'package:betweeener_app/views_features/widgets/custom_text_form_field.dart';
import 'package:betweeener_app/views_features/widgets/secondary_button_widget.dart';
import 'package:flutter/material.dart';

class AddLinkView extends StatefulWidget {
  static String id = "/addNewLink";
  const AddLinkView({super.key});

  @override
  State<AddLinkView> createState() => _AddLinkViewState();
}

class _AddLinkViewState extends State<AddLinkView> {
  final GlobalKey<FormState> _key = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController linkController = TextEditingController();

  void _addLink() {
    if (_key.currentState!.validate()) {
      final body = {'title': titleController.text, 'link': linkController.text};
      addLink(context, body).then((value) => Navigator.pop(context)).catchError(
        (error) {
          print(error.toString());
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(error.toString())));
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Link"),
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
                onTap: _addLink,
                text: "ADD",
                width: MediaQuery.of(context).size.width / 3,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
