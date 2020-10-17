--PROCEDURE

/*1. Napisati proceduru koja za prosledjeni pib pravnog lica ispisuje
sva radna mesta na kojima je izvrsio periodicno ispitivanje.
a) Ukoliko postoji to pravno lice i ako je izvršio ispitivanja u zaglavlju treba da stoji: 
“Podaci o pravnom licu <p_pib> i radnom mestu”
Zatim sledi lista sa podacima o pravnom licu i radnom mestu.
Ispisati: PIB i naziv pravnog lica, šifru radnog mesta i datum ispitivanja.
b) Ako postoji pravno lice, a nije izvršio ispitivanja ispisati:
“Pravno lice sa pibom <pib> nije izvrsilo ispitivanje za radnu okolinu” --------------WORD--------------------------
c) Ako ne postoji pravno lice sa prosle?enim pibom ispisati:
"Ne postoji pravno lice sa pibom : <pib>."*/

create or replace procedure proc (p_pib pravno_lice.pib_pl%type) is --p_pib ce biti istog tipa kao pib_pl iz tabele pravno lice
cursor c_pl is --funkcionise kao neka petlja ELLAB
select distinct pl.pib_pl, pl.naz_pl, rm.srm, i.dat_isp --ako stavimo distinct nema ponavljanja vrednosti 
from pravno_lice pl, radno_mesto rm, ispitivanje i
where pl.pib_pl = i.pib_pl
and i.srm = rm.srm
and pl.pib_pl = p_pib; --ovo se pise na kraju svakog 'selecta'

v_pib number;
v_srm number;

begin
select count(pl.pib_pl)
into v_pib
from pravno_lice pl
where pl.pib_pl = p_pib; --prebroj pibove iz pravnog lica koji su jednaki prosledjenom pibu pri pozivanju procedure
                         --sa ovim smo proverili da li postoji to pravno lice koje smo prosledili
select i.srm
into v_srm
from ispitivanje i
where i.pib_pl = p_pib; -- proveravamo da li je pravno lice radilo ispitivanje na radnom mestu. 
--ako je srm not null onda znaci da je radio isptivianje nad radnim mestom a ako jeste null onda je radio
--isptivanje nad radnom okolinom


if v_srm is null then
raise_application_error(-20156,'Pravno lice nije izvrsilo ispitivanje nad radnim mestom');
else
dbms_output.put_line('Podaci o pravnom licu ' || p_pib || ' i radnom mestu'); --WORD
for brojac in c_pl loop
dbms_output.put_line(c_pl%rowcount || '. pib:' || brojac.pib_pl  || ', ime:' || brojac.naz_pl || 
', sifra radnom mesta:' || brojac.srm || ', datum ispitivanja:' || brojac.dat_isp);
end loop;
end if;
exception when no_data_found then
raise_application_error(-20155,'Ne postoji pravno lice sa prosledjenim pibom');
end;
/

execute proc (28129897); -- radi
execute proc (12345678); -- ne radi




/*2.Napisati proceduru koja za prosle?enu šifru gasa ispisuje sve 
informacije o tom gasu, kao i sva imena i prezimena radnika koji 
su potpisali stru?ni nalaz okoline koji sadrži gas sa prosle?enom šifrom.

Ako gas sa prosle?enom šifrom ne postoji, ispisati:
”Gas sa unetom sifrom <šifra> ne postoji.”*/

create or replace procedure proc2 (p_gas gas.sif_g%type) is
cursor c_g is
select g.sif_g, g.naz_g, g.jed_mer_g, r.ime, r.prz
from gas g, radnik r, sadrzi_g sg, strucni_nalaz_okoline sno
where g.sif_g = sg.sif_g
and sg.sif_sn_ok = sno.sif_sn_ok
and sno.mbr = r.mbr
and g.sif_g = p_gas;


v_gas number;

begin
select count (g.sif_g)
into v_gas
from gas g
where g.sif_g = p_gas;

if v_gas < 1 then
raise_application_error(-20167, 'Gas sa unetom sifrom ' || p_gas || ' ne postoji'); ---WORD----
else
for brojac in c_g loop
dbms_output.put_line(c_g%rowcount || '. sifra gasa: ' || brojac.sif_g ||
', naziv gasa: ' || brojac.naz_g || ', jedinica mere: ' || brojac.jed_mer_g || 
', ime radnika: ' || brojac.ime || ', prezime radnika: ' || brojac.prz);
end loop;
end if;
end;
/

execute proc2(214887);



------------------------------------------------------------------------------------------------------------------
--TRIGERI

/*1. Napisati triger koji ?e se aktivirati pri unosu vrednosti
u tabelu radnik ili izmeni maticnog broja. Ako je duzina novog maticnog
broja razlicita od 6 ispisati gresku da duzina mora biti 6 karaktera.*/

create or replace trigger trig 
before insert or update of mbr on radnik
for each row
declare
v_mbr number;
pragma AUTONOMOUS_TRANSACTION; --VIDI STA OVO ZNACI PITACE

begin
select distinct length(:new.mbr)
into v_mbr
from radnik;

if v_mbr != 6 then --ako je razlicito od 6, moze da stoji i < jer smo vece regulisali kod pravljenja tabele da ne moze vise od 6 karaktera
raise_application_error(-20184,'Duzina mbr mora biti 6 karaktera');
end if; --ako se ukuca duzina mbr 7 i vise karaktera ispisace se druga greska jer smo ogranicenjem rekli da mbr moze da ima max 6 karaktera. ako upisemo 5 i manje onda ce se ispisati ova greska.
end;
/


/*
update radnik
set mbr = 45698
where lower(ime) = 'uros';
*/
drop trigger trig;


insert into radnik values (123456, 'Uros', 'Dyatlov', 'nographite@chernobyl.com', 'Chernobyl Exclusion Zone', 63123456,1,1 );
delete from radnik where mbr = 123456;

/*
declare
v_mrr number;
begin
select length(mbr)
into v_mrr
from radnik
where mbr = 110595;
dbms_output.put_line(v_mrr);
end;
/
*/



/*Napraviti triger koji ce se aktivirati nad tabelom pravno lice svaki put pri upisu ili izmeni
emaila. Ako na kraju nije upisano .com ispisati gresku 
'Mail mora da sadrzi @chernobyl.com na kraju'*/
 ---WORD----

create or replace trigger trig2 
before insert or update of email_pl on pravno_lice
for each row
declare
v_email pravno_lice.email_pl%type;

begin

if lower(:new.email_pl) not like lower('%@chernobyl.com') then -- procenat znaci da ima jos neki tekst pre @cher... kad bi bio i posle .com onda znaci da moze jos neki tekst da se javi posle al posto je to kraj maila nema %
raise_application_error(-20185,'Mail mora da sadrzi @chernobyl.com na kraju'); ---WORD---
end if;
end;
/
/*
insert into pravno_lice values (12345678, 'Comrade Uros mlade', 'uros@chernobyl.com', 'RBMK', '1-463-357-3364',1,1);
insert into pravno_lice values (12345678, 'Comrade uros Watson', null, 'RBMK', '1-225-548-4804',1,0);

delete from pravno_lice where pib_pl = 12345678;
*/


select email_pl
from pravno_lice
where lower(email_pl) like lower('%@chernobyl.com');



---------------------------------------------------------------------------------------------------------
--FUNKCIJE
/*
1. Napisati funkciju koja ce za prosledjenu sifru opasnosti vracati 
sifru strucnog nalaza okoline na koji ukazuje.

Ako ne postoji opasnost sa prosledjenom sifrom ispisati gresku
'Ne postoji opasnost sa prosledjenom sifrom'
---WORD----
*/

create or replace function func1 (p_sop in opasnost.sop%type) 
return number
is

v_ssno number;
v_sop number;

begin
select count(sop)
into v_sop
from opasnost
where sop = p_sop; -- isto kao kod procedure


if v_sop < 1 then
raise_application_error(-20157, 'Ne postoji opasnost sa prosledjenom sifrom');
else
select sno.sif_sn_ok
into v_ssno
from strucni_nalaz_okoline sno, opasnost o, ukazuje u
where sno.sif_sn_ok = u.sif_sn_ok
and u.sop = o.sop
and o.sop = p_sop;
return v_ssno;
end if;
end;
/

begin
dbms_output.put_line('Sifra strucnog nalaza okoline je: ' || func1(911302));
end;
/



/*
2. Napisati funkciju koja za prosledjeni pib pravnog lica ispisuje sifru gasa koja je 
sadrzana u strucnom nalazu okoline kojim je on izvrsio ispitivanje OVO MALO LEPSE NAPISI

Ako ne postoji pravno lice sa prosledjenim pibom ispisati gresku 
'Ne postoji pravno lice sa prosledjenim pibom <pib>'. ----WORD----
*/

create or replace function func2 (p_pib in pravno_lice.pib_pl%type)
return number
is

v_gas gas.sif_g%type;
v_pib number;


begin
select count(pl.pib_pl)
into v_pib
from pravno_lice pl
where pib_pl= p_pib;

if v_pib < 1 then
raise_application_error(-20163, 'Ne postoji pravno lice sa prosledjenim pibom ' || p_pib); ----WORD----
else
select g.sif_g
into v_gas
from pravno_lice pl, ispitivanje i, strucni_nalaz_okoline sno, sadrzi_g sg, gas g
where pl.pib_pl = i.pib_pl
and i.sif_ispit = sno.sifra_ispit
and sno.sif_sn_ok = sg.sif_sn_ok
and sg.sif_g = g.sif_g
and pl.pib_pl = p_pib;

return v_gas;
end if;
end;
/


begin 
dbms_output.put_line('Sifra gasa je: ' || func2(281298981));
end;
/



-------------------------------------------------------------------------------------------------------------------




----PAKET

create or replace package pac1 is
procedure proc (p_pib pravno_lice.pib_pl%type);
function func1 (p_sop in opasnost.sop%type) 
return number;
end pac1;
/

create or replace package body pac1 is
procedure proc (p_pib pravno_lice.pib_pl%type) is --p_pib ce biti istog tipa kao pib_pl iz tabele pravno lice
cursor c_pl is --funkcionise kao neka petlja ELLAB
select distinct pl.pib_pl, pl.naz_pl, rm.srm, i.dat_isp --ako stavimo distinct nema ponavljanja vrednosti 
from pravno_lice pl, radno_mesto rm, ispitivanje i
where pl.pib_pl = i.pib_pl
and i.srm = rm.srm
and pl.pib_pl = p_pib; --ovo se pise na kraju svakog 'selecta'

v_pib number;
v_srm number;

begin
select count(pl.pib_pl)
into v_pib
from pravno_lice pl
where pl.pib_pl = p_pib; --prebroj pibove iz pravnog lica koji su jednaki prosledjenom pibu pri pozivanju procedure
                         --sa ovim smo proverili da li postoji to pravno lice koje smo prosledili
select i.srm
into v_srm
from ispitivanje i
where i.pib_pl = p_pib; -- proveravamo da li je pravno lice radilo ispitivanje na radnom mestu. 
--ako je srm not null onda znaci da je radio isptivianje nad radnim mestom a ako jeste null onda je radio
--isptivanje nad radnom okolinom


if v_srm is null then
raise_application_error(-20156,'Pravno lice nije izvrsilo ispitivanje nad radnim mestom');
else
dbms_output.put_line('Podaci o pravnom licu ' || p_pib || ' i radnom mestu'); --WORD
for brojac in c_pl loop
dbms_output.put_line(c_pl%rowcount || '. pib:' || brojac.pib_pl  || ', ime:' || brojac.naz_pl || 
', sifra radnom mesta:' || brojac.srm || ', datum ispitivanja:' || brojac.dat_isp);
end loop;
end if;
exception when no_data_found then
raise_application_error(-20155,'Ne postoji pravno lice sa prosledjenim pibom');
end proc;

function func1 (p_sop in opasnost.sop%type) 
return number
is

v_ssno number;
v_sop number;

begin
select count(sop)
into v_sop
from opasnost
where sop = p_sop; -- isto kao kod procedure


if v_sop < 1 then
raise_application_error(-20157, 'Ne postoji opasnost sa prosledjenom sifrom');
else
select sno.sif_sn_ok
into v_ssno
from strucni_nalaz_okoline sno, opasnost o, ukazuje u
where sno.sif_sn_ok = u.sif_sn_ok
and u.sop = o.sop
and o.sop = p_sop;
return v_ssno;
end if;
end func1;
end pac1;
/

execute pac1.proc(28129897); -- radi, napisati u wordu bez komentara

begin
dbms_output.put_line('Sifra strucnog nalaza okoline je: ' || pac1.func1(911302));
end;
/







