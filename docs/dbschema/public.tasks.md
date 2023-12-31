# public.tasks

## Description

## Columns

| Name          | Type                           | Default                           | Nullable | Children                                                                                                                          | Parents                                     | Comment |
| ------------- | ------------------------------ | --------------------------------- | -------- | --------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- | ------- |
| id            | integer                        | nextval('tasks_id_seq'::regclass) | false    | [public.tasks_employee_links](public.tasks_employee_links.md) [public.tasks_institution_links](public.tasks_institution_links.md) |                                             |         |
| title         | varchar(255)                   |                                   | true     |                                                                                                                                   |                                             |         |
| content       | text                           |                                   | true     |                                                                                                                                   |                                             |         |
| created_at    | timestamp(6) without time zone |                                   | true     |                                                                                                                                   |                                             |         |
| updated_at    | timestamp(6) without time zone |                                   | true     |                                                                                                                                   |                                             |         |
| published_at  | timestamp(6) without time zone |                                   | true     |                                                                                                                                   |                                             |         |
| created_by_id | integer                        |                                   | true     |                                                                                                                                   | [public.admin_users](public.admin_users.md) |         |
| updated_by_id | integer                        |                                   | true     |                                                                                                                                   | [public.admin_users](public.admin_users.md) |         |

## Constraints

| Name                   | Type        | Definition                                                                |
| ---------------------- | ----------- | ------------------------------------------------------------------------- |
| tasks_created_by_id_fk | FOREIGN KEY | FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| tasks_updated_by_id_fk | FOREIGN KEY | FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| tasks_pkey             | PRIMARY KEY | PRIMARY KEY (id)                                                          |

## Indexes

| Name                   | Definition                                                                      |
| ---------------------- | ------------------------------------------------------------------------------- |
| tasks_pkey             | CREATE UNIQUE INDEX tasks_pkey ON public.tasks USING btree (id)                 |
| tasks_created_by_id_fk | CREATE INDEX tasks_created_by_id_fk ON public.tasks USING btree (created_by_id) |
| tasks_updated_by_id_fk | CREATE INDEX tasks_updated_by_id_fk ON public.tasks USING btree (updated_by_id) |

## Relations

```mermaid
erDiagram

"public.tasks_employee_links" }o--o| "public.tasks" : "FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE"
"public.tasks_institution_links" }o--o| "public.tasks" : "FOREIGN KEY (task_id) REFERENCES tasks(id) ON DELETE CASCADE"
"public.tasks" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.tasks" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"

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
