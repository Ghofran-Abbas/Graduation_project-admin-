



// web/firebase-messaging-sw.js

importScripts('https://www.gstatic.com/firebasejs/11.10.0/firebase-app-compat.js');
importScripts('https://www.gstatic.com/firebasejs/11.10.0/firebase-messaging-compat.js');

// قم بنفس إعدادات الـ Firebase config اللي في index.html
firebase.initializeApp({
  apiKey:            "AIzaSyBrBrrP8RmHbdj0CA9aXhonShhB10k0ryo",
  authDomain:        "graduationproject-3d3b0.firebaseapp.com",
  projectId:         "graduationproject-3d3b0",
  storageBucket:     "graduationproject-3d3b0.firebasestorage.app",
  messagingSenderId: "425903761784",
  appId:             "1:425903761784:web:ce5370b117d9b6a78f808d"
});

const messaging = firebase.messaging();

// هذا الكود يستقبل الرسائل حتى لو الصفحة مغلقة أو في الخلفية
messaging.onBackgroundMessage(function(payload) {
  console.log('[firebase-messaging-sw.js] Received background message ', payload);
  const title = payload.notification?.title || 'Notification';
  const options = {
    body: payload.notification?.body,
    // icon: '/icons/icon-192.png'  // لو حابب تضيف أيقونة
  };
  self.registration.showNotification(title, options);
});
