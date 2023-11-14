# anitection

## Tables

| Name                                                                                                            | Columns | Comment | Type       |
| --------------------------------------------------------------------------------------------------------------- | ------- | ------- | ---------- |
| [public.strapi_migrations](public.strapi_migrations.md)                                                         | 3       |         | BASE TABLE |
| [public.strapi_database_schema](public.strapi_database_schema.md)                                               | 4       |         | BASE TABLE |
| [public.strapi_core_store_settings](public.strapi_core_store_settings.md)                                       | 6       |         | BASE TABLE |
| [public.strapi_webhooks](public.strapi_webhooks.md)                                                             | 6       |         | BASE TABLE |
| [public.admin_permissions](public.admin_permissions.md)                                                         | 10      |         | BASE TABLE |
| [public.admin_users](public.admin_users.md)                                                                     | 15      |         | BASE TABLE |
| [public.admin_roles](public.admin_roles.md)                                                                     | 8       |         | BASE TABLE |
| [public.strapi_api_tokens](public.strapi_api_tokens.md)                                                         | 12      |         | BASE TABLE |
| [public.strapi_api_token_permissions](public.strapi_api_token_permissions.md)                                   | 6       |         | BASE TABLE |
| [public.strapi_transfer_tokens](public.strapi_transfer_tokens.md)                                               | 11      |         | BASE TABLE |
| [public.strapi_transfer_token_permissions](public.strapi_transfer_token_permissions.md)                         | 6       |         | BASE TABLE |
| [public.files](public.files.md)                                                                                 | 20      |         | BASE TABLE |
| [public.upload_folders](public.upload_folders.md)                                                               | 8       |         | BASE TABLE |
| [public.i18n_locale](public.i18n_locale.md)                                                                     | 7       |         | BASE TABLE |
| [public.up_permissions](public.up_permissions.md)                                                               | 6       |         | BASE TABLE |
| [public.up_roles](public.up_roles.md)                                                                           | 8       |         | BASE TABLE |
| [public.up_users](public.up_users.md)                                                                           | 14      |         | BASE TABLE |
| [public.animals](public.animals.md)                                                                             | 12      |         | BASE TABLE |
| [public.animal_kinds](public.animal_kinds.md)                                                                   | 7       |         | BASE TABLE |
| [public.animal_logs](public.animal_logs.md)                                                                     | 7       |         | BASE TABLE |
| [public.employees](public.employees.md)                                                                         | 6       |         | BASE TABLE |
| [public.favorites](public.favorites.md)                                                                         | 6       |         | BASE TABLE |
| [public.institutions](public.institutions.md)                                                                   | 12      |         | BASE TABLE |
| [public.messages](public.messages.md)                                                                           | 7       |         | BASE TABLE |
| [public.notifications](public.notifications.md)                                                                 | 7       |         | BASE TABLE |
| [public.tasks](public.tasks.md)                                                                                 | 8       |         | BASE TABLE |
| [public.timelines](public.timelines.md)                                                                         | 8       |         | BASE TABLE |
| [public.admin_permissions_role_links](public.admin_permissions_role_links.md)                                   | 4       |         | BASE TABLE |
| [public.admin_users_roles_links](public.admin_users_roles_links.md)                                             | 5       |         | BASE TABLE |
| [public.strapi_api_token_permissions_token_links](public.strapi_api_token_permissions_token_links.md)           | 4       |         | BASE TABLE |
| [public.strapi_transfer_token_permissions_token_links](public.strapi_transfer_token_permissions_token_links.md) | 4       |         | BASE TABLE |
| [public.files_related_morphs](public.files_related_morphs.md)                                                   | 6       |         | BASE TABLE |
| [public.files_folder_links](public.files_folder_links.md)                                                       | 4       |         | BASE TABLE |
| [public.upload_folders_parent_links](public.upload_folders_parent_links.md)                                     | 4       |         | BASE TABLE |
| [public.up_permissions_role_links](public.up_permissions_role_links.md)                                         | 4       |         | BASE TABLE |
| [public.up_users_role_links](public.up_users_role_links.md)                                                     | 4       |         | BASE TABLE |
| [public.employees_institution_links](public.employees_institution_links.md)                                     | 3       |         | BASE TABLE |
| [public.favorites_user_links](public.favorites_user_links.md)                                                   | 3       |         | BASE TABLE |
| [public.messages_institution_links](public.messages_institution_links.md)                                       | 3       |         | BASE TABLE |
| [public.messages_user_links](public.messages_user_links.md)                                                     | 3       |         | BASE TABLE |
| [public.notifications_user_links](public.notifications_user_links.md)                                           | 3       |         | BASE TABLE |
| [public.tasks_employee_links](public.tasks_employee_links.md)                                                   | 3       |         | BASE TABLE |
| [public.tasks_institution_links](public.tasks_institution_links.md)                                             | 3       |         | BASE TABLE |
| [public.timelines_user_links](public.timelines_user_links.md)                                                   | 3       |         | BASE TABLE |
| [public.animal_kinds_animal_links](public.animal_kinds_animal_links.md)                                         | 3       |         | BASE TABLE |
| [public.animal_logs_animal_links](public.animal_logs_animal_links.md)                                           | 3       |         | BASE TABLE |
| [public.employees_user_links](public.employees_user_links.md)                                                   | 3       |         | BASE TABLE |
| [public.favorites_animal_links](public.favorites_animal_links.md)                                               | 3       |         | BASE TABLE |

## Relations

```mermaid
erDiagram

"public.admin_permissions" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.admin_permissions" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.admin_users" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.admin_users" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.admin_roles" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.admin_roles" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.strapi_api_tokens" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.strapi_api_tokens" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.strapi_api_token_permissions" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.strapi_api_token_permissions" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.strapi_transfer_tokens" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.strapi_transfer_tokens" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.strapi_transfer_token_permissions" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.strapi_transfer_token_permissions" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.files" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.files" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.upload_folders" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.upload_folders" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.i18n_locale" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.i18n_locale" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.up_permissions" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.up_permissions" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.up_roles" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.up_roles" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.up_users" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.up_users" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.animals" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.animals" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.animal_kinds" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.animal_kinds" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.animal_logs" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.animal_logs" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.employees" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.employees" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.favorites" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.favorites" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.institutions" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.institutions" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.messages" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.messages" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.notifications" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.notifications" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.tasks" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.tasks" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.timelines" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.timelines" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.admin_permissions_role_links" }o--o| "public.admin_permissions" : "FOREIGN KEY (permission_id) REFERENCES admin_permissions(id) ON DELETE CASCADE"
"public.admin_permissions_role_links" }o--o| "public.admin_roles" : "FOREIGN KEY (role_id) REFERENCES admin_roles(id) ON DELETE CASCADE"
"public.admin_users_roles_links" }o--o| "public.admin_users" : "FOREIGN KEY (user_id) REFERENCES admin_users(id) ON DELETE CASCADE"
"public.admin_users_roles_links" }o--o| "public.admin_roles" : "FOREIGN KEY (role_id) REFERENCES admin_roles(id) ON DELETE CASCADE"
"public.strapi_api_token_permissions_token_links" }o--o| "public.strapi_api_tokens" : "FOREIGN KEY (api_token_id) REFERENCES strapi_api_tokens(id) ON DELETE CASCADE"
"public.strapi_api_token_permissions_token_links" }o--o| "public.strapi_api_token_permissions" : "FOREIGN KEY (api_token_permission_id) REFERENCES strapi_api_token_permissions(id) ON DELETE CASCADE"
"public.strapi_transfer_token_permissions_token_links" }o--o| "public.strapi_transfer_tokens" : "FOREIGN KEY (transfer_token_id) REFERENCES strapi_transfer_tokens(id) ON DELETE CASCADE"
"public.strapi_transfer_token_permissions_token_links" }o--o| "public.strapi_transfer_token_permissions" : "FOREIGN KEY (transfer_token_permission_id) REFERENCES strapi_transfer_token_permissions(id) ON DELETE CASCADE"
"public.files_related_morphs" }o--o| "public.files" : "FOREIGN KEY (file_id) REFERENCES files(id) ON DELETE CASCADE"
"public.files_folder_links" }o--o| "public.files" : "FOREIGN KEY (file_id) REFERENCES files(id) ON DELETE CASCADE"
"public.files_folder_links" }o--o| "public.upload_folders" : "FOREIGN KEY (folder_id) REFERENCES upload_folders(id) ON DELETE CASCADE"
"public.upload_folders_parent_links" }o--o| "public.upload_folders" : "FOREIGN KEY (folder_id) REFERENCES upload_folders(id) ON DELETE CASCADE"
"public.upload_folders_parent_links" }o--o| "public.upload_folders" : "FOREIGN KEY (inv_folder_id) REFERENCES upload_folders(id) ON DELETE CASCADE"
"public.up_permissions_role_links" }o--o| "public.up_permissions" : "FOREIGN KEY (permission_id) REFERENCES up_permissions(id) ON DELETE CASCADE"
"public.up_permissions_role_links" }o--o| "public.up_roles" : "FOREIGN KEY (role_id) REFERENCES up_roles(id) ON DELETE CASCADE"
"public.up_users_role_links" }o--o| "public.up_roles" : "FOREIGN KEY (role_id) REFERENCES up_roles(id) ON DELETE CASCADE"
"public.up_users_role_links" }o--o| "public.up_users" : "FOREIGN KEY (user_id) REFERENCES up_users(id) ON DELETE CASCADE"
"public.employees_institution_links" }o--o| "public.employees" : "FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE"
"public.employees_institution_links" }o--o| "public.institutions" : "FOREIGN KEY (institution_id) REFERENCES institutions(id) ON DELETE CASCADE"
"public.favorites_user_links" }o--o| "public.up_users" : "FOREIGN KEY (user_id) REFERENCES up_users(id) ON DELETE CASCADE"
"public.favorites_user_links" }o--o| "public.favorites" : "FOREIGN KEY (favorite_id) REFERENCES favorites(id) ON DELETE CASCADE"
"public.messages_institution_links" }o--o| "public.institutions" : "FOREIGN KEY (institution_id) REFERENCES institutions(id) ON DELETE CASCADE"
"public.messages_institution_links" }o--o| "public.messages" : "FOREIGN KEY (message_id) REFERENCES messages(id) ON DELETE CASCADE"
"public.messages_user_links" }o--o| "public.up_users" : "FOREIGN KEY (user_id) REFERENCES up_users(id) ON DELETE CASCADE"
"public.messages_user_links" }o--o| "public.messages" : "FOREIGN KEY (message_id) REFERENCES messages(id) ON DELETE CASCADE"
"public.notifications_user_links" }o--o| "public.up_users" : "FOREIGN KEY (user_id) REFERENCES up_users(id) ON DELETE CASCADE"
"public.notifications_user_links" }o--o| "public.notifications" : "FOREIGN KEY (notification_id) REFERENCES notifications(id) ON DELETE CASCADE"
"public.tasks_employee_links" }o--o| "public.employees" : "FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE"
"public.tasks_employee_links" }o--o| "public.tasks" : "FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE"
"public.tasks_institution_links" }o--o| "public.institutions" : "FOREIGN KEY (institution_id) REFERENCES institutions(id) ON DELETE CASCADE"
"public.tasks_institution_links" }o--o| "public.tasks" : "FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE"
"public.timelines_user_links" }o--o| "public.up_users" : "FOREIGN KEY (user_id) REFERENCES up_users(id) ON DELETE CASCADE"
"public.timelines_user_links" }o--o| "public.timelines" : "FOREIGN KEY (timeline_id) REFERENCES timelines(id) ON DELETE CASCADE"
"public.animal_kinds_animal_links" }o--o| "public.animals" : "FOREIGN KEY (animal_id) REFERENCES animals(id) ON DELETE CASCADE"
"public.animal_kinds_animal_links" }o--o| "public.animal_kinds" : "FOREIGN KEY (animal_kind_id) REFERENCES animal_kinds(id) ON DELETE CASCADE"
"public.animal_logs_animal_links" }o--o| "public.animals" : "FOREIGN KEY (animal_id) REFERENCES animals(id) ON DELETE CASCADE"
"public.animal_logs_animal_links" }o--o| "public.animal_logs" : "FOREIGN KEY (animal_log_id) REFERENCES animal_logs(id) ON DELETE CASCADE"
"public.employees_user_links" }o--o| "public.up_users" : "FOREIGN KEY (user_id) REFERENCES up_users(id) ON DELETE CASCADE"
"public.employees_user_links" }o--o| "public.employees" : "FOREIGN KEY (employee_id) REFERENCES employees(id) ON DELETE CASCADE"
"public.favorites_animal_links" }o--o| "public.animals" : "FOREIGN KEY (animal_id) REFERENCES animals(id) ON DELETE CASCADE"
"public.favorites_animal_links" }o--o| "public.favorites" : "FOREIGN KEY (favorite_id) REFERENCES favorites(id) ON DELETE CASCADE"

"public.strapi_migrations" {
  integer id
  varchar_255_ name
  timestamp_without_time_zone time
}
"public.strapi_database_schema" {
  integer id
  json schema
  timestamp_without_time_zone time
  varchar_255_ hash
}
"public.strapi_core_store_settings" {
  integer id
  varchar_255_ key
  text value
  varchar_255_ type
  varchar_255_ environment
  varchar_255_ tag
}
"public.strapi_webhooks" {
  integer id
  varchar_255_ name
  text url
  jsonb headers
  jsonb events
  boolean enabled
}
"public.admin_permissions" {
  integer id
  varchar_255_ action
  jsonb action_parameters
  varchar_255_ subject
  jsonb properties
  jsonb conditions
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.admin_users" {
  integer id
  varchar_255_ firstname
  varchar_255_ lastname
  varchar_255_ username
  varchar_255_ email
  varchar_255_ password
  varchar_255_ reset_password_token
  varchar_255_ registration_token
  boolean is_active
  boolean blocked
  varchar_255_ prefered_language
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.admin_roles" {
  integer id
  varchar_255_ name
  varchar_255_ code
  varchar_255_ description
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.strapi_api_tokens" {
  integer id
  varchar_255_ name
  varchar_255_ description
  varchar_255_ type
  varchar_255_ access_key
  timestamp_6__without_time_zone last_used_at
  timestamp_6__without_time_zone expires_at
  bigint lifespan
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.strapi_api_token_permissions" {
  integer id
  varchar_255_ action
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.strapi_transfer_tokens" {
  integer id
  varchar_255_ name
  varchar_255_ description
  varchar_255_ access_key
  timestamp_6__without_time_zone last_used_at
  timestamp_6__without_time_zone expires_at
  bigint lifespan
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.strapi_transfer_token_permissions" {
  integer id
  varchar_255_ action
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.files" {
  integer id
  varchar_255_ name
  varchar_255_ alternative_text
  varchar_255_ caption
  integer width
  integer height
  jsonb formats
  varchar_255_ hash
  varchar_255_ ext
  varchar_255_ mime
  numeric_10_2_ size
  varchar_255_ url
  varchar_255_ preview_url
  varchar_255_ provider
  jsonb provider_metadata
  varchar_255_ folder_path
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.upload_folders" {
  integer id
  varchar_255_ name
  integer path_id
  varchar_255_ path
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.i18n_locale" {
  integer id
  varchar_255_ name
  varchar_255_ code
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.up_permissions" {
  integer id
  varchar_255_ action
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.up_roles" {
  integer id
  varchar_255_ name
  varchar_255_ description
  varchar_255_ type
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.up_users" {
  integer id
  varchar_255_ username
  varchar_255_ email
  varchar_255_ provider
  varchar_255_ password
  varchar_255_ reset_password_token
  varchar_255_ confirmation_token
  boolean confirmed
  boolean blocked
  boolean employee
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.animals" {
  integer id
  varchar_255_ name
  integer age
  varchar_255_ gender
  text personality
  varchar_255_ interest
  text description
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.animal_kinds" {
  integer id
  varchar_255_ name
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.animal_logs" {
  integer id
  varchar_255_ content
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.employees" {
  integer id
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.favorites" {
  integer id
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.institutions" {
  integer id
  varchar_255_ name
  varchar_255_ address
  varchar_255_ phone
  varchar_255_ website_url
  varchar_255_ needs_url
  text description
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.messages" {
  integer id
  text content
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.notifications" {
  integer id
  varchar_255_ content
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.tasks" {
  integer id
  varchar_255_ title
  text content
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.timelines" {
  integer id
  text content
  integer footprints
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.admin_permissions_role_links" {
  integer id
  integer permission_id FK
  integer role_id FK
  double_precision permission_order
}
"public.admin_users_roles_links" {
  integer id
  integer user_id FK
  integer role_id FK
  double_precision role_order
  double_precision user_order
}
"public.strapi_api_token_permissions_token_links" {
  integer id
  integer api_token_permission_id FK
  integer api_token_id FK
  double_precision api_token_permission_order
}
"public.strapi_transfer_token_permissions_token_links" {
  integer id
  integer transfer_token_permission_id FK
  integer transfer_token_id FK
  double_precision transfer_token_permission_order
}
"public.files_related_morphs" {
  integer id
  integer file_id FK
  integer related_id
  varchar_255_ related_type
  varchar_255_ field
  double_precision order
}
"public.files_folder_links" {
  integer id
  integer file_id FK
  integer folder_id FK
  double_precision file_order
}
"public.upload_folders_parent_links" {
  integer id
  integer folder_id FK
  integer inv_folder_id FK
  double_precision folder_order
}
"public.up_permissions_role_links" {
  integer id
  integer permission_id FK
  integer role_id FK
  double_precision permission_order
}
"public.up_users_role_links" {
  integer id
  integer user_id FK
  integer role_id FK
  double_precision user_order
}
"public.employees_institution_links" {
  integer id
  integer employee_id FK
  integer institution_id FK
}
"public.favorites_user_links" {
  integer id
  integer favorite_id FK
  integer user_id FK
}
"public.messages_institution_links" {
  integer id
  integer message_id FK
  integer institution_id FK
}
"public.messages_user_links" {
  integer id
  integer message_id FK
  integer user_id FK
}
"public.notifications_user_links" {
  integer id
  integer notification_id FK
  integer user_id FK
}
"public.tasks_employee_links" {
  integer id
  integer task_id FK
  integer employee_id FK
}
"public.tasks_institution_links" {
  integer id
  integer task_id FK
  integer institution_id FK
}
"public.timelines_user_links" {
  integer id
  integer timeline_id FK
  integer user_id FK
}
"public.animal_kinds_animal_links" {
  integer id
  integer animal_kind_id FK
  integer animal_id FK
}
"public.animal_logs_animal_links" {
  integer id
  integer animal_log_id FK
  integer animal_id FK
}
"public.employees_user_links" {
  integer id
  integer employee_id FK
  integer user_id FK
}
"public.favorites_animal_links" {
  integer id
  integer favorite_id FK
  integer animal_id FK
}
```

---

> Generated by [tbls](https://github.com/k1LoW/tbls)
