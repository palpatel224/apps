// calendar_service.dart

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;

class CalendarService {
  static final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/calendar',
      'https://www.googleapis.com/auth/calendar.events',
    ],
  );

  static Future<calendar.CalendarApi?> _getCalendarAPI() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      final credentials = AccessCredentials(
        AccessToken(
          'Bearer',
          googleAuth.accessToken!,
          DateTime.now().toUtc().add(const Duration(hours: 1)),
        ),
        googleAuth.idToken,
        ['https://www.googleapis.com/auth/calendar'],
      );

      final client = GoogleHttpClient(credentials);
      return calendar.CalendarApi(client);
    } catch (error) {
      debugPrint('Error getting Calendar API: $error');
      return null;
    }
  }

  static Future<List<calendar.Event>> fetchEvents() async {
    try {
      final calendarApi = await _getCalendarAPI();
      
      if (calendarApi != null) {
        final events = await calendarApi.events.list(
          'primary',
          timeMin: DateTime.now().toUtc(),
          maxResults: 10,
          singleEvents: true,
          orderBy: 'startTime',
        );

        return events.items ?? [];
      }
      return [];
    } catch (error) {
      debugPrint('Error fetching events: $error');
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
      final calendarApi = await _getCalendarAPI();
      
      if (calendarApi != null) {
        final event = calendar.Event()
          ..summary = title
          ..description = description
          ..start = (calendar.EventDateTime()
            ..dateTime = startTime.toUtc()
            ..timeZone = DateTime.now().timeZoneName)
          ..end = (calendar.EventDateTime()
            ..dateTime = endTime.toUtc()
            ..timeZone = DateTime.now().timeZoneName);

        await calendarApi.events.insert(event, 'primary');
        return true;
      }
      return false;
    } catch (error) {
      debugPrint('Error adding event: $error');
      return false;
    }
  }

  static Future<bool> deleteEvent(String eventId) async {
    try {
      final calendarApi = await _getCalendarAPI();
      
      if (calendarApi != null) {
        await calendarApi.events.delete('primary', eventId);
        return true;
      }
      return false;
    } catch (error) {
      debugPrint('Error deleting event: $error');
      return false;
    }
  }

  static Future<bool> updateEvent({
    required String eventId,
    required String title,
    required String description,
    required DateTime startTime,
    required DateTime endTime,
  }) async {
    try {
      final calendarApi = await _getCalendarAPI();
      
      if (calendarApi != null) {
        final event = calendar.Event()
          ..summary = title
          ..description = description
          ..start = (calendar.EventDateTime()
            ..dateTime = startTime.toUtc()
            ..timeZone = DateTime.now().timeZoneName)
          ..end = (calendar.EventDateTime()
            ..dateTime = endTime.toUtc()
            ..timeZone = DateTime.now().timeZoneName);

        await calendarApi.events.update(event, 'primary', eventId);
        return true;
      }
      return false;
    } catch (error) {
      debugPrint('Error updating event: $error');
      return false;
    }
  }
}

class GoogleHttpClient extends http.BaseClient {
  final Map<String, String> _headers;

  GoogleHttpClient(AccessCredentials credentials)
      : _headers = {'Authorization': 'Bearer ${credentials.accessToken.data}'};

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(_headers);
    return request.send();
  }
}