# public.timelines

## Description

## Columns

| Name          | Type                           | Default                               | Nullable | Children                                                      | Parents                                     | Comment |
| ------------- | ------------------------------ | ------------------------------------- | -------- | ------------------------------------------------------------- | ------------------------------------------- | ------- |
| id            | integer                        | nextval('timelines_id_seq'::regclass) | false    | [public.timelines_user_links](public.timelines_user_links.md) |                                             |         |
| content       | text                           |                                       | true     |                                                               |                                             |         |
| footprints    | integer                        |                                       | true     |                                                               |                                             |         |
| created_at    | timestamp(6) without time zone |                                       | true     |                                                               |                                             |         |
| updated_at    | timestamp(6) without time zone |                                       | true     |                                                               |                                             |         |
| published_at  | timestamp(6) without time zone |                                       | true     |                                                               |                                             |         |
| created_by_id | integer                        |                                       | true     |                                                               | [public.admin_users](public.admin_users.md) |         |
| updated_by_id | integer                        |                                       | true     |                                                               | [public.admin_users](public.admin_users.md) |         |

## Constraints

| Name                       | Type        | Definition                                                                |
| -------------------------- | ----------- | ------------------------------------------------------------------------- |
| timelines_created_by_id_fk | FOREIGN KEY | FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| timelines_updated_by_id_fk | FOREIGN KEY | FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| timelines_pkey             | PRIMARY KEY | PRIMARY KEY (id)                                                          |

## Indexes

| Name                       | Definition                                                                              |
| -------------------------- | --------------------------------------------------------------------------------------- |
| timelines_pkey             | CREATE UNIQUE INDEX timelines_pkey ON public.timelines USING btree (id)                 |
| timelines_created_by_id_fk | CREATE INDEX timelines_created_by_id_fk ON public.timelines USING btree (created_by_id) |
| timelines_updated_by_id_fk | CREATE INDEX timelines_updated_by_id_fk ON public.timelines USING btree (updated_by_id) |

## Relations

```mermaid
erDiagram

"public.timelines_user_links" }o--o| "public.timelines" : "FOREIGN KEY (timeline_id) REFERENCES timelines(id) ON DELETE CASCADE"
"public.timelines" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.timelines" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"

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
"public.timelines_user_links" {
  integer id
  integer timeline_id FK
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