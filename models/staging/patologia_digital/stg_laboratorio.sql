{{
    transform_wide_to_tall(
        source_table="Patologias__digital_de_Laboratorio_de_enero_jul_2024_xlsx",
        visit_number_prepend="laboratorio",
        columns="""timestamp as ts,
            fecha fecha,
            Laboratorista medico,
            edad_de_paciente edad_de_paciente,
            mes mes,
            a__o ano,""",
        regex_extract_enfermedad_o_tratamiento="PRUEBAS__(\w+)_"
    )
}}
