import 'package:googleapis_auth/auth_io.dart';

class GetServerKey {
  Future<String> GetServerKeyToken() async {
    final scopes = [
      'https://www.googleapis.com/auth/userinfo.email',
      'https://www.googleapis.com/auth/firebase.database',
      'https://www.googleapis.com/auth/firebase.messaging',
    ];
    final client = await clientViaServiceAccount(
        ServiceAccountCredentials.fromJson({
          "type": "service_account",
          "project_id": "ndconnectandroid",
          "private_key_id": "462aeda06632d41bdfd73fcfc647de4bf8cdbb16",
          "private_key":
              "-----BEGIN PRIVATE KEY-----\nMIIEvwIBADANBgkqhkiG9w0BAQEFAASCBKkwggSlAgEAAoIBAQCzhqJwvZKpFzUf\nQSfTdclyetd+5q+kRC/CTm4pPIcE4Hzru6f5fqsR3q9My4GaHVbSuGOu7i9qD33x\navHm5SH37WcBj+bpKLqccrDWHZ/RNHGY1mtq2ccHdb3iuNhOdtqm1tubxyxFekam\nhxqYXv3NuX1vHJQznhuXKBrHI8acUfUKF4QN3h5WqbuMrEhl3AS4VsPPqWJ3xEqc\nJMYznxscif4uekoxT7baqJNCv4U35bvAGlMjbaWcygoQnyWVKrgxf33/fIbLwUcd\nKugKctu9xR+97twuWwLjY5vew7KDvk9M1uY0qh4kHKvIGnr3uxsrLrwKU/dLluK3\nbBNrW9HvAgMBAAECggEAD4Znms9SFQxcPDEyw/8uJhfIdgF2FAMPjEKjFS7WUE4n\nj21Bh/pzyc5To5T/xred0AhBGpofgJEJZ6zDcZ/EEcA2hbSPl/89MBVdBI84SGu8\nHScB0BI4O4Vrn+UzU4nEu+Pdxvlw8ysxW+pYGvAwC6/sUIUMrfAQ28AMnMcTwGXS\n7Z03caLkkCLf5fiXtAL/pC/rUv9JIG7qwx0rpZc8XBcjSilPD7gkC7c8cUu1OB24\nyW6wv3yZD2fHTMSfFx+MkcMMtgPNQMIaVFwL8fHRHldTxQ5MYU/zS64sGynJPLly\n1oDrTkzo50WvIFIHDIzbL8YRc7UL6o+SzEY9u70IMQKBgQDdRKsqdaUQBAgIX8Em\nbzMDy0482xgN0MPx7OxqdHJuRBv7WuMogWutg060Ym2785NfwI7xvwuSasPBoXyU\nkZCFrdvTptt4UTlxOO0HSy2vbeStHr3bIL+IMuHnAsvWD5B034FehGlI9jGWA4K5\ngOEMq2AYZHZu3LKnrdPcoQsYsQKBgQDPtJ0QIe4zVpBxhzDYLIQdk+kWpPNvFuKS\nGAou29cO2WanXd+S7TMd7CxDt2lRqkXOeWQepUyScExmW2Y8vRvH5j1bYu1hp/pc\nEftUOWXIaWw4hCGxxm1msigk9KLEBDehMvaL5uYlJPK5K2o6/XwXuwkxFbS3Z6ox\nmpaFEg48nwKBgQC3Q+3lQAWUC1K/5NdsxwNg7B4EB4+XucbhdNOnpIU20RDAElo9\nLVyLHUut2ix7VNZGo42BqzOhdO5oTSGLSDmEjyiY2AXFVLkYDwc7WEghmgqiXOjx\nOuGIpGQ42zcLOF70fj5/k3pEpS0SzBuVG6rKvJLeAS+ayQ7sFOx6O6SeMQKBgQCR\n76Y3co+p1JWSntlL2iNNoOIx/d3o3Nx+p5NoDyDQlyGQUN3Inw6+ZHVJcvH15jw7\n8YDOI3hkn7CebnOsE3cUggn0TtLZPawjyqKbL+T65k+aegQuo2u0r1KTfKtsLEZl\n5afi7m4gBRDh18ZBAl+RUOIJceXSw2yKg8JkZyZHowKBgQDB2kC5sEChqohwW9Bl\nzEqaOPWr4KJD0QArmrjPWzPxJJFDfsp05MADCwGXrYcGP5SjeEsGjavT680zU681\nU8ZDv95gNjni7saIHKNs+75hBLXdxxveIYuMwbuEOqvP0kXBNRef3e+5A+9I3uJe\nbU8hGm9O/7O076uKc9YNgCAQyA==\n-----END PRIVATE KEY-----\n",
          "client_email":
              "firebase-adminsdk-d1u4c@ndconnectandroid.iam.gserviceaccount.com",
          "client_id": "111516315577828997477",
          "auth_uri": "https://accounts.google.com/o/oauth2/auth",
          "token_uri": "https://oauth2.googleapis.com/token",
          "auth_provider_x509_cert_url":
              "https://www.googleapis.com/oauth2/v1/certs",
          "client_x509_cert_url":
              "https://www.googleapis.com/robot/v1/metadata/x509/firebase-adminsdk-d1u4c%40ndconnectandroid.iam.gserviceaccount.com",
          "universe_domain": "googleapis.com"
        }),
        scopes);
    final accessServerKey = client.credentials.accessToken.data;
    return accessServerKey;
  }
}
