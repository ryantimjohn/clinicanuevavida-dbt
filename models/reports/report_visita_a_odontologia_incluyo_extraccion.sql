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
    case
        when
            'Extracción Dientes Permanentes'
            in unnest(enfermedad_o_tratamiento_limpiado_array)
        then 1
        else 0
    end visita_incluyo_extraccion
from {{ ref("mart_patologia_agregado_por_visita") }}
where servicio = 'odontologia'
