select aluno_id, count(*) as quant_matriculas from matriculas group by aluno_id order by quant_matriculas desc;