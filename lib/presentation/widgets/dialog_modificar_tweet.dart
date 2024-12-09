import 'package:flutter/material.dart';

class ModificarTweetWidget extends StatefulWidget {
  final String initialcontent;
  final String? initialimage;

  const ModificarTweetWidget({
    required this.initialcontent,
    this.initialimage,
    super.key,
  });

  @override
  State<ModificarTweetWidget> createState() => _ModificarTweetWidgetState();
}

class _ModificarTweetWidgetState extends State<ModificarTweetWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late TextEditingController _contentController;
  late TextEditingController _imageController;

  @override
  void initState() {
    super.initState();
    _contentController = TextEditingController(text: widget.initialcontent);
    _imageController = TextEditingController(text: widget.initialimage ?? "");
  }

  @override
  void dispose() {
    _contentController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              const Text("Modifica un tweet"),
              const SizedBox(height: 10),
              TextFormField(
                controller: _contentController,
                decoration: const InputDecoration(labelText: 'Contenido del tweet'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Este campo es obligatorio';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(labelText: 'Imagen'),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, null);
                    },
                    child: const Text('Cancelar'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pop(context, {
                          'content': _contentController.text,
                          'image': _imageController.text,
                        });
                      }
                    },
                    child: const Text('Actualizar'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}