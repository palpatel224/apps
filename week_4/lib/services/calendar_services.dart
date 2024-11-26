// config.dart

// ignore_for_file: constant_identifier_names

import 'dart:convert';

import 'dart:typed_data';
import 'package:week_4/secrets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http ;


class GoogleCalendarConfig {
  static String get CLIENT_ID => Secrets.googleClientId;
  static String get API_KEY => Secrets.googleApiKey;

  static const List<String> SCOPES = [
    'email',
    'https://www.googleapis.com/auth/calendar',
    'https://www.googleapis.com/auth/calendar.events',
  ];

  static final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId: CLIENT_ID,
    scopes: SCOPES,
  );

  static final clientId = ClientId(CLIENT_ID);
}

class CalendarService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/calendar',
      'https://www.googleapis.com/auth/calendar.events',
    ],
    clientId: 'YOUR_CLIENT_ID_HERE', // Add this from Google Cloud Console
  );

  static Future<calendar.CalendarApi?> getCalendarAPI() async {
    try {
      // Check if already signed in
      final currentUser = _googleSignIn.currentUser;
      final googleUser = currentUser ?? await _googleSignIn.signIn();
      
      if (googleUser == null) {
        return null;
      }

      final googleAuth = await googleUser.authentication;
      
      if (googleAuth.accessToken == null) {
        return null;
      }

      final credentials = AccessCredentials(
        AccessToken(
          'Bearer',
          googleAuth.accessToken!,
          DateTime.now().toUtc().add(const Duration(hours: 1)),
        ),
        googleAuth.idToken,
        ['https://www.googleapis.com/auth/calendar'],
      );

      return calendar.CalendarApi(
        GoogleAuthClient(credentials),
      );
    } catch (error) {
      return null;
    }
  }

  // Method to check sign in status
  static Future<bool> isSignedIn() async {
    return await _googleSignIn.isSignedIn();
  }

  // Method to sign out
  static Future<void> signOut() async {
    await _googleSignIn.signOut();
  }

  static Future<List<calendar.Event>> fetchEvents() async {
    try {
      final calendarApi = await getCalendarAPI();
      if (calendarApi == null) {
        return [];
      }

      final events = await calendarApi.events.list(
        'primary',
        timeMin: DateTime.now().toUtc(),
        maxResults: 10,
        singleEvents: true,
        orderBy: 'startTime',
      );

      if (events.items == null) {
        return [];
      }

      return events.items!;
    } catch (error) {
      return [];
    }
  }

  static Future<bool> addEvent({
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    try {
      final calendarApi = await getCalendarAPI();
      if (calendarApi == null) {
        return false;
      }

      final event = calendar.Event()
        ..summary = title
        ..description = description
        ..start = calendar.EventDateTime()
          ..dateTime = startTime
          ..timeZone = DateTime.now().timeZoneName
        ..end = calendar.EventDateTime()
          ..dateTime = endTime
          ..timeZone = DateTime.now().timeZoneName;

      final result = await calendarApi.events.insert(event, 'primary');
      
      if (result.status == 'confirmed') {
        return true;
      } else {
        return false;
      }
    } catch (error) {
      return false;
    }
  }
}

extension on calendar.Event {
  set dateTime(DateTime dateTime) {}

  set timeZone(String timeZone) {}
}

class GoogleAuthClient extends AuthClient {
  final AccessCredentials credentials;
  final http.Client _client = http.Client();
  final List<String> _scopes;

  GoogleAuthClient(this.credentials) : _scopes = credentials.scopes;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers['Authorization'] = 'Bearer ${credentials.accessToken.data}';
    return _client.send(request);
  }

  @override
  void close() {
    _client.close();
  }

  AccessCredentials get accessCredentials => credentials;

  Future<AccessCredentials> refreshCredentials() async {
    // Implement credential refresh logic if needed
    return credentials;
  }

  Future<AccessCredentials> get authHeaders async => credentials;

  List<String> get scopes => _scopes;

@override
Future<http.Response> delete(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
  final request = http.Request('DELETE', url);
  if (headers != null) request.headers.addAll(headers);
  if (body != null) request.body = body.toString();
  final streamedResponse = await send(request);
  return await http.Response.fromStream(streamedResponse);
}

@override
Future<http.Response> get(Uri url, {Map<String, String>? headers}) async {
  final request = http.Request('GET', url);
  if (headers != null) request.headers.addAll(headers);
  final streamedResponse = await send(request);
  return await http.Response.fromStream(streamedResponse);
}

@override
Future<http.Response> head(Uri url, {Map<String, String>? headers}) async {
  final request = http.Request('HEAD', url);
  if (headers != null) request.headers.addAll(headers);
  final streamedResponse = await send(request);
  return await http.Response.fromStream(streamedResponse);
}

@override
Future<http.Response> patch(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
  final request = http.Request('PATCH', url);
  if (headers != null) request.headers.addAll(headers);
  if (body != null) request.body = body.toString();
  final streamedResponse = await send(request);
  return await http.Response.fromStream(streamedResponse);
}

@override
Future<http.Response> post(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
  final request = http.Request('POST', url);
  if (headers != null) request.headers.addAll(headers);
  if (body != null) request.body = body.toString();
  final streamedResponse = await send(request);
  return await http.Response.fromStream(streamedResponse);
}

@override
Future<http.Response> put(Uri url, {Map<String, String>? headers, Object? body, Encoding? encoding}) async {
  final request = http.Request('PUT', url);
  if (headers != null) request.headers.addAll(headers);
  if (body != null) request.body = body.toString();
  final streamedResponse = await send(request);
  return await http.Response.fromStream(streamedResponse);
}

  @override
  Future<String> read(Uri url, {Map<String, String>? headers}) {
    // TODO: implement read
    throw UnimplementedError();
  }

  @override
  Future<Uint8List> readBytes(Uri url, {Map<String, String>? headers}) {
    // TODO: implement readBytes
    throw UnimplementedError();
  }
}