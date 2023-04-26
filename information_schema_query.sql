select
    '<datatype_dbms_product>' as "datatype_dbms_product",
    --'<entity_dv_source>' as "entity_dv_source",
    '<package_name>' as "package_name",
    '<entity_physical_type>' as "entity_physical_type",
    '<entity_schema>' as "entity_schema",
    c.table_name as "entity_name",
    '<entity_type>' as "entity_type",
    c.column_name as "attribute_name",
    upper(
        case
            when c.data_type = 'ARRAY' then 'array'
            when c.data_type = 'VARIANT' then 'variant'
            when c.data_type = 'VARCHAR' then 'varchar'
            when c.data_type like 'TIMESTAMP_NTZ' then 'timestamp'
            when c.data_type like 'TIMESTAMP_TZ' then 'timestamptz'
            when c.data_type = 'INTEGER' or c.data_type = 'BIGINT' then 'integer8'
            when c.data_type like 'DECIMAL%' and c.numeric_precision < 38 then 'decimal'
            else c.data_type
        end
      ) as "attribute_datatype",
    case
        when c.data_type like 'VARCHAR' then 
            case 
                -- If source files do not have sample data, then default is set as 255
                when l.column_length is null then 255
                else l.column_length end
        else null end
    as "attribute_length",
    case
       when c.data_type like 'DECIMAL%' and c.numeric_precision < 38 then c.numeric_precision
       else null end
    as "attribute_precision",
    case
       when c.data_type like 'DECIMAL%' and c.numeric_precision < 38 then c.numeric_scale
       else null end
    as "attribute_scale",
    case when c.is_nullable = 'YES' then 1 else 0 end "nullable",
    c.ordinal_position AS "position"
from information_schema.columns c 
left join <varchar_column_lengths> l on c.column_name = l.column_name
where table_name = '<table_name>'
order by "entity_name", ordinal_position;