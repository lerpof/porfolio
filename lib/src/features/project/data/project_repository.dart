import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:portfolio/src/features/project/domain/project.dart';
import 'package:portfolio/src/localization/translation_keys.dart';
import 'package:portfolio/src/localization/custom_localization_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'project_repository.g.dart';

@riverpod
ProjectRepository projectRepository(ProjectRepositoryRef ref) {
  return ProjectRepository(ref);
}

class ProjectRepository {
  ProjectRepository(this._ref);

  final Ref _ref;

  List<Project> getProjects() {
    final localizationService = _ref.watch(localizationServiceProvider);
    final jsonProjects = localizationService.translateList(TranslationKeys.projects);
    final projects = jsonProjects.map((jsonProject) {
      return Project.fromJson(jsonProject);
    }).toList();
    return projects;
  }
}
