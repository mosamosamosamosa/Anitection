# public.logs

## Description

## Columns

| Name          | Type                           | Default                          | Nullable | Children                                                          | Parents                                     | Comment |
| ------------- | ------------------------------ | -------------------------------- | -------- | ----------------------------------------------------------------- | ------------------------------------------- | ------- |
| id            | integer                        | nextval('logs_id_seq'::regclass) | false    | [public.animal_logs_logs_links](public.animal_logs_logs_links.md) |                                             |         |
| content       | varchar(255)                   |                                  | true     |                                                                   |                                             |         |
| created_at    | timestamp(6) without time zone |                                  | true     |                                                                   |                                             |         |
| updated_at    | timestamp(6) without time zone |                                  | true     |                                                                   |                                             |         |
| published_at  | timestamp(6) without time zone |                                  | true     |                                                                   |                                             |         |
| created_by_id | integer                        |                                  | true     |                                                                   | [public.admin_users](public.admin_users.md) |         |
| updated_by_id | integer                        |                                  | true     |                                                                   | [public.admin_users](public.admin_users.md) |         |

## Constraints

| Name                  | Type        | Definition                                                                |
| --------------------- | ----------- | ------------------------------------------------------------------------- |
| logs_created_by_id_fk | FOREIGN KEY | FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| logs_updated_by_id_fk | FOREIGN KEY | FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| logs_pkey             | PRIMARY KEY | PRIMARY KEY (id)                                                          |

## Indexes

| Name                  | Definition                                                                    |
| --------------------- | ----------------------------------------------------------------------------- |
| logs_pkey             | CREATE UNIQUE INDEX logs_pkey ON public.logs USING btree (id)                 |
| logs_created_by_id_fk | CREATE INDEX logs_created_by_id_fk ON public.logs USING btree (created_by_id) |
| logs_updated_by_id_fk | CREATE INDEX logs_updated_by_id_fk ON public.logs USING btree (updated_by_id) |

## Relations

```mermaid
erDiagram

"public.animal_logs_logs_links" }o--o| "public.logs" : "FOREIGN KEY (log_id) REFERENCES logs(id) ON DELETE CASCADE"
"public.logs" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.logs" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"

"public.logs" {
  integer id
  varchar_255_ content
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
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
