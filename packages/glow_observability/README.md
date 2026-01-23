# glow_observability

Logging, crash reporting, and performance monitoring for Glow.

## Overview

Provides observability infrastructure to monitor Glow's health, performance, and user experience across all features.

## Features

### **Structured Logging**
- Log levels (debug, info, warning, error, fatal)
- Contextual metadata (user ID, Space ID, feature)
- Log aggregation and search
- Log filtering by level/context

### **Crash Reporting**
- Automatic crash detection
- Stack trace capture
- User context at crash time
- Crash grouping and deduplication
- Integration with Sentry/Firebase Crashlytics

### **Performance Monitoring**
- App startup time
- Route navigation timing
- API request latency
- Frame rendering performance
- Custom performance traces

### **Analytics Events**
- User actions tracking
- Feature usage metrics
- Entry creation analytics
- Space engagement metrics
- Conversion funnels

**Note:** Pure Dart package (no Flutter dependencies).

## Dependencies

- `logging` - Structured logging
- `sentry` - Crash reporting
- `glow_core` - Base types

## Usage

```dart
import 'package:glow_observability/glow_observability.dart';

// Initialize
final logger = Logger('SpacesFeature');
final crashReporter = CrashReporter.instance;

// Log events
logger.info('User joined Space', metadata: {
  'spaceId': space.id,
  'userId': user.id,
});

// Report errors
try {
  await dangerousOperation();
} catch (e, stackTrace) {
  crashReporter.recordError(e, stackTrace, context: {
    'feature': 'spaces',
    'action': 'join',
  });
}

// Track performance
final trace = Performance.startTrace('load_space');
try {
  await loadSpace();
} finally {
  trace.stop();
}
```
