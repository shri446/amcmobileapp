
import 'package:get_storage/get_storage.dart';

import 'oauth2_dio.dart';

class OAuthSecureStorage extends OAuthStorage {
  // late final FlutterSecureStorage storage;
  final storage=GetStorage();
  static final String accessTokenKey = 'accessToken';
  static final String refreshTokenKey = 'refreshToken';
  static final String expirationKey = 'expiration';
  static final String scopeKey = 'scope';
  static final String drawingGroupsKey = 'drawingGroups';
  static final String stationIdsKey = 'stationIds';
  static final String profileInfoKey = 'profileInfo';

  @override
  Future<OAuthToken> fetch() async {
    return OAuthToken(
        accessToken: await storage.read(accessTokenKey),
        refreshToken: await storage.read(refreshTokenKey),
        scope: await storage.read(scopeKey),
        drawings: await storage.read(drawingGroupsKey),
        stationIds: await storage.read(stationIdsKey),
        profileInfo: await storage.read(profileInfoKey),
        expiration: DateTime.fromMillisecondsSinceEpoch(await storage.read(expirationKey) ?? 0 ));

    /*return OAuthToken.fromMap ({
      "access_token": await storage.read(accessTokenKey),
      "refresh_token": await storage.read(refreshTokenKey),
      "expires": await storage.read(expires) // a integer
    });*/
  }

  @override
  Future<OAuthToken> save(OAuthToken token) async {
    await storage.write(accessTokenKey,  token.accessToken);
    await storage.write( refreshTokenKey, token.refreshToken);
    await storage.write( expirationKey,token.expiration!.millisecondsSinceEpoch);
    await storage.write( scopeKey,token.scope);
    await storage.write( drawingGroupsKey,token.drawings);
    await storage.write( stationIdsKey,token.stationIds);
    await storage.write(profileInfoKey, token.profileInfo);
    return token;
  }

  Future<void> clear() async {
    await storage.remove( accessTokenKey);
    await storage.remove( refreshTokenKey);
    await storage.remove( expirationKey);
    await storage.remove( scopeKey);
    await storage.remove( drawingGroupsKey);
    await storage.remove( stationIdsKey);
    await storage.remove( profileInfoKey);
  }
}