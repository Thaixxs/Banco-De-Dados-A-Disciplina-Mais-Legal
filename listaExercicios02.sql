-- Exercício 01
delimiter $$
create procedure sp_ListarAutores()
begin 
	select * from autor;
end;
$$
call sp_ListarAutores();