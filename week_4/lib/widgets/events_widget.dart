// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:googleapis/calendar/v3.dart' as calendar;
import 'package:googleapis_auth/auth_io.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:week_4/services/calendar_impl.dart';


class CalendarWidget extends StatefulWidget {
  const CalendarWidget({super.key});

  @override
  _CalendarWidgetState createState() => _CalendarWidgetState();
}

class _CalendarWidgetState extends State<CalendarWidget> {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/calendar',
    ],
  );
  
  List<calendar.Event> _events = [];
  bool _isLoading = false;
  
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void initState() {
    super.initState();
    _checkSignInStatus();
  }

  // Example usage in a widget  
Future<void> _loadEvents() async {
  final events = await CalendarService.fetchEvents();
  setState(() {
    _events = events;
  });
}

Future<void> _addNewEvent() async {
  final success = await CalendarService.addEvent(
    title: 'Meeting',
    description: 'Team sync',
    startTime: DateTime.now(),
    endTime: DateTime.now().add(const Duration(hours: 1)),
  );
  
  if (success) {
    // Show success message
  } else {
    // Show error message
  }
}

  Future<void> _checkSignInStatus() async {
    try {
      final isSignedIn = await _googleSignIn.isSignedIn();
      if (isSignedIn) {
        await _fetchEvents();
      }
    } catch (error) {
      print('Error checking sign-in status: $error');
    }
  }

  Future<void> _handleSignIn() async {
    try {
      setState(() => _isLoading = true);
      final account = await _googleSignIn.signIn();
      if (account != null) {
        await _fetchEvents();
      }
    } catch (error) {
      print('Error signing in: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to sign in with Google')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _fetchEvents() async {
    try {
      setState(() => _isLoading = true);
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      
      if (googleAuth != null) {
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
        final calendarApi = calendar.CalendarApi(client);
        
        final calendarEvents = await calendarApi.events.list(
          'primary',
          timeMin: DateTime.now().toUtc(),
          maxResults: 10,
          singleEvents: true,
          orderBy: 'startTime',
        );

        setState(() {
          _events = calendarEvents.items ?? [];
        });
      }
    } catch (error) {
      print('Error fetching events: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to fetch calendar events')),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _addEvent() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      
      if (googleAuth != null) {
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
        final calendarApi = calendar.CalendarApi(client);

        // Create start and end times with proper timezone handling
        final eventStartTime = DateTime(
          _selectedDate.year,
          _selectedDate.month,
          _selectedDate.day,
          _selectedTime.hour,
          _selectedTime.minute,
        );

        final eventEndTime = eventStartTime.add(const Duration(hours: 1));

        // Format the dates according to RFC3339
        final startTimeFormatted = eventStartTime.toUtc().toIso8601String();
        final endTimeFormatted = eventEndTime.toUtc().toIso8601String();

        final event = calendar.Event()
          ..summary = _titleController.text
          ..description = _descriptionController.text
          ..start = (calendar.EventDateTime()
            ..dateTime = DateTime.parse(startTimeFormatted)
            ..timeZone = DateTime.now().timeZoneName)
          ..end = (calendar.EventDateTime()
            ..dateTime = DateTime.parse(endTimeFormatted)
            ..timeZone = DateTime.now().timeZoneName);

        await calendarApi.events.insert(event, 'primary');
        await _fetchEvents();
        
        _titleController.clear();
        _descriptionController.clear();
        
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Event added successfully')),
        );
      }
    } catch (error) {
      print('Error adding event: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Failed to add event')),
      );
    }
  }

  String _formatEventTime(calendar.EventDateTime? eventDateTime) {
    if (eventDateTime?.dateTime != null) {
      return DateFormat('MMM dd, yyyy hh:mm a').format(eventDateTime!.dateTime!.toLocal());
    }
    return 'No time specified';
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Calendar Events'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _fetchEvents,
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Column(
              children: [
                if (_googleSignIn.currentUser == null)
                  Center(
                    child: ElevatedButton(
                      onPressed: _handleSignIn,
                      child: const Text('Sign in with Google'),
                    ),
                  )
                else
                  Expanded(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              TextField(
                                controller: _titleController,
                                decoration: const InputDecoration(
                                  labelText: 'Event Title',
                                ),
                              ),
                              TextField(
                                controller: _descriptionController,
                                decoration: const InputDecoration(
                                  labelText: 'Event Description',
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: [
                                  TextButton(
                                    onPressed: _selectDate,
                                    child: Text(
                                      'Date: ${DateFormat('MMM dd, yyyy').format(_selectedDate)}',
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: _selectTime,
                                    child: Text(
                                      'Time: ${_selectedTime.format(context)}',
                                    ),
                                  ),
                                ],
                              ),
                              ElevatedButton(
                                onPressed: _addEvent,
                                child: const Text('Add Event'),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: _events.length,
                            itemBuilder: (context, index) {
                              final event = _events[index];
                              return ListTile(
                                title: Text(event.summary ?? 'No Title'),
                                subtitle: Text(
                                  event.description ?? 'No Description',
                                ),
                                trailing: Text(
                                  _formatEventTime(event.start),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
    );
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