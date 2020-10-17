/*1.Izlistati podatke o šifri, o nazivu štetnog zra?enja i o 
jedinici mere kojom se ono izražava kao i u kojem stru?nom nalazu
se nalazi. Tako?e, za stru?ni nalaz okoline treba ispisati
njegovu šifru, datum izdavanja i ocenu.*/

select sz.sif_z, sz.naz_z,sz.jed_mer_z, sno.sif_sn_ok,sno.dat_izd,oc_okl
from stetno_zracenje sz,strucni_nalaz_okoline sno, sadrzi_sz ssz
where sz.sif_z = ssz.sif_z
and ssz.sif_sn_ok = sno.sif_sn_ok;



/*2. Selektovati radno mesto i pravno lice koje je na njemu obavljalo periodi?no ispitivanje. 
Za radno mesto izdvojiti šifru i naziv, a za pravno lice njegov pib, naziv i
e-mail (ako ga ima, a ako nema napisati “nepoznat e-mail”).*/
select rm.srm, rm.naz_rm, pl.pib_pl, pl.naz_pl, nvl(pl.email_pl,'Nepoznat-email') --kod nvl2 bi napisao tekst 'Poznat e-mail', ovde ispisuje mail pravnog lica (iz tabele)
from radno_mesto rm, pravno_lice pl, ispitivanje i
where pl.pib_pl = i.pib_pl 
and i.srm = rm.srm;



--3. Selektovati sifru strucnog nalaza, datum, sifru ispitivanja stru?nog nalaza okoline 
--?ije je ispitivanje izvršilo pravno lice sa pib-om 12129960.
select sno.sif_sn_ok, sno.dat_izd, sifra_ispit
from strucni_nalaz_okoline sno, ispitivanje i, pravno_lice pl
where sno.sifra_ispit = i.sif_ispit
and i.pib_pl = pl.pib_pl
and pl.pib_pl = 12129960;



--4. Selektovati šifru radne okoline ?ije preventivno ispitivanje obavljaju pravna lica sa zakonskim zastupnikom 'RBMK'.
select ro.sro
from radna_okolina ro, ispitivanje i, pravno_lice pl
where ro.sro = i.sro
and i.pib_pl = pl.pib_pl
and lower(pl.zak_zast) = 'rbmk'; --vrednosti iz tabele 'stavlja u lower case' POGLEDATI NA ELLABU


--5. Selektovati  mbr, ime i prezime radnika koji je potpisao stru?ni nalaz okoline gde je izmereno 'Alpha radiation' štetno zra?enje.
select r.mbr, r.ime, r.prz
from radnik r, strucni_nalaz_okoline sno, stetno_zracenje sz,sadrzi_sz ssz
where sno.mbr = r.mbr
and sno.sif_sn_ok = ssz.sif_sn_ok
and ssz.sif_z = sz.sif_z
and lower(sz.naz_z) = 'alpha radiation';
