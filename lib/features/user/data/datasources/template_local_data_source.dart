import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/errors/exceptions.dart';
import '../../../../service_locator.dart';
import '../models/template_model.dart';

abstract class TemplateLocalDataSource {
  Future<void> cacheTemplate({required TemplateModel? templateToCache});
  Future<TemplateModel> getLastTemplate();
}



class TemplateLocalDataSourceImpl implements TemplateLocalDataSource {

  TemplateLocalDataSourceImpl();

  @override
  Future<TemplateModel> getLastTemplate() {
    final jsonString = sl<SharedPreferences>().getString(cachedTemplate);

    if (jsonString != null) {
      return Future.value(TemplateModel.fromJson(json: json.decode(jsonString)));
    } else {
      throw CacheException();
    }

  }

  @override
  Future<void> cacheTemplate({required TemplateModel? templateToCache}) async  {
      if (templateToCache != null) {
        sl<SharedPreferences>().setString(
          cachedTemplate,
          json.encode(
            templateToCache.toJson(),
          ),
        );
      } else {
        throw CacheException();
      }
    
  }
}
