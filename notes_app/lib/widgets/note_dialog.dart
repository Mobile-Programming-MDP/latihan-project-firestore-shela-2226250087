import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:notes/models/note.dart';
import 'package:notes/services/location_service.dart';
import 'package:notes/services/note_service.dart';

class NoteDialog extends StatefulWidget {
  final Note? note;

  NoteDialog({super.key, this.note});

  @override
  State<NoteDialog> createState() => _NoteDialogState();
}

class _NoteDialogState extends State<NoteDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  XFile? _imageFile;
  Position? _position;

  @override
  void initState() {
    super.initState();
    if (widget.note != null) {
      _titleController.text = widget.note!.title;
      _descriptionController.text = widget.note!.description;
    }
  }

  Future<void> _getLocation() async {
    final location = await LocationService().getCurrentLocation();
    setState(() {
      _position = location;
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = pickedFile;
      });
    }
  }

  Future<void> _showImageSourceDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Select Image Source'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.camera);
              },
              child: const Text('Camera'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _pickImage(ImageSource.gallery);
              },
              child: const Text('Gallery'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.note == null ? 'Add Notes' : 'Update Notes'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Title: ', textAlign: TextAlign.start),
            TextField(controller: _titleController),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('Description: '),
            ),
            TextField(controller: _descriptionController),
            const Padding(
              padding: EdgeInsets.only(top: 20),
              child: Text('Image: '),
            ),
            SizedBox(
              height: 200,
              child: _imageFile != null
                  ? Image.file(File(_imageFile!.path), fit: BoxFit.cover)
                  : (widget.note?.imageUrl != null &&
                          Uri.parse(widget.note!.imageUrl!).isAbsolute
                      ? Image.network(widget.note!.imageUrl!, fit: BoxFit.cover)
                      : Container()),
            ),
            TextButton(
              onPressed: _showImageSourceDialog,
              child: const Text('Pick Image'),
            ),
            TextButton(
              onPressed: _getLocation,
              child: const Text('Get Location'),
            ),
            Text(
              _position?.latitude != null && _position?.longitude != null
                  ? "Current Location : ${_position!.latitude.toString()}, ${_position!.longitude.toString()}"
                  : "Current Location : ${widget.note?.lat}, ${widget.note?.lng}",
              textAlign: TextAlign.start,
            )
          ],
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text('Cancel'),
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            String? imageUrl = widget.note?.imageUrl;
            if (_imageFile != null) {
              imageUrl = await NoteService.uploadImage(_imageFile!);
              if (imageUrl == null) {
                // Show error message if the image upload failed
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Failed to upload image')),
                );
                return;
              }
            }

            Note note = Note(
              id: widget.note?.id,
              title: _titleController.text,
              description: _descriptionController.text,
              imageUrl: imageUrl,
              lat: widget.note?.lat.toString() != _position?.latitude.toString()
                  ? _position?.latitude.toString()
                  : widget.note?.lat.toString(),
              lng:
                  widget.note?.lng.toString() != _position?.longitude.toString()
                      ? _position?.longitude.toString()
                      : widget.note?.lng.toString(),
              createdAt: widget.note?.createdAt,
            );
            if (widget.note == null) {
              await NoteService.addNote(note);
              Navigator.of(context).pop();
            } else {
              await NoteService.updateNote(note);
              Navigator.of(context).pop();
            }
          },
          child: Text(widget.note == null ? 'Add' : 'Update'),
        ),
      ],
    );
  }
}
