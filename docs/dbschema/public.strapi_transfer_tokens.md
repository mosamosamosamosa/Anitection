# public.strapi_transfer_tokens

## Description

## Columns

| Name          | Type                           | Default                                            | Nullable | Children                                                                                                        | Parents                                     | Comment |
| ------------- | ------------------------------ | -------------------------------------------------- | -------- | --------------------------------------------------------------------------------------------------------------- | ------------------------------------------- | ------- |
| id            | integer                        | nextval('strapi_transfer_tokens_id_seq'::regclass) | false    | [public.strapi_transfer_token_permissions_token_links](public.strapi_transfer_token_permissions_token_links.md) |                                             |         |
| name          | varchar(255)                   |                                                    | true     |                                                                                                                 |                                             |         |
| description   | varchar(255)                   |                                                    | true     |                                                                                                                 |                                             |         |
| access_key    | varchar(255)                   |                                                    | true     |                                                                                                                 |                                             |         |
| last_used_at  | timestamp(6) without time zone |                                                    | true     |                                                                                                                 |                                             |         |
| expires_at    | timestamp(6) without time zone |                                                    | true     |                                                                                                                 |                                             |         |
| lifespan      | bigint                         |                                                    | true     |                                                                                                                 |                                             |         |
| created_at    | timestamp(6) without time zone |                                                    | true     |                                                                                                                 |                                             |         |
| updated_at    | timestamp(6) without time zone |                                                    | true     |                                                                                                                 |                                             |         |
| created_by_id | integer                        |                                                    | true     |                                                                                                                 | [public.admin_users](public.admin_users.md) |         |
| updated_by_id | integer                        |                                                    | true     |                                                                                                                 | [public.admin_users](public.admin_users.md) |         |

## Constraints

| Name                                    | Type        | Definition                                                                |
| --------------------------------------- | ----------- | ------------------------------------------------------------------------- |
| strapi_transfer_tokens_created_by_id_fk | FOREIGN KEY | FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| strapi_transfer_tokens_updated_by_id_fk | FOREIGN KEY | FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL |
| strapi_transfer_tokens_pkey             | PRIMARY KEY | PRIMARY KEY (id)                                                          |

## Indexes

| Name                                    | Definition                                                                                                        |
| --------------------------------------- | ----------------------------------------------------------------------------------------------------------------- |
| strapi_transfer_tokens_pkey             | CREATE UNIQUE INDEX strapi_transfer_tokens_pkey ON public.strapi_transfer_tokens USING btree (id)                 |
| strapi_transfer_tokens_created_by_id_fk | CREATE INDEX strapi_transfer_tokens_created_by_id_fk ON public.strapi_transfer_tokens USING btree (created_by_id) |
| strapi_transfer_tokens_updated_by_id_fk | CREATE INDEX strapi_transfer_tokens_updated_by_id_fk ON public.strapi_transfer_tokens USING btree (updated_by_id) |

## Relations

```mermaid
erDiagram

"public.strapi_transfer_token_permissions_token_links" }o--o| "public.strapi_transfer_tokens" : "FOREIGN KEY (transfer_token_id) REFERENCES strapi_transfer_tokens(id) ON DELETE CASCADE"
"public.strapi_transfer_tokens" }o--o| "public.admin_users" : "FOREIGN KEY (created_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"
"public.strapi_transfer_tokens" }o--o| "public.admin_users" : "FOREIGN KEY (updated_by_id) REFERENCES admin_users(id) ON DELETE SET NULL"

"public.strapi_transfer_tokens" {
  integer id
  varchar_255_ name
  varchar_255_ description
  varchar_255_ access_key
  timestamp_6__without_time_zone last_used_at
  timestamp_6__without_time_zone expires_at
  bigint lifespan
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.strapi_transfer_token_permissions_token_links" {
  integer id
  integer transfer_token_permission_id FK
  integer transfer_token_id FK
  double_precision transfer_token_permission_order
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
