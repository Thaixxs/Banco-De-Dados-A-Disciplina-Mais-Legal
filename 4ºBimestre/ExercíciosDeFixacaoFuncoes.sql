create database exercícios_de_fixação;
use exercícios_de_fixação;
-- Exercício 1 a)
create table nomes(
	nome varchar(70) not null
);
insert into nomes values ('Roberta'), ('Roberto'), ('Maria Clara'), ('João');

-- Exercício 1 b)
select upper(nome) from nomes;

-- Exercício 1 c)
select length(nome) from nomes;

-- Exercício 1 d)
select concat('Sr. ', nome) from nomes where nome like '%o';
select concat('Sra. ', nome) from nomes where nome like '%a';

-- Exercício 2 a)
create table produtos(
	produto varchar(100) not null,
    preco decimal(10, 5) not null,
    quantidade int not null
);
insert into produtos values ('Smartphone Samsung', 983.6254 ,132), ('Livro: Diário De Um Banana 12', 52.9853, 60), ('Caixa c/12 Canetinhas', 15.5803, 28), ('Perfume La Vie', 252.5988, 78);

-- Exercício 2 b)
select round(preco, 2) from produtos;

-- Exercício 2 c)
select abs(quantidade) from produtos;

-- Exercício 2 d)
select avg(preco) as media_preco from produtos;

-- Exercício 3 a)
create table eventos(
	data_evento date
);
insert into eventos values ('2024-08-27'), ('2024-05-02'), ('2024-05-15'), ('2023-10-15'), ('2023-11-14'), ('2024-01-03');

-- Exercício 3 b)
insert into eventos values (now());

-- Exercício 3 c)
select datediff('2024-05-15', '2024-05-02');

-- Exercício 3 d)
select dayname(data_evento) from eventos;

-- Exercício 4 a)
select if (quantidade > 132, 'Fora de estoque', 'Em estoque') as estoque from produtos where produto = 'Smartphone Samsung';

-- Exercício 4 b)
select produto, preco, case when preco < 200 then 'barato' when preco < 800 then 'médio' when preco > 900 then 'caro' end as classificação from produtos;

-- Exercício 5 a)
select sum(quantidade), sum(preco) as total_valor from produtos;

-- Exercício 5 b)
select quantidade, preco, (quantidade * preco) as total_valor from produtos;

-- Exercício 6 a)
select count(produto) from produtos;

-- Exercício 6 b)
select max(preco) from produtos;

-- Exercício 6 c)
select min(preco) from produtos;

-- Exercício 6 d)
select if (sum(quantidade) > 298, 'Fora de estoque', 'Em estoque') as quant_estoque from produtos;

-- Exercício 7 a)
delimiter $$
create procedure sp_fatorial(in numero_fat int)
begin
	declare fatorial_numero_fat int default numero_fat;
    fatorial_loop: LOOP
		set fatorial_numero_fat = fatorial_numero_fat * (numero_fat - 1);
        set numero_fat = numero_fat - 1;
        if numero_fat = 1 then select fatorial_numero_fat; leave fatorial_loop;
        end if;
    end loop fatorial_loop;    
end;
$$
delimiter ;
call sp_fatorial(9);

-- Exercício 7 b)
delimiter $$
create procedure f_exponencial(in numero_1 int, in numero_2 int)
begin
	select power(numero_1,numero_2);
end;
$$
delimiter ;
call f_exponencial(6,2);

-- Exercício 7 c)
delimiter $$
create procedure palindromo(in palavra varchar(70))
begin
	select if(lower(palavra) = lower(reverse(palavra)),1,0) as verifica_palindromo;
end;
$$
delimiter ;
call palindromo('Chuva');
call palindromo('Ovo');
