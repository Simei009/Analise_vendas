create database comuniDados;
use comuniDados;

create table vendas_desafio(
	id_venda int primary key,
	data_venda date not null,
	cliente varchar(50) not null,
	produto varchar(50) not null,
	categoria varchar(50) not null,
	quantidade int not null,
	preco_unitario decimal(10,2) not null,
	vendedor varchar(50) not null,
	cidade varchar (50) not null,
	estado varchar(50) not null
);

select * from vendas_desafio;

-- Faturamento total por produto
select produto, sum(quantidade * preco_unitario) as faturamento_total_produto
from vendas_desafio
group by produto
order by faturamento_total_produto desc;

-- Faturamento total por categoria
select categoria, sum(quantidade * preco_unitario) as faturamento_total_categoria
from vendas_desafio
group by categoria
order by categoria desc;

-- Ticket medio por cliente
select cliente, round(avg(quantidade * preco_unitario)) as ticket_medio_cliente
from vendas_desafio
group by cliente
order by ticket_medio_cliente desc;

-- Faturamento total por vendedor
select vendedor, sum(quantidade * preco_unitario) as faturamento_total
from vendas_desafio
group by vendedor
order by faturamento_total desc;

-- Faturamento por mes
select 
    date_format(data_venda, '%M') as mes,
    sum(quantidade * preco_unitario) as faturamento_mensal
from vendas_desafio
group by year(data_venda), month(data_venda)
order by year(data_venda), month(data_venda);

-- 5 produtos mais vendidos
select 
	produto,
	sum(quantidade) as quantidade_total
from vendas_desafio
group by id_venda,produto
order by quantidade_total desc
limit 5;

-- cidade maior faturamento
select 
	cidade,
	sum(quantidade * preco_unitario) as maior_faturamento
from vendas_desafio
group by cidade
order by maior_faturamento desc;

-- Cliente que mais comprou
select 
	cliente,
	sum(quantidade * preco_unitario) as maior_total_gasto
from vendas_desafio
group by cliente
order by maior_total_gasto desc
limit 1;

-- Cidade com maior faturamento
SELECT *
FROM (
    SELECT
        cidade,
        SUM(quantidade * preco_unitario) AS faturamento_total,
        RANK() OVER (ORDER BY SUM(quantidade * preco_unitario) DESC) AS cidade_maior_faturamento
    FROM vendas_desafio
    GROUP BY cidade
) as ranking
WHERE cidade_maior_faturamento in (1);