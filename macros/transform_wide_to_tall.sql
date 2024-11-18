{% macro transform_wide_to_tall(
    source_name="patologia_digital",
    source_table="Patolog_as_Digital_de__Odontolog_a_ENERO_JULIO2024_xlsx",
    regex_extract_enfermedad_o_tratamiento="Patolog__as__(\w+)_",
    columns="""timestamp as ts,
            fecha fecha,
            m__dico medico,
            edad_de_paciente edad_de_paciente,
            cast(regexp_extract(edad_de_paciente,r'.+?(\d+)') as integer) edad_sort,
            mes mes,
            a__o ano,""",
    visit_number_prepend="odontologia"
) %}
    with
        all_cols as (
            select
                *,
                '{{visit_number_prepend}}' as servicio,
                "{{visit_number_prepend}}"
                || lpad(cast(row_number() over () as string), 7, "0") as visit_number
            from
                {{
                    source(
                        source_name,
                        source_table,
                    )
                }}
        )
    {% for col in adapter.get_columns_in_relation(
            source(
                source_name,
                source_table,
            )
        ) -%}
        select
            {{ columns }}
            visit_number,
            servicio,
            regexp_extract(
                '{{ col.column }}', r'{{regex_extract_enfermedad_o_tratamiento}}'
            ) enfermedad_o_tratamiento,
        from all_cols
        where
            regexp_extract(
                '{{ col.column }}', r'{{regex_extract_enfermedad_o_tratamiento}}'
            )
            is not null
            and {{ col.column }} is not null
        {% if not loop.last %}
            union all
        {% endif %}
    {% endfor %}
{% endmacro %}
