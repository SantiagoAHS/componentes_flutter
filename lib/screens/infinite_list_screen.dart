import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:practica3/screens/ayuda.dart';
import 'package:practica3/screens/datos.dart';
import 'package:practica3/screens/login.dart';
import 'package:practica3/screens/pagos.dart';
import 'package:practica3/screens/tarjetas.dart';
import 'package:practica3/services/firebase_services.dart';

class ParkingSpace {
  bool isOccupied;
  int elapsedTime;
  Timer? timer;

  ParkingSpace({required this.isOccupied, this.elapsedTime = 0});
}

class InfiniteListScreen extends StatefulWidget {
  const InfiniteListScreen({Key? key}) : super(key: key);

  @override
  State<InfiniteListScreen> createState() => _InfiniteListScreenState();
}

class _InfiniteListScreenState extends State<InfiniteListScreen> {
  List<ParkingSpace> parkingSpaces = [];
  List<Map<String, dynamic>> sensorData = [];

  @override
  void initState() {
    super.initState();
    _initSensorDataListener();
  }

  void _initSensorDataListener() {
    getSensorDataRealTime().listen((data) {
      setState(() {
        sensorData = data;
        _updateParkingSpaces();
      });
    });
  }

  void _updateParkingSpaces() {
    for (int i = 0; i < sensorData.length; i++) {
      bool isOccupied = sensorData[i]['data'] != 0;
      if (parkingSpaces.length <= i) {
        parkingSpaces.add(ParkingSpace(isOccupied: isOccupied));
      } else {
        if (parkingSpaces[i].isOccupied != isOccupied) {
          _updateParkingSpaceStatus(i, isOccupied);
        }
      }
    }
  }

  void _updateParkingSpaceStatus(int index, bool isOccupied) {
    ParkingSpace parkingSpace = parkingSpaces[index];
    if (isOccupied) {
      parkingSpace.timer?.cancel();
      parkingSpace.timer = Timer.periodic(Duration(seconds: 1), (timer) {
        setState(() {
          parkingSpace.elapsedTime++;
        });
      });
    } else {
      parkingSpace.timer?.cancel();
      parkingSpace.timer = null;
      parkingSpace.elapsedTime = 0;
    }
    parkingSpace.isOccupied = isOccupied;
  }

  @override
  void dispose() {
    for (var parkingSpace in parkingSpaces) {
      parkingSpace.timer?.cancel();
    }
    super.dispose();
  }

  void handlePayment(int parkingSpaceIndex) {
    ParkingSpace parkingSpace = parkingSpaces[parkingSpaceIndex];
    int elapsedTimeInSeconds = parkingSpace.elapsedTime;
    int hours = elapsedTimeInSeconds ~/ 3600;
    int minutes = (elapsedTimeInSeconds % 3600) ~/ 60;
    int seconds = elapsedTimeInSeconds % 60;

    if (elapsedTimeInSeconds == 0) {
      _showEmptySpaceDialog();
    } else {
      _showPaymentConfirmationDialog(hours, minutes, seconds, parkingSpaceIndex, elapsedTimeInSeconds);
    }
  }

  void _showEmptySpaceDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Seleccione un lugar ocupado'),
        content: const Text('Por favor, seleccione un lugar de estacionamiento ocupado para realizar el pago.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showPaymentConfirmationDialog(int hours, int minutes, int seconds, int parkingSpaceIndex, int elapsedTimeInSeconds) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Pago'),
        content: Text(
          '¿Estás seguro de que quieres pagar por el tiempo ocupado?\n\n'
          'Tiempo ocupado: $hours horas, $minutes minutos, $seconds segundos',
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo

              _handlePaymentConfirmation(parkingSpaceIndex, elapsedTimeInSeconds);
            },
            child: const Text('Pagar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Cerrar el diálogo
            },
            child: const Text('Cancelar'),
          ),
        ],
      ),
    );
  }

  void _handlePaymentConfirmation(int parkingSpaceIndex, int elapsedTimeInSeconds) {
    ParkingSpace parkingSpace = parkingSpaces[parkingSpaceIndex];

    parkingSpace.timer?.cancel();
    parkingSpace.elapsedTime = 0;
    parkingSpace.timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        parkingSpace.elapsedTime++;
      });
    });

    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String userId = user.uid;
      FirebaseService.savePayment(userId, parkingSpaceIndex, elapsedTimeInSeconds);
    } else {
      print('No se puede obtener la ID del usuario');
    }
  }

  String formatElapsedTime(int elapsedTime) {
    int hours = elapsedTime ~/ 3600;
    int minutes = (elapsedTime % 3600) ~/ 60;
    int seconds = elapsedTime % 60;
    return '$hours:h $minutes:m $seconds:s';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Parking'),
        actions: [
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaymentRecordsScreen()),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8.0,
          mainAxisSpacing: 8.0,
          childAspectRatio: 1.0,
        ),
        itemCount: sensorData.length,
        itemBuilder: (context, index) {
          var sensorValue = sensorData[index]['data'];
          var parkingSpace = parkingSpaces.length > index ? parkingSpaces[index] : ParkingSpace(isOccupied: false);
          Color color = sensorValue == 0 ? Colors.green : Colors.red;

          return GestureDetector(
            onTap: () {
              if (!parkingSpace.isOccupied) {
                setState(() {
                  parkingSpace.isOccupied = true;
                  parkingSpace.timer?.cancel();
                  parkingSpace.timer = Timer.periodic(Duration(seconds: 1), (timer) {
                    setState(() {
                      parkingSpace.elapsedTime++;
                    });
                  });
                });
              } else {
                handlePayment(index);
              }
            },
            child: Card(
              color: color,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    sensorValue == 0 ? Icons.local_parking : Icons.car_rental,
                    size: 50.0,
                    color: Colors.white,
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    sensorValue == 0 ? 'Libre' : 'Ocupado',
                    style: TextStyle(color: Colors.white),
                  ),
                  if (sensorValue != 0 && parkingSpace.isOccupied)
                    Flexible(
                      child: Text(
                        'Tiempo ocupado: ${formatElapsedTime(parkingSpace.elapsedTime)}',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                        textAlign: TextAlign.center,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const UserDataScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.monetization_on_outlined),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TarjetaScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.help),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HelpScreen()),
                );
              },
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
