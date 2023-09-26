-- Exercício 01
delimiter $$
create procedure sp_ListarAutores()
begin 
	select * from autor;
end;
$$
call sp_ListarAutores();

-- Exercício 02
create procedure sp_LivrosPorCategoria(in nome_categoria varchar(100))
begin
	declare id_categoria int;
    select Categoria_ID into id_categoria from categoria where nome_categoria = nome;
	select * from livro where Categoria_ID = id_categoria;
end;
$$
call sp_LivrosPorCategoria('Romance');