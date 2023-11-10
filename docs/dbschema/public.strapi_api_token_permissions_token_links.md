# public.strapi_api_token_permissions_token_links

## Description

## Columns

| Name                       | Type             | Default                                                              | Nullable | Children | Parents                                                                       | Comment |
| -------------------------- | ---------------- | -------------------------------------------------------------------- | -------- | -------- | ----------------------------------------------------------------------------- | ------- |
| id                         | integer          | nextval('strapi_api_token_permissions_token_links_id_seq'::regclass) | false    |          |                                                                               |         |
| api_token_permission_id    | integer          |                                                                      | true     |          | [public.strapi_api_token_permissions](public.strapi_api_token_permissions.md) |         |
| api_token_id               | integer          |                                                                      | true     |          | [public.strapi_api_tokens](public.strapi_api_tokens.md)                       |         |
| api_token_permission_order | double precision |                                                                      | true     |          |                                                                               |         |

## Constraints

| Name                                            | Type        | Definition                                                                                          |
| ----------------------------------------------- | ----------- | --------------------------------------------------------------------------------------------------- |
| strapi_api_token_permissions_token_links_inv_fk | FOREIGN KEY | FOREIGN KEY (api_token_id) REFERENCES strapi_api_tokens(id) ON DELETE CASCADE                       |
| strapi_api_token_permissions_token_links_fk     | FOREIGN KEY | FOREIGN KEY (api_token_permission_id) REFERENCES strapi_api_token_permissions(id) ON DELETE CASCADE |
| strapi_api_token_permissions_token_links_pkey   | PRIMARY KEY | PRIMARY KEY (id)                                                                                    |
| strapi_api_token_permissions_token_links_unique | UNIQUE      | UNIQUE (api_token_permission_id, api_token_id)                                                      |

## Indexes

| Name                                                  | Definition                                                                                                                                                                 |
| ----------------------------------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| strapi_api_token_permissions_token_links_pkey         | CREATE UNIQUE INDEX strapi_api_token_permissions_token_links_pkey ON public.strapi_api_token_permissions_token_links USING btree (id)                                      |
| strapi_api_token_permissions_token_links_fk           | CREATE INDEX strapi_api_token_permissions_token_links_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_id)                          |
| strapi_api_token_permissions_token_links_inv_fk       | CREATE INDEX strapi_api_token_permissions_token_links_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_id)                                 |
| strapi_api_token_permissions_token_links_unique       | CREATE UNIQUE INDEX strapi_api_token_permissions_token_links_unique ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_id, api_token_id) |
| strapi_api_token_permissions_token_links_order_inv_fk | CREATE INDEX strapi_api_token_permissions_token_links_order_inv_fk ON public.strapi_api_token_permissions_token_links USING btree (api_token_permission_order)             |

## Relations

```mermaid
erDiagram

"public.strapi_api_token_permissions_token_links" }o--o| "public.strapi_api_token_permissions" : "FOREIGN KEY (api_token_permission_id) REFERENCES strapi_api_token_permissions(id) ON DELETE CASCADE"
"public.strapi_api_token_permissions_token_links" }o--o| "public.strapi_api_tokens" : "FOREIGN KEY (api_token_id) REFERENCES strapi_api_tokens(id) ON DELETE CASCADE"

"public.strapi_api_token_permissions_token_links" {
  integer id
  integer api_token_permission_id FK
  integer api_token_id FK
  double_precision api_token_permission_order
}
"public.strapi_api_token_permissions" {
  integer id
  varchar_255_ action
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
"public.strapi_api_tokens" {
  integer id
  varchar_255_ name
  varchar_255_ description
  varchar_255_ type
  varchar_255_ access_key
  timestamp_6__without_time_zone last_used_at
  timestamp_6__without_time_zone expires_at
  bigint lifespan
  timestamp_6__without_time_zone created_at
  timestamp_6__without_time_zone updated_at
  integer created_by_id FK
  integer updated_by_id FK
}
```

---

> Generated by [tbls](https://github.com/k1LoW/tbls)
