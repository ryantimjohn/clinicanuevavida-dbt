with unioned as ({{
    dbt_utils.union_relations(
        relations=[
            ref("stg_laboratorio"),
            ref("stg_medicina_general"),
            ref("stg_odontologia"),
            ref("stg_psicologia"),
        ]
    )
}})
SELECT *,
{{clean_illness_value('enfermedad_o_tratamiento')}} as enfermedad_o_tratamiento_limpiado
from unioned
