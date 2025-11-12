import 'package:betweeener_app/providers/link_provider.dart';
import 'package:betweeener_app/views_features/widgets/custom_text_form_field.dart';
import 'package:betweeener_app/views_features/widgets/secondary_button_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddLinkView extends StatelessWidget {
  static String id = "/addNewLink";
   AddLinkView({super.key});

  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  final TextEditingController titleController = TextEditingController();

  final TextEditingController linkController = TextEditingController();

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
                onTap: () async {
                  if (_key.currentState!.validate()) {
                    final body = {
                      'title': titleController.text,
                      'link': linkController.text,
                    };
                    await Provider.of<LinkProvider>(
                      context,
                      listen: false,
                    ).addLinkToList(body);
                    Navigator.pop(context);
                  }
                },
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
