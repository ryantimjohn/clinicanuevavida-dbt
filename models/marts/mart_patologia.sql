{{
    dbt_utils.union_relations(
        relations=[
            ref("stg_laboratorio"),
            ref("stg_medicina_general"),
            ref("stg_odontologia"),
            ref("stg_psicologia"),
        ]
    )
}}