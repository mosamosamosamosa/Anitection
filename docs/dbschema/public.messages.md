# public.messages

## Description

## Columns

| Name          | Type                           | Default                              | Nullable | Children                                                                                                                              | Parents                                     | Comment |
| ------------- | ------------------------------ | ------------------------------------ | -------- | ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- | ------- |
| id            | integer                        | nextval('messages_id_seq'::regclass) | false    | [public.messages_institution_links](public.messages_institution_links.md) [public.messages_user_links](public.messages_user_links.md) |                                             |         |
| content       | text                           |                                      | true     |                                                                                                                                       |                                             |         |
| created_at    | timestamp(6) without time zone |                                      | true     |                                                                                                                                       |                                             |         |
| updated_at    | timestamp(6) without time zone |                                      | true     |                                                                                                                                       |                                             |         |
| published_at  | timestamp(6) without time zone |                                      | true     |                                                                                                                                       |                                             |         |
| created_by_id | integer                        |                                      | true     |                                                                                                                                       | [public.admin_users](public.admin_users.md) |         |
| updated_by_id | integer                        |                                      | true     |                                                                                                                                       | [public.admin_users](public.admin_users.md) |         |

## Constraints

| Name                      | Type        | Definition                                                                |
| ------------------------- | ----------- | ------------------------------------------------------------------------- |
| messages_created_by_id_fk | FOREIGN KEY | FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| messages_updated_by_id_fk | FOREIGN KEY | FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| messages_pkey             | PRIMARY KEY | PRIMARY KEY (id)                                                          |

## Indexes

| Name                      | Definition                                                                            |
| ------------------------- | ------------------------------------------------------------------------------------- |
| messages_pkey             | CREATE UNIQUE INDEX messages_pkey ON public.messages USING btree (id)                 |
| messages_created_by_id_fk | CREATE INDEX messages_created_by_id_fk ON public.messages USING btree (created_by_id) |
| messages_updated_by_id_fk | CREATE INDEX messages_updated_by_id_fk ON public.messages USING btree (updated_by_id) |

## Relations

```mermaid
erDiagram

"public.messages_institution_links" }o--o| "public.messages" : "FOREIGN KEY (message_id) REFERENCES messages(id) ON DELETE CASCADE"
"public.messages_user_links" }o--o| "public.messages" : "FOREIGN KEY (message_id) REFERENCES messages(id) ON DELETE CASCADE"
"public.messages" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.messages" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"

"public.messages" {
  integer id
  text content
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
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
