import 'package:flutter/material.dart';

class ManHinhGhiChu extends StatefulWidget {
  const ManHinhGhiChu({super.key});

  @override
  State<ManHinhGhiChu> createState() =>
      _ManHinhGhiChuState();
}

class _ManHinhGhiChuState
    extends State<ManHinhGhiChu> {
  final List<String> _notes = [];
  final TextEditingController _noteController =
      TextEditingController();

  void _addNote() {
    if (_noteController.text.trim().isEmpty)
      return;
    setState(() {
      _notes.add(_noteController.text.trim());
      _noteController.clear();
    });
  }

  void _deleteNoteAt(int index) {
    setState(() {
      _notes.removeAt(index);
    });
  }

  void _editNoteAt(int index) {
    TextEditingController editController =
        TextEditingController(
          text: _notes[index],
        );

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Chỉnh sửa ghi chú',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        content: TextField(
          controller: editController,
          autofocus: true,
          decoration: const InputDecoration(
            hintText: 'Nhập nội dung mới...',
            border: OutlineInputBorder(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () =>
                Navigator.pop(context),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.teal,
            ),
            onPressed: () {
              setState(() {
                _notes[index] = editController
                    .text
                    .trim();
              });
              Navigator.pop(context);
            },
            child: const Text('Lưu'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ghi chú dinh dưỡng'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _noteController,
              decoration: InputDecoration(
                hintText: 'Nhập ghi chú mới...',
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(12),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(
                    Icons.add,
                    color: Colors.teal,
                  ),
                  onPressed: _addNote,
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Danh sách ghi chú
            Expanded(
              child: _notes.isEmpty
                  ? const Center(
                      child: Text(
                        'Chưa có ghi chú nào.',
                        style: TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    )
                  : ListView.builder(
                      itemCount: _notes.length,
                      itemBuilder: (context, index) {
                        return Card(
                          elevation: 3,
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(
                                  10,
                                ),
                          ),
                          child: ListTile(
                            leading: const Icon(
                              Icons
                                  .note_alt_outlined,
                              color: Colors.teal,
                            ),
                            title: Text(
                              _notes[index],
                              style:
                                  const TextStyle(
                                    fontSize: 16,
                                  ),
                            ),
                            trailing: Row(
                              mainAxisSize:
                                  MainAxisSize
                                      .min,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    Icons.edit,
                                    color: Colors
                                        .blueAccent,
                                  ),
                                  tooltip:
                                      'Chỉnh sửa',
                                  onPressed: () =>
                                      _editNoteAt(
                                        index,
                                      ),
                                ),
                                IconButton(
                                  icon: const Icon(
                                    Icons.delete,
                                    color: Colors
                                        .redAccent,
                                  ),
                                  tooltip: 'Xóa',
                                  onPressed: () =>
                                      _deleteNoteAt(
                                        index,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}