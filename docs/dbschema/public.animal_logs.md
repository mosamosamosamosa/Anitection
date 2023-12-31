# public.animal_logs

## Description

## Columns

| Name          | Type                           | Default                                 | Nullable | Children                                                                                                                                | Parents                                     | Comment |
| ------------- | ------------------------------ | --------------------------------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- | ------- |
| id            | integer                        | nextval('animal_logs_id_seq'::regclass) | false    | [public.animal_logs_animal_links](public.animal_logs_animal_links.md) [public.animal_logs_logs_links](public.animal_logs_logs_links.md) |                                             |         |
| created_at    | timestamp(6) without time zone |                                         | true     |                                                                                                                                         |                                             |         |
| updated_at    | timestamp(6) without time zone |                                         | true     |                                                                                                                                         |                                             |         |
| published_at  | timestamp(6) without time zone |                                         | true     |                                                                                                                                         |                                             |         |
| created_by_id | integer                        |                                         | true     |                                                                                                                                         | [public.admin_users](public.admin_users.md) |         |
| updated_by_id | integer                        |                                         | true     |                                                                                                                                         | [public.admin_users](public.admin_users.md) |         |

## Constraints

| Name                         | Type        | Definition                                                                |
| ---------------------------- | ----------- | ------------------------------------------------------------------------- |
| animal_logs_created_by_id_fk | FOREIGN KEY | FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| animal_logs_updated_by_id_fk | FOREIGN KEY | FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| animal_logs_pkey             | PRIMARY KEY | PRIMARY KEY (id)                                                          |

## Indexes

| Name                         | Definition                                                                                  |
| ---------------------------- | ------------------------------------------------------------------------------------------- |
| animal_logs_pkey             | CREATE UNIQUE INDEX animal_logs_pkey ON public.animal_logs USING btree (id)                 |
| animal_logs_created_by_id_fk | CREATE INDEX animal_logs_created_by_id_fk ON public.animal_logs USING btree (created_by_id) |
| animal_logs_updated_by_id_fk | CREATE INDEX animal_logs_updated_by_id_fk ON public.animal_logs USING btree (updated_by_id) |

## Relations

```mermaid
erDiagram

"public.animal_logs_animal_links" }o--o| "public.animal_logs" : "FOREIGN KEY (animal_log_id) REFERENCES animal_logs(id) ON DELETE CASCADE"
"public.animal_logs_logs_links" }o--o| "public.animal_logs" : "FOREIGN KEY (animal_log_id) REFERENCES animal_logs(id) ON DELETE CASCADE"
"public.animal_logs" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.animal_logs" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"

"public.animal_logs" {
  integer id
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.animal_logs_animal_links" {
  integer id
  integer animal_log_id FK
  integer animal_id FK
}
"public.animal_logs_logs_links" {
  integer id
  integer animal_log_id FK
  integer log_id FK
  double_precision log_order
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
