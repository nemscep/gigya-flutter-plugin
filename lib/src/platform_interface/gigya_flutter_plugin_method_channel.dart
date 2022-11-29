import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import '../models/enums/methods.dart';
import '../models/enums/social_provider.dart';
import '../models/gigya_error.dart';
import '../models/screenset_event.dart';
import 'gigya_flutter_plugin_platform_interface.dart';

/// An implementation of [GigyaFlutterPluginPlatform] that uses method channels.
class MethodChannelGigyaFlutterPlugin extends GigyaFlutterPluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final MethodChannel methodChannel = const MethodChannel(
    'gigya_flutter_plugin',
  );

  /// The event channel that provides the stream of screen set events.
  @visibleForTesting
  final EventChannel screenSetEvents = const EventChannel('screensetEvents');

  @override
  Future<Map<String, dynamic>> addConnection(SocialProvider provider) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.addConnection.methodName,
        <String, dynamic>{'provider': provider.name},
      ).timeout(
        Methods.addConnection.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> forgotPassword(String loginId) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.forgotPassword.methodName,
        <String, dynamic>{'loginId': loginId},
      ).timeout(
        Methods.forgotPassword.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> getAccount({
    bool invalidate = false,
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.getAccount.methodName,
        <String, dynamic>{
          'invalidate': invalidate,
          'parameters': parameters,
        },
      ).timeout(
        Methods.getAccount.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> getSession() async {
    try {
      final Map<String, dynamic>? result = await methodChannel
          .invokeMapMethod<String, dynamic>(Methods.getSession.methodName)
          .timeout(
            Methods.getSession.timeout,
            onTimeout: () => throw const GigyaTimeoutError(),
          );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> initSdk(
    String apiKey,
    String apiDomain, {
    bool forceLogout = true,
  }) async {
    try {
      if (forceLogout) {
        await logout();
      }

      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.initSdk.methodName,
        <String, dynamic>{
          'apiKey': apiKey,
          'apiDomain': apiDomain,
        },
      ).timeout(
        Methods.initSdk.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      final bool? result = await methodChannel.invokeMethod<bool>(
        Methods.isLoggedIn.methodName,
      );

      return result ?? false;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> linkToSite(
    String loginId,
    String password,
  ) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.linkToSite.methodName,
        <String, dynamic>{
          'loginId': loginId,
          'password': password,
        },
      ).timeout(
        Methods.linkToSite.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> login(
    String loginId,
    String password, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.loginWithCredentials.methodName,
        <String, dynamic>{
          'loginId': loginId,
          'password': password,
          'parameters': parameters,
        },
      ).timeout(
        Methods.loginWithCredentials.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<void> logout() async {
    try {
      await methodChannel.invokeMethod<void>(Methods.logOut.methodName).timeout(
            Methods.logOut.timeout,
            onTimeout: () => throw const GigyaTimeoutError(),
          );
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> register(
    String loginId,
    String password, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.registerWithCredentials.methodName,
        <String, dynamic>{
          'email': loginId,
          'password': password,
          'parameters': parameters,
        },
      ).timeout(
        Methods.registerWithCredentials.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> removeConnection(SocialProvider provider) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.removeConnection.methodName,
        <String, dynamic>{'provider': provider.name},
      ).timeout(
        Methods.removeConnection.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> send(
    String endpoint, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final String? json = await methodChannel.invokeMethod<String>(
        Methods.sendRequest.methodName,
        <String, dynamic>{
          'endpoint': endpoint,
          'parameters': parameters,
        },
      ).timeout(
        Methods.sendRequest.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      if (json == null) {
        return const <String, dynamic>{};
      }

      return jsonDecode(json) as Map<String, dynamic>;
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> setAccount(Map<String, dynamic> account) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.setAccount.methodName,
        <String, dynamic>{'account': account},
      ).timeout(
        Methods.setAccount.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<void> setSession(
    int expiresIn,
    String sessionToken,
    String sessionSecret,
  ) {
    try {
      return methodChannel.invokeMethod<void>(
        Methods.setSession.methodName,
        <String, dynamic>{
          'sessionToken': sessionToken,
          'sessionSecret': sessionSecret,
          'expires_in': expiresIn,
        },
      ).timeout(
        Methods.setSession.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Stream<ScreensetEvent> showScreenSet(
    String name, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async* {
    try {
      await methodChannel.invokeMethod<void>(
        Methods.showScreenSet.methodName,
        <String, dynamic>{
          'screenSet': name,
          'parameters': parameters,
        },
      );
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }

    yield* screenSetEvents.receiveBroadcastStream().map((dynamic event) {
      final Map<String, dynamic> eventData = event as Map<String, dynamic>;

      return ScreensetEvent(eventData['event'] as String, eventData['data']);
    });
  }

  @override
  Future<Map<String, dynamic>> socialLogin(
    SocialProvider provider, {
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.socialLogin.methodName,
        <String, dynamic>{
          'provider': provider.name,
          'parameters': parameters,
        },
      ).timeout(
        Methods.socialLogin.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }

  @override
  Future<Map<String, dynamic>> sso({
    Map<String, dynamic> parameters = const <String, dynamic>{},
  }) async {
    try {
      final Map<String, dynamic>? result =
          await methodChannel.invokeMapMethod<String, dynamic>(
        Methods.sso.methodName,
        <String, dynamic>{
          'provider': 'sso',
          'parameters': parameters,
        },
      ).timeout(
        Methods.sso.timeout,
        onTimeout: () => throw const GigyaTimeoutError(),
      );

      return result ?? const <String, dynamic>{};
    } on PlatformException catch (exception) {
      throw GigyaError.fromPlatformException(exception);
    }
  }
}
