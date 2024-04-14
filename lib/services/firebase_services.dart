import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

FirebaseApp app = Firebase.app("[DEFAULT]");
// 1.0 crear una instancia de la base de datos 
FirebaseFirestore db = FirebaseFirestore.instance;
DatabaseReference _databaseReference = FirebaseDatabase.instanceFor(
  app: app,
  databaseURL: "https://componentes5c-efe70-default-rtdb.firebaseio.com/"
).ref().child("Sensores");


Future<List> getMascotas() async{
  List mascotas = [];
  
  //abrimos la base de datos macotas(conectar)
  CollectionReference cfMascotas = db.collection('mascotas');
  

  //recuperar los datos
  QuerySnapshot queryMascotas = await cfMascotas.get();
  queryMascotas.docs.forEach((documento) {
    mascotas.add(documento.data());
   });
   return mascotas;  
   
}

// Obtener datos de sensores en tiempo real desde Realtime Database
Stream<List<Map<String, dynamic>>> getSensorDataRealTime() {
  return _databaseReference.onValue.map((event) {
    List<Map<String, dynamic>> sensorDataList = [];
    var dataSnapshot = event.snapshot;
    if (dataSnapshot.value != null) {
      if (dataSnapshot.value is Map) {
        (dataSnapshot.value as Map).forEach((key, value) {
          sensorDataList.add({
            'sensorId': key,
            'data': value,
          });
        });
      } else if (dataSnapshot.value is List) {
        (dataSnapshot.value as List).forEach((element) {
          sensorDataList.add({
            'sensorId': '', // Debes reemplazar esto con el ID real del sensor
            'data': element,
          });
        });
      }
    }
    return sensorDataList;
  });
}

Future<void> saveUserData(String name, String phoneNumber, String carModel, String carPlate) async {
  try {
    await db.collection('users').add({
      'name': name,
      'phoneNumber': phoneNumber,
      'carModel': carModel,
      'carPlate': carPlate,
    });
    print('Datos guardados exitosamente en Firestore');
  } catch (e) {
    print('Error al guardar datos en Firestore: $e');
  }
}

Future<void> saveTarjetaData(String numeroTarjeta, String nombreTitular, String fechaExpiracion, String cvv) async {
  try {
    await db.collection('tarjetas').add({
      'numeroTarjeta': numeroTarjeta,
      'nombreTitular': nombreTitular,
      'fechaExpiracion': fechaExpiracion,
      'cvv': cvv,
    });
    print('Información de la tarjeta guardada exitosamente en Firestore');
  } catch (e) {
    print('Error al guardar información de la tarjeta en Firestore: $e');
  }
}

class FirebaseService {
  static Future<void> savePayment(String userId, int parkingSpaceIndex, int elapsedTimeInSeconds) async {
    try {
      // Obtener una referencia a la colección "pagos" en Firestore
      CollectionReference payments = FirebaseFirestore.instance.collection('pagos');

      // Crear un nuevo documento con un ID automático
      await payments.add({
        'userId': userId, // Agrega la ID del usuario que realizó el pago
        'parkingSpaceIndex': parkingSpaceIndex,
        'elapsedTimeInSeconds': elapsedTimeInSeconds,
        'timestamp': Timestamp.now(), // Agregar la marca de tiempo actual
      });

      print('Pago guardado en Firestore');
    } catch (e) {
      print('Error al guardar el pago en Firestore: $e');
      // Manejar el error según sea necesario
    }
  }

  // Método para obtener todos los pagos
  static Future<List<Map<String, dynamic>>> getPayments() async {
    try {
      // Obtener una referencia a la colección "pagos" en Firestore
      CollectionReference payments = FirebaseFirestore.instance.collection('pagos');

      // Obtener los documentos en la colección
      QuerySnapshot querySnapshot = await payments.get();

      // Convertir los documentos a una lista de Map<String, dynamic>
      List<Map<String, dynamic>> paymentList = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();

      return paymentList;
    } catch (e) {
      print('Error al obtener los pagos en Firestore: $e');
      // Manejar el error según sea necesario
      return [];
    }
  }

  // Método para obtener los pagos de un usuario específico
  static Future<List<Map<String, dynamic>>> getUserPayments(String userId) async {
    try {
      // Obtener una referencia a la colección "pagos" en Firestore
      CollectionReference payments = FirebaseFirestore.instance.collection('pagos');
      // Consultar los pagos filtrados por el UID del usuario
      QuerySnapshot querySnapshot = await payments.where('userId', isEqualTo: userId).get();
      // Convertir los documentos a una lista de Map<String, dynamic>
      List<Map<String, dynamic>> paymentList = querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
      return paymentList;
    } catch (e) {
      print('Error al obtener los pagos del usuario en Firestore: $e');
      // Manejar el error según sea necesario
      return [];
    }
  }
}
















