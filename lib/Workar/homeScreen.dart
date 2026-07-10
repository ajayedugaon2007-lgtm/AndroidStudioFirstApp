import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Map<String, dynamic>> services = [
    {"name": "Electrician", "icon": Icons.electrical_services},
    {"name": "Plumber", "icon": Icons.plumbing},
    {"name": "Carpenter", "icon": Icons.handyman},
    {"name": "Painter", "icon": Icons.format_paint},
    {"name": "AC Repair", "icon": Icons.ac_unit},
    {"name": "Cleaner", "icon": Icons.cleaning_services},
    {"name": "Mechanic", "icon": Icons.build},
    {"name": "Welder", "icon": Icons.construction},
    {"name": "Driver", "icon": Icons.directions_car},
    {"name": "Gardener", "icon": Icons.yard},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,

      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 0,
        title: Text("Worker App"),
      ),

      body: Padding(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Text(
              "Hello, Ajay 👋",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 5),

            Row(
              children: [
                Icon(Icons.location_on,
                    color: Colors.red),
                SizedBox(width: 5),
                Text(
                  "Purnea, Bihar",
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),

            SizedBox(height: 20),

            TextField(
              decoration: InputDecoration(
                hintText: "Search Services",
                prefixIcon: Icon(Icons.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius:
                  BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            SizedBox(height: 20),

            Expanded(
              child: GridView.builder(
                itemCount: services.length,
                gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                  childAspectRatio: 1,
                ),
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(15),
                    ),
                    child: InkWell(
                      borderRadius:
                      BorderRadius.circular(15),
                      onTap: () {},
                      child: Column(
                        mainAxisAlignment:
                        MainAxisAlignment.center,
                        children: [
                          Icon(
                            services[index]["icon"],
                            color: Colors.blue,
                            size: 50,
                          ),
                          SizedBox(height: 10),
                          Text(
                            services[index]["name"],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight:
                              FontWeight.bold,
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