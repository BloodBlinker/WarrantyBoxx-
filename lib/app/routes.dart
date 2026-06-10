/// Centralised route paths and names (Blueprint Section 5.4).
class Routes {
  Routes._();

  static const dashboard = '/';
  static const archive = '/archive';
  static const settings = '/settings';

  static const onboarding = '/onboarding';

  static const itemNew = '/item/new';

  /// Item detail. Deep-link target: `warrantyvault://item/{id}` -> `/item/{id}`.
  static const itemDetail = '/item/:id';
  static String itemDetailPath(String id) => '/item/$id';

  static const itemEdit = '/item/:id/edit';
  static String itemEditPath(String id) => '/item/$id/edit';

  static const categories = '/categories';
  static const templates = '/templates';
  static const export = '/export';
  static const licences = '/settings/licences';
  static const privacyPolicy = '/settings/privacy';
}
