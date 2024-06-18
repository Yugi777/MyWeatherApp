import 'package:flutter/material.dart';
import 'package:myapp/services/earthquake_service.dart';
import 'package:myapp/models/earthquake_model.dart';

class EarthquakePage extends StatefulWidget {
  @override
  _EarthquakePageState createState() => _EarthquakePageState();
}

class _EarthquakePageState extends State<EarthquakePage> {
  final EarthquakeService _earthquakeService = EarthquakeService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Padding(
        padding: const EdgeInsets.only(top: 80, bottom: 20),
        child: Column(
          children: [
            Icon(
              Icons.area_chart_outlined,
              color: Colors.grey[700],
              size: 36,
            ),
            SizedBox(height: 8),
            Text(
              'EARTHQUAKES',
              style: TextStyle(
                color: Colors.grey[700],
                fontSize: 36,
                fontFamily: 'Oswald',
              ),
            ),
            Expanded(
              child: FutureBuilder<Map<String, dynamic>>(
                future: _earthquakeService.getQuakes(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Oswald',
                        ),
                      ),
                    );
                  } else if (snapshot.data == null || !(snapshot.data!['features'] is List)) {
                    return Center(
                      child: Text(
                        'No earthquake data available.',
                        style: TextStyle(
                          color: Colors.grey[700],
                          fontFamily: 'Oswald',
                        ),
                      ),
                    );
                  } else {
                    final quakes = snapshot.data!['features'] as List<dynamic>;
                    return ListView.builder(
                      itemCount: quakes.length,
                      itemBuilder: (context, index) {
                        final quake = quakes[index]['properties'];
                        return ListTile(
                          title: Text(
                            'Magnitude: ${quake['mag'].toStringAsFixed(1)}',
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontFamily: 'Oswald',
                            ),
                          ),
                          subtitle: Text(
                            'Location: ${quake['place']}',
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontFamily: 'Oswald',
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
