import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyBWqGk8XmqbmPYHx-iNI4yg4nGVbYAaL1M",
            authDomain: "cafeza-5dg6qy.firebaseapp.com",
            projectId: "cafeza-5dg6qy",
            storageBucket: "cafeza-5dg6qy.firebasestorage.app",
            messagingSenderId: "129780258995",
            appId: "1:129780258995:web:a024b22d4d00e7a9bf38c6"));
  } else {
    await Firebase.initializeApp();
  }
}
