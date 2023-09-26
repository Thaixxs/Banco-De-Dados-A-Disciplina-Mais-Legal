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

-- Exercício 03
create procedure sp_ContarLivrosPorCategoria(in nome_categoria varchar(100))
begin
	declare id_categoria int;
    select Categoria_ID into id_categoria from categoria where nome_categoria = nome;
	select count(Categoria_ID) as QuantidadesLivros from livro where Categoria_ID = id_categoria group by Categoria_ID;
end;
$$
call sp_ContarLivrosPorCategoria('Ficção Científica');

-- Exercício 04
create procedure sp_VerificarLivrosCategoria(in nome_categoria varchar(100))
begin
	declare id_categoria int;
    declare quant_livros_cat int;
    declare exis_livro varchar(100);
    select Categoria_ID into id_categoria from categoria where nome_categoria = nome;
    select count(Categoria_ID) into quant_livros_cat from livro where Categoria_ID = id_categoria group by Categoria_ID;
    if quant_livros_cat = 0 then 
		 set  exis_livro= 'Categoria não tem livros';
	elseif quant_livros_cat > 0 then
		 set exis_livro = 'Categoria tem livros';
    end if;
        select exis_livro;
end;
$$
call sp_VerificarLivrosCategoria('História');

-- Exercício 05
create procedure sp_LivrosAteAno(in ano int)
begin
	 select Titulo, Ano_Publicacao from livro where Ano_Publicacao <= ano order by Ano_Publicacao;
end;
$$
call sp_LivrosAteAno(2007)

-- Exercício 06
create procedure sp_TitulosPorCategoria(in nome_categoria varchar(100))
begin
	declare id_categoria int;
    select Categoria_ID into id_categoria from categoria where nome_categoria = nome;
	select Titulo from livro where Categoria_ID = id_categoria;
end;
$$
call sp_TitulosPorCategoria('Autoajuda');

-- Exercício 07

-- Exercício 08
-- Exercício 09
-- Exercício 10