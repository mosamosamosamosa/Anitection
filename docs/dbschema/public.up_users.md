# public.up_users

## Description

## Columns

| Name                 | Type                           | Default                              | Nullable | Children                                                                                                                                                                                                                                                                                                                                                                                | Parents                                     | Comment |
| -------------------- | ------------------------------ | ------------------------------------ | -------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- | ------- |
| id                   | integer                        | nextval('up_users_id_seq'::regclass) | false    | [public.up_users_role_links](public.up_users_role_links.md) [public.favorites_user_links](public.favorites_user_links.md) [public.messages_user_links](public.messages_user_links.md) [public.notifications_user_links](public.notifications_user_links.md) [public.timelines_user_links](public.timelines_user_links.md) [public.employees_user_links](public.employees_user_links.md) |                                             |         |
| username             | varchar(255)                   |                                      | true     |                                                                                                                                                                                                                                                                                                                                                                                         |                                             |         |
| email                | varchar(255)                   |                                      | true     |                                                                                                                                                                                                                                                                                                                                                                                         |                                             |         |
| provider             | varchar(255)                   |                                      | true     |                                                                                                                                                                                                                                                                                                                                                                                         |                                             |         |
| password             | varchar(255)                   |                                      | true     |                                                                                                                                                                                                                                                                                                                                                                                         |                                             |         |
| reset_password_token | varchar(255)                   |                                      | true     |                                                                                                                                                                                                                                                                                                                                                                                         |                                             |         |
| confirmation_token   | varchar(255)                   |                                      | true     |                                                                                                                                                                                                                                                                                                                                                                                         |                                             |         |
| confirmed            | boolean                        |                                      | true     |                                                                                                                                                                                                                                                                                                                                                                                         |                                             |         |
| blocked              | boolean                        |                                      | true     |                                                                                                                                                                                                                                                                                                                                                                                         |                                             |         |
| employee             | boolean                        |                                      | true     |                                                                                                                                                                                                                                                                                                                                                                                         |                                             |         |
| created_at           | timestamp(6) without time zone |                                      | true     |                                                                                                                                                                                                                                                                                                                                                                                         |                                             |         |
| updated_at           | timestamp(6) without time zone |                                      | true     |                                                                                                                                                                                                                                                                                                                                                                                         |                                             |         |
| created_by_id        | integer                        |                                      | true     |                                                                                                                                                                                                                                                                                                                                                                                         | [public.admin_users](public.admin_users.md) |         |
| updated_by_id        | integer                        |                                      | true     |                                                                                                                                                                                                                                                                                                                                                                                         | [public.admin_users](public.admin_users.md) |         |

## Constraints

| Name                      | Type        | Definition                                                                |
| ------------------------- | ----------- | ------------------------------------------------------------------------- |
| up_users_created_by_id_fk | FOREIGN KEY | FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| up_users_updated_by_id_fk | FOREIGN KEY | FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| up_users_pkey             | PRIMARY KEY | PRIMARY KEY (id)                                                          |

## Indexes

| Name                      | Definition                                                                            |
| ------------------------- | ------------------------------------------------------------------------------------- |
| up_users_pkey             | CREATE UNIQUE INDEX up_users_pkey ON public.up_users USING btree (id)                 |
| up_users_created_by_id_fk | CREATE INDEX up_users_created_by_id_fk ON public.up_users USING btree (created_by_id) |
| up_users_updated_by_id_fk | CREATE INDEX up_users_updated_by_id_fk ON public.up_users USING btree (updated_by_id) |

## Relations

```mermaid
erDiagram

"public.up_users_role_links" }o--o| "public.up_users" : "FOREIGN KEY (user_id) REFERENCES up_users(id) ON DELETE CASCADE"
"public.favorites_user_links" }o--o| "public.up_users" : "FOREIGN KEY (user_id) REFERENCES up_users(id) ON DELETE CASCADE"
"public.messages_user_links" }o--o| "public.up_users" : "FOREIGN KEY (user_id) REFERENCES up_users(id) ON DELETE CASCADE"
"public.notifications_user_links" }o--o| "public.up_users" : "FOREIGN KEY (user_id) REFERENCES up_users(id) ON DELETE CASCADE"
"public.timelines_user_links" }o--o| "public.up_users" : "FOREIGN KEY (user_id) REFERENCES up_users(id) ON DELETE CASCADE"
"public.employees_user_links" }o--o| "public.up_users" : "FOREIGN KEY (user_id) REFERENCES up_users(id) ON DELETE CASCADE"
"public.up_users" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.up_users" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"

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
"public.up_users_role_links" {
  integer id
  integer user_id FK
  integer role_id FK
  double_precision user_order
}
"public.favorites_user_links" {
  integer id
  integer favorite_id FK
  integer user_id FK
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
"public.timelines_user_links" {
  integer id
  integer timeline_id FK
  integer user_id FK
}
"public.employees_user_links" {
  integer id
  integer employee_id FK
  integer user_id FK
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
