import '../models/template_model.dart';

abstract class TemplateLocalDataSource {
  Future<void> cacheTemplate();
  // {required TemplateModel? templateToCache}
  Future<TemplateModel> getLastTemplate();
}

const cachedTemplate = 'CACHED_TEMPLATE';

class TemplateLocalDataSourceImpl implements TemplateLocalDataSource {
  //final SharedPreferencesWithCache   sharedPreferences;

  TemplateLocalDataSourceImpl();
  //{required this.sharedPreferences}

  @override
  Future<TemplateModel> getLastTemplate() {
    //final jsonString = sharedPreferences.getString(cachedTemplate);

    // if (jsonString != null) {
    //   return Future.value(TemplateModel.fromJson(json: json.decode(jsonString)));
    // } else {
    //   throw CacheException();
    // }
    return Future.value(TemplateModel(template: ""));
  }

  @override
  Future<void> cacheTemplate() async { // {required TemplateModel? templateToCache}
    //   if (templateToCache != null) {
    //     sharedPreferences.setString(
    //       cachedTemplate,
    //       json.encode(
    //         templateToCache.toJson(),
    //       ),
    //     );
    //   } else {
    //     throw CacheException();
    //   }
    
  }
}
