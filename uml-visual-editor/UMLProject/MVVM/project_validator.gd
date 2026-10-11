# project_validator.gd
# ProjectValidator
# “当前状态有什么问题？”
class_name ProjectValidator
extends RefCounted


static func validate(project: UMLProject) -> Array[ProjectIssue]:
	var issues: Array[ProjectIssue] = []

	issues.append_array(
		_validate_duplicate_class_names(project)
	)

	#issues.append_array(
		#_validate_relationship_endpoints(project)
	#)

	return issues

static func _validate_duplicate_class_names(
	project: UMLProject
) -> Array[ProjectIssue]:
	var issues: Array[ProjectIssue] = []

	var classes_by_name: Dictionary = {}

	for uml_class in project.uml_classes:
		if not classes_by_name.has(uml_class.name):
			classes_by_name[uml_class.name] = []

		classes_by_name[uml_class.name].append(
			uml_class
		)

	for name in classes_by_name:
		var duplicates: Array = classes_by_name[name]

		if duplicates.size() <= 1:
			continue

		var issue := ProjectIssue.new(
			ProjectIssue.Type.DUPLICATE_NAME,
			ProjectIssue.Severity.WARNING,
			duplicates,
			"Multiple classes have the name '%s'." % name
		)

		issue.metadata["name"] = name
		issue.metadata["count"] = duplicates.size()
		#issue.metadata["scope"] = "project" # 重名的范围

		issues.append(issue)

	return issues

#func _validate_relationship_endpoints(
	#project: UMLProject
#) -> Array[ProjectIssue]:
#
	#var issues: Array[ProjectIssue] = []
#
	#for relationship in project.relationships:
#
		#var source_exists := (
			#relationship.source != null
			#and relationship.source in project.classes
		#)
#
		#var target_exists := (
			#relationship.target != null
			#and relationship.target in project.classes
		#)
#
		#if not source_exists:
			#issues.append(
				#ProjectIssue.new(
					#ProjectIssue.Type.MISSING_RELATION_ENDPOINT,
					#ProjectIssue.Severity.WARNING,
					#[relationship],
					#"Relationship source class is missing."
				#)
			#)
#
		#if not target_exists:
			#issues.append(
				#ProjectIssue.new(
					#ProjectIssue.Type.MISSING_RELATION_ENDPOINT,
					#ProjectIssue.Severity.WARNING,
					#[relationship],
					#"Relationship target class is missing."
				#)
			#)
#
	#return issues
