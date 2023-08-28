select * from matriculas;
select aluno_id, curso from matriculas where curso in ('Engenharia de Software') group by aluno_id;