# public.admin_permissions

## Description

## Columns

| Name              | Type                           | Default                                       | Nullable | Children                                                                      | Parents                                     | Comment |
| ----------------- | ------------------------------ | --------------------------------------------- | -------- | ----------------------------------------------------------------------------- | ------------------------------------------- | ------- |
| id                | integer                        | nextval('admin_permissions_id_seq'::regclass) | false    | [public.admin_permissions_role_links](public.admin_permissions_role_links.md) |                                             |         |
| action            | varchar(255)                   |                                               | true     |                                                                               |                                             |         |
| action_parameters | jsonb                          |                                               | true     |                                                                               |                                             |         |
| subject           | varchar(255)                   |                                               | true     |                                                                               |                                             |         |
| properties        | jsonb                          |                                               | true     |                                                                               |                                             |         |
| conditions        | jsonb                          |                                               | true     |                                                                               |                                             |         |
| created_at        | timestamp(6) without time zone |                                               | true     |                                                                               |                                             |         |
| updated_at        | timestamp(6) without time zone |                                               | true     |                                                                               |                                             |         |
| created_by_id     | integer                        |                                               | true     |                                                                               | [public.admin_users](public.admin_users.md) |         |
| updated_by_id     | integer                        |                                               | true     |                                                                               | [public.admin_users](public.admin_users.md) |         |

## Constraints

| Name                               | Type        | Definition                                                                |
| ---------------------------------- | ----------- | ------------------------------------------------------------------------- |
| admin_permissions_pkey             | PRIMARY KEY | PRIMARY KEY (id)                                                          |
| admin_permissions_created_by_id_fk | FOREIGN KEY | FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| admin_permissions_updated_by_id_fk | FOREIGN KEY | FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |

## Indexes

| Name                               | Definition                                                                                              |
| ---------------------------------- | ------------------------------------------------------------------------------------------------------- |
| admin_permissions_pkey             | CREATE UNIQUE INDEX admin_permissions_pkey ON public.admin_permissions USING btree (id)                 |
| admin_permissions_created_by_id_fk | CREATE INDEX admin_permissions_created_by_id_fk ON public.admin_permissions USING btree (created_by_id) |
| admin_permissions_updated_by_id_fk | CREATE INDEX admin_permissions_updated_by_id_fk ON public.admin_permissions USING btree (updated_by_id) |

## Relations

```mermaid
erDiagram

"public.admin_permissions_role_links" }o--o| "public.admin_permissions" : "FOREIGN KEY (permission_id) REFERENCES admin_permissions(id) ON DELETE CASCADE"
"public.admin_permissions" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.admin_permissions" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"

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
"public.admin_permissions_role_links" {
  integer id
  integer permission_id FK
  integer role_id FK
  double_precision permission_order
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
```

---

> Generated by [tbls](https://github.com/k1LoW/tbls)
