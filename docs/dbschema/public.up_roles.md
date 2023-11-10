# public.up_roles

## Description

## Columns

| Name          | Type                           | Default                              | Nullable | Children                                                                                                                            | Parents                                     | Comment |
| ------------- | ------------------------------ | ------------------------------------ | -------- | ----------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- | ------- |
| id            | integer                        | nextval('up_roles_id_seq'::regclass) | false    | [public.up_permissions_role_links](public.up_permissions_role_links.md) [public.up_users_role_links](public.up_users_role_links.md) |                                             |         |
| name          | varchar(255)                   |                                      | true     |                                                                                                                                     |                                             |         |
| description   | varchar(255)                   |                                      | true     |                                                                                                                                     |                                             |         |
| type          | varchar(255)                   |                                      | true     |                                                                                                                                     |                                             |         |
| created_at    | timestamp(6) without time zone |                                      | true     |                                                                                                                                     |                                             |         |
| updated_at    | timestamp(6) without time zone |                                      | true     |                                                                                                                                     |                                             |         |
| created_by_id | integer                        |                                      | true     |                                                                                                                                     | [public.admin_users](public.admin_users.md) |         |
| updated_by_id | integer                        |                                      | true     |                                                                                                                                     | [public.admin_users](public.admin_users.md) |         |

## Constraints

| Name                      | Type        | Definition                                                                |
| ------------------------- | ----------- | ------------------------------------------------------------------------- |
| up_roles_created_by_id_fk | FOREIGN KEY | FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| up_roles_updated_by_id_fk | FOREIGN KEY | FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| up_roles_pkey             | PRIMARY KEY | PRIMARY KEY (id)                                                          |

## Indexes

| Name                      | Definition                                                                            |
| ------------------------- | ------------------------------------------------------------------------------------- |
| up_roles_pkey             | CREATE UNIQUE INDEX up_roles_pkey ON public.up_roles USING btree (id)                 |
| up_roles_created_by_id_fk | CREATE INDEX up_roles_created_by_id_fk ON public.up_roles USING btree (created_by_id) |
| up_roles_updated_by_id_fk | CREATE INDEX up_roles_updated_by_id_fk ON public.up_roles USING btree (updated_by_id) |

## Relations

```mermaid
erDiagram

"public.up_permissions_role_links" }o--o| "public.up_roles" : "FOREIGN KEY (role_id) REFERENCES up_roles(id) ON DELETE CASCADE"
"public.up_users_role_links" }o--o| "public.up_roles" : "FOREIGN KEY (role_id) REFERENCES up_roles(id) ON DELETE CASCADE"
"public.up_roles" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.up_roles" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"

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
