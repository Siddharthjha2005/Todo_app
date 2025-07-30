// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class TodoUi extends StatefulWidget {
//   const TodoUi({super.key});
//
//   @override
//   State<TodoUi> createState() => _TodoUiState();
// }
//
// class _TodoUiState extends State<TodoUi> {
//
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   late List<String> data;
//   Map<DateTime, List<bool>> selectedItemsByDate = {};
//   TextEditingController entryField = TextEditingController();
//   Map<DateTime,List<String>> tasksByDate = {};
//   final checkIndex = [];
//
//   weekDay(int dayNum) {
//     if(dayNum == 1) {
//       return "January";
//     }
//     else if(dayNum == 2) {
//       return "February";
//     }
//     else if(dayNum == 3) {
//       return "March";
//     }
//     else if(dayNum == 4) {
//       return "April";
//     }
//     else if(dayNum == 5) {
//       return "May";
//     }
//     else if(dayNum == 6) {
//       return "June";
//     }
//     else if(dayNum == 7) {
//       return "July";
//     }
//     else if(dayNum == 8) {
//       return "August";
//     }
//     else if(dayNum == 9) {
//       return "September";
//     }
//     else if(dayNum == 10) {
//       return "October";
//     }
//     else if(dayNum == 11) {
//       return "November";
//     }
//     else if(dayNum == 12) {
//       return "December";
//     }
//   }
//
//   Widget date(DateTime currDate) {
//     DateTime now = DateTime.now();
//     DateTime today = DateTime(now.year, now.month, now.day);
//     DateTime target = DateTime(currDate.year, currDate.month, currDate.day);
//
//     String label;
//     if (target == today) {
//       label = "Today";
//     }
//     else if (target == today.add(Duration(days: 1))) {
//       label = "Tomorrow";
//     }
//     else if (target == today.subtract(Duration(days: 1))) {
//       label = "Yesterday";
//     }
//     else {
//       label = "${currDate.day} ${weekDay(currDate.month)} ${currDate.year}";
//     }
//     return Container(
//       alignment: Alignment.topLeft,
//       child: Text(label, style:
//       TextStyle
//       (fontSize: 24,fontWeight:
//       FontWeight.bold),),
//     );
//   }
//
//   void addTask(DateTime date, String task) {
//     final target = DateTime(date.year, date.month, date.day);
//     setState(() {
//       if (!tasksByDate.containsKey(target)) {
//         tasksByDate[target] = [];
//       }
//       tasksByDate[target]!.add(task);
//
//       if (!selectedItemsByDate.containsKey(target)) {
//         selectedItemsByDate[target] = [];
//       }
//       selectedItemsByDate[target]!.add(false);
//     });
//     entryField.clear();
//   }
//
//
//   Widget taskDetails(DateTime currDate) {
//     DateTime target = DateTime(currDate.year, currDate.month, currDate.day);
//     data = tasksByDate[target] ?? defaultDetails(target);
//
//     // Initialize checkbox states if missing or mismatched length
//     selectedItemsByDate[target] ??= List.generate(data.length, (_) => false);
//     if (selectedItemsByDate[target]!.length != data.length) {
//       selectedItemsByDate[target] = List.generate(data.length, (_) => false);
//     }
//
//     final selectedItems = selectedItemsByDate[target]!;
//
//     return data.isEmpty
//         ? Container(
//       width: MediaQuery.of(context).size.width,
//       height: 220,
//       child: Center(
//           child: Text(
//             "Add a note",
//             style: TextStyle(fontSize: 20),
//           )),
//     )
//         : Column(
//       children: List.generate(data.length, (index) {
//         return ListTile(
//           contentPadding: EdgeInsets.zero,
//           title: Text(
//             data[index],
//             style: TextStyle(
//                 decoration: selectedItems[index]
//                     ? TextDecoration.lineThrough
//                     : TextDecoration.none),
//           ),
//           trailing: IconButton(
//             onPressed: () {
//               setState(() {
//                 selectedItems[index] = !selectedItems[index];
//               });
//             },
//             icon: selectedItems[index]
//                 ? Icon(Icons.check_box)
//                 : Icon(Icons.check_box_outline_blank),
//           ),
//         );
//       }),
//     );
//   }
//
//
//   List<String> defaultDetails(DateTime currDate) {
//     DateTime now = DateTime.now();
//     DateTime today = DateTime(now.year,now.month,now.day);
//     DateTime target = DateTime(currDate.year,currDate.month,currDate.day);
//     if (target == today) {
//       return ["Grocery shopping","Book doctor's appointment","Call mom"];
//     } else if (target == today.add(Duration(days: 1))) {
//       return ["Book doctor's appointment"];
//     } else if (target == today.add(Duration(days: 2))) {
//       return ["Call mom"];
//     } else {
//       return [];
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Tasks",style: TextStyle(
//             fontWeight: FontWeight.bold),),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.fromLTRB(15, 0, 15, 100),
//           child: Column(
//             children: [
//               SizedBox(height: 10,),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.grey.shade300,
//                   borderRadius: BorderRadius.circular(10)
//                 ),
//                 child: TextField(
//                   controller: entryField,
//                   onSubmitted: (value) {
//                     taskDetails(_focusedDay);
//                     addTask(_focusedDay,value);
//                   },
//                   style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
//                   decoration: InputDecoration(
//                     hintText: "Add a new task",
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30,),
//               Container(
//                 child: TableCalendar(
//                   selectedDayPredicate: (day) {
//                     return isSameDay(_selectedDay, day);
//                   },
//                   onDaySelected: (selectedDay, focusedDay) {
//                     setState(() {
//                       _selectedDay = selectedDay;
//                       _focusedDay = focusedDay;
//                       print(_selectedDay);
//                       print(_focusedDay);
//                     });
//                   },
//                     focusedDay: _focusedDay,
//                     firstDay: DateTime.utc(2010,1,1),
//                     lastDay: DateTime.utc(2030,12,31),
//                 ),
//               ),
//               SizedBox(height: 20,),
//               date(_focusedDay),
//               taskDetails(_focusedDay),
//             ],
//           ),
//         ),
//       ),
//       bottomSheet:Container(
//         margin: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
//         width: double.infinity,
//         child: ElevatedButton(
//           style: ButtonStyle(
//               shape: MaterialStateProperty.all(RoundedRectangleBorder
//                 (borderRadius: BorderRadius.circular(10))),
//               backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
//               padding: MaterialStateProperty.all(EdgeInsets.symmetric
//                 (vertical: 16)),
//           ),
//           onPressed: (){
//             setState(() {
//               final target = DateTime(_focusedDay.year, _focusedDay.month, _focusedDay.day);
//               final items = selectedItemsByDate[target];
//               if (items != null) {
//                 for (int i = items.length - 1; i >= 0; i--) {
//                   if (items[i]) {
//                     data.removeAt(i);
//                     items.removeAt(i);
//                   }
//                 }
//               }
//               tasksByDate[target] = List.from(data);
//             });
//           },
//           child: Text("Clear Completed",style: TextStyle(color:
//           Colors.black),),
//         ),
//       ),
//     );
//   }
// }





// import 'package:flutter/material.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:todo_app/Firebase/curd.dart';
//
// import '../Firebase/curd.dart';
//
// class TodoUi extends StatefulWidget {
//   const TodoUi({super.key});
//
//   @override
//   State<TodoUi> createState() => _TodoUiState();
// }
//
// class _TodoUiState extends State<TodoUi> {
//
//   DateTime _focusedDay = DateTime.now();
//   DateTime? _selectedDay;
//   TextEditingController entryField = TextEditingController();
//   late String label;
//   late List<bool> selectedCheck;
//   late List<String> deleteRecord;
//   int? recordIndex;
//
//   weekDay(int dayNum) {
//     if(dayNum == 1) {
//       return "January";
//     }
//     else if(dayNum == 2) {
//       return "February";
//     }
//     else if(dayNum == 3) {
//       return "March";
//     }
//     else if(dayNum == 4) {
//       return "April";
//     }
//     else if(dayNum == 5) {
//       return "May";
//     }
//     else if(dayNum == 6) {
//       return "June";
//     }
//     else if(dayNum == 7) {
//       return "July";
//     }
//     else if(dayNum == 8) {
//       return "August";
//     }
//     else if(dayNum == 9) {
//       return "September";
//     }
//     else if(dayNum == 10) {
//       return "October";
//     }
//     else if(dayNum == 11) {
//       return "November";
//     }
//     else if(dayNum == 12) {
//       return "December";
//     }
//   }
//
//   Widget date(DateTime currDate) {
//     DateTime now = DateTime.now();
//     DateTime today = DateTime(now.year, now.month, now.day);
//     DateTime target = DateTime(currDate.year, currDate.month, currDate.day);
//
//     if (target == today) {
//       label = "Today";
//     }
//     else if (target == today.add(Duration(days: 1))) {
//       label = "Tomorrow";
//     }
//     else if (target == today.subtract(Duration(days: 1))) {
//       label = "Yesterday";
//     }
//     else {
//       label = "${currDate.day} ${weekDay(currDate.month)} ${currDate.year}";
//     }
//     return Container(
//       alignment: Alignment.topLeft,
//       child: Text(label, style:
//       TextStyle
//         (fontSize: 24,fontWeight:
//       FontWeight.bold),),
//     );
//   }
//
//   Future<List<String>> tasksData() async {
//     final data = await Curd().showData(collName: label);
//     selectedCheck = await Curd().showCheck(collName: label);
//     return data;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Tasks",style: TextStyle(
//             fontWeight: FontWeight.bold),),
//         centerTitle: true,
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           padding: EdgeInsets.fromLTRB(15, 0, 15, 100),
//           child: Column(
//             children: [
//               SizedBox(height: 10,),
//               Container(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 decoration: BoxDecoration(
//                     color: Colors.grey.shade300,
//                     borderRadius: BorderRadius.circular(10)
//                 ),
//                 child: TextField(
//                   controller: entryField,
//                   onSubmitted: (value) async{
//                     if(entryField.text.trim().isNotEmpty) {
//                       List<int> id = await Curd().findDocId(collName: label);
//                       String newDocId;
//                       if(recordIndex !=null) {
//                         await Curd().updateData(collName: label, docName:
//                         (recordIndex! + 1).toString(),
//                             modifiedData: value);
//                         recordIndex = null;
//                       }
//                       else if(id.isNotEmpty) {
//                         int max = id.last + 1;
//                         newDocId = max.toString();
//                         await Curd().create(collName: label, docName: newDocId, note: value);
//                       }
//                       else {
//                         newDocId = "1";
//                         await Curd().create(collName: label, docName: newDocId, note: value);
//                       }
//                       entryField.clear();
//                       setState(() {
//
//                       });
//                     }
//                   },
//                   style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
//                   decoration: InputDecoration(
//                     hintText: "Add a new task",
//                     border: InputBorder.none,
//                   ),
//                 ),
//               ),
//               SizedBox(height: 30,),
//               Container(
//                 child: TableCalendar(
//                   selectedDayPredicate: (day) {
//                     return isSameDay(_selectedDay, day);
//                   },
//                   onDaySelected: (selectedDay, focusedDay) {
//                     setState(() {
//                       _selectedDay = selectedDay;
//                       _focusedDay = focusedDay;
//                       print(_selectedDay);
//                       print(_focusedDay);
//                     });
//                   },
//                   focusedDay: _focusedDay,
//                   firstDay: DateTime.utc(2010,1,1),
//                   lastDay: DateTime.utc(2030,12,31),
//                 ),
//               ),
//               SizedBox(height: 20,),
//               date(_focusedDay),
//               FutureBuilder<List<String>>(
//                 future: tasksData(),
//                 builder: (context, snapshot) {
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return Container(
//                       width: MediaQuery.of(context).size.width,
//                         height: 200,
//                         child: Center(child: CircularProgressIndicator()));
//                   } else if (snapshot.hasError) {
//                     return Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: 200,
//                         child: Center(child: Text('Error: ${snapshot
//                             .error}',style: TextStyle(fontSize: 20),)));
//                   } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
//                     return Container(
//                         width: MediaQuery.of(context).size.width,
//                         height: 200,
//                         child: Center(child: Text('Add a Note.',style:
//                         TextStyle(fontSize: 20),)));
//                   } else {
//                     final data = snapshot.data!;
//
//                     return Column(
//                       children: List.generate(data.length, (index) {
//                         return GestureDetector(
//                           onTap: () {
//                             entryField.clear();
//                             entryField.text = data[index];
//                             recordIndex = index;
//                           },
//                           child: ListTile(
//                             contentPadding: EdgeInsets.zero,
//                             title: Text(data[index],style: TextStyle
//                               (decoration: selectedCheck[index] ? TextDecoration
//                               .lineThrough:TextDecoration.none,),),
//                             trailing: IconButton(
//                               onPressed: () {
//                                 setState(() {
//                                   selectedCheck[index] = !selectedCheck[index];
//                                 });
//                                 Curd().updateCheck(collName: label, docName:
//                                 (index + 1).toString(), status:
//                                 selectedCheck[index]);
//                               },
//                               icon: selectedCheck[index] ? Icon(Icons.check_box)
//                                   :Icon
//                                 (Icons
//                                   .check_box_outline_blank),
//                             ),
//                           ),
//                         );
//                       }),
//                     );
//                   }
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//       bottomSheet:Container(
//         margin: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
//         width: double.infinity,
//         child: ElevatedButton(
//           style: ButtonStyle(
//             shape: MaterialStateProperty.all(RoundedRectangleBorder
//               (borderRadius: BorderRadius.circular(10))),
//             backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
//             padding: MaterialStateProperty.all(EdgeInsets.symmetric
//               (vertical: 16)),
//           ),
//           onPressed: ()async{
//             deleteRecord = await Curd().usingCheckGiveId(collName: label);
//             if (deleteRecord.isNotEmpty) {
//               await Curd().deleteRecord(collName: label, docName: deleteRecord);
//               setState(() {});
//             }
//           },
//           child: Text("Clear Completed",style: TextStyle(color:
//           Colors.black),),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:todo_app/Firebase/curd.dart';

import '../Firebase/curd.dart';

class TodoUi extends StatefulWidget {
  const TodoUi({super.key});

  @override
  State<TodoUi> createState() => _TodoUiState();
}

class _TodoUiState extends State<TodoUi> {

  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  TextEditingController entryField = TextEditingController();
  late String label;
  String? recordDocId;

  weekDay(int dayNum) {
    if(dayNum == 1) {
      return "January";
    }
    else if(dayNum == 2) {
      return "February";
    }
    else if(dayNum == 3) {
      return "March";
    }
    else if(dayNum == 4) {
      return "April";
    }
    else if(dayNum == 5) {
      return "May";
    }
    else if(dayNum == 6) {
      return "June";
    }
    else if(dayNum == 7) {
      return "July";
    }
    else if(dayNum == 8) {
      return "August";
    }
    else if(dayNum == 9) {
      return "September";
    }
    else if(dayNum == 10) {
      return "October";
    }
    else if(dayNum == 11) {
      return "November";
    }
    else if(dayNum == 12) {
      return "December";
    }
  }

  Widget date(DateTime currDate) {
    DateTime now = DateTime.now();
    DateTime today = DateTime(now.year, now.month, now.day);
    DateTime target = DateTime(currDate.year, currDate.month, currDate.day);

    if (target == today) {
      label = "Today";
    }
    else if (target == today.add(Duration(days: 1))) {
      label = "Tomorrow";
    }
    else if (target == today.subtract(Duration(days: 1))) {
      label = "Yesterday";
    }
    else {
      label = "${currDate.day} ${weekDay(currDate.month)} ${currDate.year}";
    }
    return Container(
      alignment: Alignment.topLeft,
      child: Text(label, style:
      TextStyle
        (fontSize: 24,fontWeight:
      FontWeight.bold),),
    );
  }

  Future<List<Map<String, dynamic>>> tasksData() async {
    final data = await Curd().showDataWithId(collName: label);
    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Tasks",style: TextStyle(
            fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.fromLTRB(15, 0, 15, 100),
          child: Column(
            children: [
              SizedBox(height: 10,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10)
                ),
                child: TextField(
                  controller: entryField,
                  onSubmitted: (value) async{
                    if(entryField.text.trim().isNotEmpty) {
                      List<int> id = await Curd().findDocId(collName: label);
                      String newDocId;
                      if (recordDocId != null) {
                        await Curd().updateData(
                          collName: label,
                          docName: recordDocId!,
                          modifiedData: value,
                        );
                        recordDocId = null;
                      }
                      else if(id.isNotEmpty) {
                        int max = id.last + 1;
                        newDocId = max.toString();
                        await Curd().create(collName: label, docName: newDocId, note: value);
                      }
                      else {
                        newDocId = "1";
                        await Curd().create(collName: label, docName: newDocId, note: value);
                      }
                      entryField.clear();
                      setState(() {

                      });
                    }
                  },
                  style: TextStyle(fontSize: 16,fontWeight: FontWeight.bold),
                  decoration: InputDecoration(
                    hintText: "Add a new task",
                    border: InputBorder.none,
                  ),
                ),
              ),
              SizedBox(height: 30,),
              Container(
                child: TableCalendar(
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                      print(_selectedDay);
                      print(_focusedDay);
                    });
                  },
                  focusedDay: _focusedDay,
                  firstDay: DateTime.utc(2010,1,1),
                  lastDay: DateTime.utc(2030,12,31),
                ),
              ),
              SizedBox(height: 20,),
              date(_focusedDay),
              FutureBuilder<List<Map<String, dynamic>>>(
                future: tasksData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Center(child: CircularProgressIndicator()));
                  } else if (snapshot.hasError) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Center(child: Text('Error: ${snapshot
                            .error}',style: TextStyle(fontSize: 20),)));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        height: 200,
                        child: Center(child: Text('Add a Note.',style:
                        TextStyle(fontSize: 20),)));
                  } else {
                    final data = snapshot.data!;

                    return Column(
                      children: data.asMap().entries.map((entry) {
                        final index = entry.key;
                        final item = entry.value;
                        final docId = item['id'] as String;
                        final note = item['note'] as String;
                        final isChecked = item['check'] as bool;

                        return GestureDetector(
                          onTap: () {
                            entryField.clear();
                            entryField.text = note;
                            recordDocId = docId;
                          },
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            title: Text(
                              note,
                              style: TextStyle(
                                decoration: isChecked ? TextDecoration.lineThrough : TextDecoration.none,
                              ),
                            ),
                            trailing: IconButton(
                              onPressed: () async {
                                await Curd().updateCheck(
                                  collName: label,
                                  docName: docId,
                                  status: !isChecked,
                                );
                                setState(() {});
                              },
                              icon: isChecked ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank),
                            ),
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      bottomSheet:Container(
        margin: EdgeInsets.symmetric(vertical: 30,horizontal: 20),
        width: double.infinity,
        child: ElevatedButton(
          style: ButtonStyle(
            shape: MaterialStateProperty.all(RoundedRectangleBorder
              (borderRadius: BorderRadius.circular(10))),
            backgroundColor: MaterialStateProperty.all(Colors.grey.shade300),
            padding: MaterialStateProperty.all(EdgeInsets.symmetric
              (vertical: 16)),
          ),
          onPressed: () async {
            final allTasks = await Curd().showDataWithId(collName: label);
            final toDelete = allTasks
                .where((item) => item['check'] == true)
                .map((item) => item['id'] as String)
                .toList();


            if (toDelete.isNotEmpty) {
              await Curd().deleteRecord(collName: label, docName: toDelete);
              setState(() {});
            }
          },
          child: Text("Clear Completed",style: TextStyle(color:
          Colors.black),),
        ),
      ),
    );
  }
}


