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
create procedure sp_AdicionarLivro(in nome_livro varchar(100),in editora_id int, in ano_pub int,in num_pags int , in categoria_id int)
begin
	declare id_livro int default 1;
    declare livro_novo boolean default true;
    declare titulo_livro varchar(300);
    declare quant_livros int;
    declare mensg_falha varchar(100);
    select count(*) into quant_livros from livro;
	while livro_novo and id_livro <= quant_livros   DO 
		select Titulo into titulo_livro from livro where Livro_ID = id_livro;
        if nome_livro = titulo_livro or editora_id > 2  then
			set livro_novo = false;
            set mensg_falha = "Titulo do livro repetido ou ID da editora inserido errado";
            select mensg_falha;
		else
			set id_livro = id_livro + 1;
		end if;
	end while;
    if livro_novo then 
		insert into livro values(quant_livros + 1 ,nome_livro, editora_id ,  ano_pub , num_pags  ,  categoria_id ) ;
    end if;
end;
$$
call sp_AdicionarLivro('A Hipótese do Amor', 1, 2022, 411, 1);

-- Exercício 08
create procedure sp_AutorMaisAntigo()
begin
	select Nome, Sobrenome from autor order by Data_Nascimento limit 1;
end;
$$
call sp_AutorMaisAntigo();

-- Exercício 09
-- Exercício 10