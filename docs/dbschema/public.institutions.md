# public.institutions

## Description

## Columns

| Name          | Type                           | Default                                  | Nullable | Children                                                                                                                                                                                                                  | Parents                                     | Comment |
| ------------- | ------------------------------ | ---------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- | ------- |
| id            | integer                        | nextval('institutions_id_seq'::regclass) | false    | [public.employees_institution_links](public.employees_institution_links.md) [public.messages_institution_links](public.messages_institution_links.md) [public.tasks_institution_links](public.tasks_institution_links.md) |                                             |         |
| name          | varchar(255)                   |                                          | true     |                                                                                                                                                                                                                           |                                             |         |
| address       | varchar(255)                   |                                          | true     |                                                                                                                                                                                                                           |                                             |         |
| phone         | varchar(255)                   |                                          | true     |                                                                                                                                                                                                                           |                                             |         |
| website_url   | varchar(255)                   |                                          | true     |                                                                                                                                                                                                                           |                                             |         |
| needs_url     | varchar(255)                   |                                          | true     |                                                                                                                                                                                                                           |                                             |         |
| description   | text                           |                                          | true     |                                                                                                                                                                                                                           |                                             |         |
| created_at    | timestamp(6) without time zone |                                          | true     |                                                                                                                                                                                                                           |                                             |         |
| updated_at    | timestamp(6) without time zone |                                          | true     |                                                                                                                                                                                                                           |                                             |         |
| published_at  | timestamp(6) without time zone |                                          | true     |                                                                                                                                                                                                                           |                                             |         |
| created_by_id | integer                        |                                          | true     |                                                                                                                                                                                                                           | [public.admin_users](public.admin_users.md) |         |
| updated_by_id | integer                        |                                          | true     |                                                                                                                                                                                                                           | [public.admin_users](public.admin_users.md) |         |

## Constraints

| Name                          | Type        | Definition                                                                |
| ----------------------------- | ----------- | ------------------------------------------------------------------------- |
| institutions_created_by_id_fk | FOREIGN KEY | FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| institutions_updated_by_id_fk | FOREIGN KEY | FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| institutions_pkey             | PRIMARY KEY | PRIMARY KEY (id)                                                          |

## Indexes

| Name                          | Definition                                                                                    |
| ----------------------------- | --------------------------------------------------------------------------------------------- |
| institutions_pkey             | CREATE UNIQUE INDEX institutions_pkey ON public.institutions USING btree (id)                 |
| institutions_created_by_id_fk | CREATE INDEX institutions_created_by_id_fk ON public.institutions USING btree (created_by_id) |
| institutions_updated_by_id_fk | CREATE INDEX institutions_updated_by_id_fk ON public.institutions USING btree (updated_by_id) |

## Relations

```mermaid
erDiagram

"public.employees_institution_links" }o--o| "public.institutions" : "FOREIGN KEY (institution_id) REFERENCES institutions(id) ON DELETE CASCADE"
"public.messages_institution_links" }o--o| "public.institutions" : "FOREIGN KEY (institution_id) REFERENCES institutions(id) ON DELETE CASCADE"
"public.tasks_institution_links" }o--o| "public.institutions" : "FOREIGN KEY (institution_id) REFERENCES institutions(id) ON DELETE CASCADE"
"public.institutions" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.institutions" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"

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
"public.employees_institution_links" {
  integer id
  integer employee_id FK
  integer institution_id FK
}
"public.messages_institution_links" {
  integer id
  integer message_id FK
  integer institution_id FK
}
"public.tasks_institution_links" {
  integer id
  integer task_id FK
  integer institution_id FK
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
