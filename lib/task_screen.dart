import 'package:flutter/material.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {

  void MyAlertDialog(BuildContext context, int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Confirmation"),
          content: const Text("Are you sure want to delete?"),
          actions: [
            // DELETE BUTTON
            TextButton(
              onPressed: () {
                _removeTask(index); // Call function to remove task
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text("Delete", style: TextStyle(color: Colors.red)),
            ),

            // CANCEL BUTTON
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog without deleting
              },
              child: const Text("Cancel", style: TextStyle(color: Colors.blue)),
            ),
          ],
        );
      },
    );
  }

  // MySnackBar(message,context){return ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));}
  //
  // MyAlertDialog(context){
  //   return showDialog(context: context,
  //       builder: (BuildContext context){
  //         return Expanded(child: AlertDialog(
  //           title: Text("Confirmation"),
  //           content: Text("Are you sure for Delete?"),
  //           actions: [
  //             IconButton(onPressed: _removeTask(index), icon: Icon(Icons.delete)),
  //             // TextButton(onPressed: (){
  //             //   MySnackBar("Delete Success", context);Navigator.of(context).pop();
  //             // }, child: Icon(Icons.cancel),),
  //             TextButton(onPressed: (){
  //               Navigator.of(context).pop();
  //             }, child: Icon(Icons.delete))
  //
  //           ],
  //         ));
  //       }
  //   );
  // }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers for text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();

  // List to store task data
  List<Map<String, String>> taskList = [];

  void _addTask() {
    if (_formKey.currentState!.validate()) {
      setState(() {
        taskList.add({
          "name": _nameController.text,
          "number": _numberController.text,
        });
      });
      // Clear text fields after adding
      _nameController.clear();
      _numberController.clear();
    }
  }

  void _removeTask(int index) {
    setState(() {
      taskList.removeAt(index); // Remove the item from the list
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contact List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Form(key: _formKey,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top:5.0,bottom: 5.5),
                      child: TextFormField(
                        controller: _nameController,
                        keyboardType: TextInputType.name,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Name"
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter a name";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),

                    Padding(
                      padding: const EdgeInsets.only(top: .5,bottom: .5),
                      child: TextFormField(
                        controller: _numberController,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            hintText: "Number"
                        ),
                        validator: (String? value) {
                          if (value == null || value.isEmpty || value.length <11) {
                            return "Please enter a valid number";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(height: 10),

                    SizedBox(
                      child:Container(
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.blueGrey),
                        width: double.infinity,
                        height: 40,
                        child: TextButton(onPressed: _addTask,
                          child: const Text("Add",
                            style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                )
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: taskList.length,
                  itemBuilder: (context,indext){
                    Scrollable;
                    return GestureDetector(
                      child: Card(
                        elevation: 3,
                        child: ListTile(
                          onLongPress: (){MyAlertDialog(context,indext ); },
                          leading: const CircleAvatar(
                            backgroundColor: Colors.black,
                            radius: 20,
                            child: Icon(Icons.person,color: Colors.amber,size: 30),
                          ),
                          title: Text(" ${taskList[indext]['name']}"),
                          subtitle: Text(" ${taskList[indext]['number']} "),
                          trailing: const Icon(Icons.call,color: Colors.blue,size: 30),
                        ),
                      ),
                    );
                  }
              ),
            ),
          ],
        ),
      ),
    );
  }
}
