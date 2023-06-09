// Mocks generated by Mockito 5.4.0 from annotations
// in hw2/test/events/displayEvent_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i5;
import 'dart:ui' as _i6;

import 'package:flutter/material.dart' as _i4;
import 'package:hw2/models/event.dart' as _i2;
import 'package:hw2/models/event_view_model.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeEvent_0 extends _i1.SmartFake implements _i2.Event {
  _FakeEvent_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [MyEventsViewModel].
///
/// See the documentation for Mockito's code generation for more information.
class MockMyEventsViewModel extends _i1.Mock implements _i3.MyEventsViewModel {
  MockMyEventsViewModel() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i2.Event> get eventsList => (super.noSuchMethod(
        Invocation.getter(#eventsList),
        returnValue: <_i2.Event>[],
      ) as List<_i2.Event>);
  @override
  int get eventsListSize => (super.noSuchMethod(
        Invocation.getter(#eventsListSize),
        returnValue: 0,
      ) as int);
  @override
  List<_i2.Event> get events => (super.noSuchMethod(
        Invocation.getter(#events),
        returnValue: <_i2.Event>[],
      ) as List<_i2.Event>);
  @override
  bool get showOnlyUpcoming => (super.noSuchMethod(
        Invocation.getter(#showOnlyUpcoming),
        returnValue: false,
      ) as bool);
  @override
  set showOnlyUpcoming(bool? value) => super.noSuchMethod(
        Invocation.setter(
          #showOnlyUpcoming,
          value,
        ),
        returnValueForMissingStub: null,
      );
  @override
  bool get hasListeners => (super.noSuchMethod(
        Invocation.getter(#hasListeners),
        returnValue: false,
      ) as bool);
  @override
  _i2.Event getEvent(int? index) => (super.noSuchMethod(
        Invocation.method(
          #getEvent,
          [index],
        ),
        returnValue: _FakeEvent_0(
          this,
          Invocation.method(
            #getEvent,
            [index],
          ),
        ),
      ) as _i2.Event);
  @override
  List<_i2.Event> getSortedEventsByStartDate() => (super.noSuchMethod(
        Invocation.method(
          #getSortedEventsByStartDate,
          [],
        ),
        returnValue: <_i2.Event>[],
      ) as List<_i2.Event>);
  @override
  void addEvent(_i2.Event? event) => super.noSuchMethod(
        Invocation.method(
          #addEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void clearNewEvent() => super.noSuchMethod(
        Invocation.method(
          #clearNewEvent,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void deleteEvent(_i2.Event? event) => super.noSuchMethod(
        Invocation.method(
          #deleteEvent,
          [event],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void updateEvent(
    _i2.Event? event,
    _i2.Event? updatedEvent,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #updateEvent,
          [
            event,
            updatedEvent,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void editEventDate(
    _i4.BuildContext? context,
    _i2.Event? event,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #editEventDate,
          [
            context,
            event,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void showEventDetails(
    _i4.BuildContext? context,
    _i2.Event? event,
  ) =>
      super.noSuchMethod(
        Invocation.method(
          #showEventDetails,
          [
            context,
            event,
          ],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Future<_i2.Event?> showNewEventForm(_i4.BuildContext? context) =>
      (super.noSuchMethod(
        Invocation.method(
          #showNewEventForm,
          [context],
        ),
        returnValue: _i5.Future<_i2.Event?>.value(),
      ) as _i5.Future<_i2.Event?>);
  @override
  void loadEvents() => super.noSuchMethod(
        Invocation.method(
          #loadEvents,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void addListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #addListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void removeListener(_i6.VoidCallback? listener) => super.noSuchMethod(
        Invocation.method(
          #removeListener,
          [listener],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void dispose() => super.noSuchMethod(
        Invocation.method(
          #dispose,
          [],
        ),
        returnValueForMissingStub: null,
      );
  @override
  void notifyListeners() => super.noSuchMethod(
        Invocation.method(
          #notifyListeners,
          [],
        ),
        returnValueForMissingStub: null,
      );
}
