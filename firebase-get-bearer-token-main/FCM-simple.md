# Configuración
Metod: POST
URL: https://fcm.googleapis.com/fcm/send

Body: 
```
{
 "to" : "Token del cliente",
 "notification" : {
     "body" : "Body of Your Notification",
     "title": "Title of Your Notification"
 },
 "data" : {
     "body" : "Body of Your Notification in Data",
     "title": "Title of Your Notification in Title",
     "key_1" : "Value for key_1",
     "key_2" : "Value for key_2"
 }
}
```

Para probar en Postman:
1. Cambiar el token del cliente por el del dispositivo a probar
2. Obtener key en Firebase/Configuracion del proyecto/Cloud Messaging/API de Cloud Messaging (heredada), se habilita y se copia la clave
3. En los Headers poner Authorization, key=

NOTA: esto es una prueba no recomendada, usar el SDK de Firebase para enviar notificaciones desde un REST API.