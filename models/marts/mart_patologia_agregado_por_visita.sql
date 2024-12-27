select
    ts,
    fecha,
    medico,
    edad_de_paciente,
    edad_sort,
    mes,
    ano,
    visit_number,
    servicio,
    array_agg(enfermedad_o_tratamiento_limpiado IGNORE NULLS) enfermedad_o_tratamiento_limpiado_array
from {{ ref("mart_patologia") }}
group by 1, 2, 3, 4, 5, 6, 7, 8, 9
