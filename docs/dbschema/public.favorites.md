# public.favorites

## Description

## Columns

| Name          | Type                           | Default                               | Nullable | Children                                                                                                                        | Parents                                     | Comment |
| ------------- | ------------------------------ | ------------------------------------- | -------- | ------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------- | ------- |
| id            | integer                        | nextval('favorites_id_seq'::regclass) | false    | [public.favorites_user_links](public.favorites_user_links.md) [public.favorites_animal_links](public.favorites_animal_links.md) |                                             |         |
| created_at    | timestamp(6) without time zone |                                       | true     |                                                                                                                                 |                                             |         |
| updated_at    | timestamp(6) without time zone |                                       | true     |                                                                                                                                 |                                             |         |
| published_at  | timestamp(6) without time zone |                                       | true     |                                                                                                                                 |                                             |         |
| created_by_id | integer                        |                                       | true     |                                                                                                                                 | [public.admin_users](public.admin_users.md) |         |
| updated_by_id | integer                        |                                       | true     |                                                                                                                                 | [public.admin_users](public.admin_users.md) |         |

## Constraints

| Name                       | Type        | Definition                                                                |
| -------------------------- | ----------- | ------------------------------------------------------------------------- |
| favorites_created_by_id_fk | FOREIGN KEY | FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| favorites_updated_by_id_fk | FOREIGN KEY | FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| favorites_pkey             | PRIMARY KEY | PRIMARY KEY (id)                                                          |

## Indexes

| Name                       | Definition                                                                              |
| -------------------------- | --------------------------------------------------------------------------------------- |
| favorites_pkey             | CREATE UNIQUE INDEX favorites_pkey ON public.favorites USING btree (id)                 |
| favorites_created_by_id_fk | CREATE INDEX favorites_created_by_id_fk ON public.favorites USING btree (created_by_id) |
| favorites_updated_by_id_fk | CREATE INDEX favorites_updated_by_id_fk ON public.favorites USING btree (updated_by_id) |

## Relations

```mermaid
erDiagram

"public.favorites_user_links" }o--o| "public.favorites" : "FOREIGN KEY (favorite_id) REFERENCES favorites(id) ON DELETE CASCADE"
"public.favorites_animal_links" }o--o| "public.favorites" : "FOREIGN KEY (favorite_id) REFERENCES favorites(id) ON DELETE CASCADE"
"public.favorites" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.favorites" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"

"public.favorites" {
  integer id
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  timestamp_6__without_time_zone published_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.favorites_user_links" {
  integer id
  integer favorite_id FK
  integer user_id FK
}
"public.favorites_animal_links" {
  integer id
  integer favorite_id FK
  integer animal_id FK
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
