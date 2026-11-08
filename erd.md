# Entity Relationship Diagram

GitHub draws this automatically. For the report, you can also take a screenshot and save it as `erd.png` in this folder (or export one from pgAdmin's ERD tool).

```mermaid
erDiagram
    FARMERS ||--o{ MILK_COLLECTION : delivers
    COOLING_CENTERS ||--o{ MILK_COLLECTION : receives

    FARMERS {
        serial farmer_id PK
        varchar full_name
        varchar district
        varchar phone "UNIQUE"
    }
    COOLING_CENTERS {
        serial center_id PK
        varchar center_name
        varchar location
        int capacity_l
    }
    PROCESSORS {
        serial processor_id PK
        varchar company_name
        decimal price_per_l
    }
    MILK_COLLECTION {
        serial collection_id PK
        int farmer_id FK
        int center_id FK
        decimal liters
        date collect_date
    }
    DELETED_COLLECTIONS_LOG {
        serial log_id PK
        int collection_id
        int farmer_id
        int center_id
        decimal liters
        date collect_date
        timestamp deleted_at
    }
```

`processors` is an independent price list. `deleted_collections_log` has no foreign keys: a trigger fills it automatically whenever a row is deleted from `milk_collection`.
