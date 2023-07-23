# Servidor para generar un Bearer Token de Firebase

[Documentación oficial de Firebase](https://firebase.google.com/docs/cloud-messaging/auth-server)

## Pasos

1. Instalar las dependencias
```
npm install
```
2. Obtener el archivo de configuración de Firebase (firebase-admin.json) en en Firebase/Configuracion del proyecto/Cuentas de servicio/SDK de Firebase Admin/Node.js/Generar nueva clave privada/Generar clave
3. Levantar el servidor
```
node app
```
4. Hacer peticion GET en Postman a localhost:3000, copiar el token que dura 30 minutos
5. Hacer peticion POST en Postman https://fcm.googleapis.com/v1/projects/flutter-projects-e8220/messages:send
6. Pegar el token en Authorization/Bearer Token/Token
7. El el body: poner el token del dispositivo a probar
```
{
   "message":{
      "token":"token_1",
      "data":{
        "hola":"mundo",
        "hello":"world",
        "type":"product"
      },
      "notification":{
        "title":"FCM Message",
        "body":"This is an FCM notification message!"
      },
      "android":{
       "notification":{
         "image":"https://foo.bar/pizza-monster.png"
       }
     },
     "apns":{
       "payload":{
         "aps":{
           "mutable-content":1
         }
       },
       "fcm_options": {
           "image":"https://fernando-herrera.com/assets/img/cursos/flutter-cero.jpg"
       }
     }
   }
}
```

NOTA: esto es una prueba, usar el SDK de Firebase para enviar notificaciones desde un REST API.