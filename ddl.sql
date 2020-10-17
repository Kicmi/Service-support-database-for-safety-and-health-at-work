drop sequence seq_sro;
create sequence seq_sro
increment by 1
start with 123101
nocycle;

drop sequence seq_bs;
create sequence seq_bs
increment by 1
start with 911101
nocycle;


drop table radno_mesto cascade constraints;
drop table radna_okolina cascade constraints;
drop table radnik cascade constraints;
drop table pravno_lice cascade constraints;
drop table opasnost cascade constraints;
drop table stetnost cascade constraints;
drop table bioloska_stetnost cascade constraints;
drop table sadrzi_bs cascade constraints;
drop table gas cascade constraints;
drop table sadrzi_g cascade constraints;
drop table stetno_zracenje cascade constraints;
drop table sadrzi_sz cascade constraints;
drop table ukazuje cascade constraints;
drop table ukazuje_na cascade constraints;
drop table ispitivanje cascade constraints;
drop table strucni_nalaz_okoline cascade constraints;


create table radno_mesto (
srm number(6) check (srm>=0) not null,
rb_rm number(6) check(rb_rm>=0) not null,
naz_rm varchar2(50) not null,
duz_smn number(2) not null check (duz_smn >= 0),
br_smn number(1) not null check (br_smn >= 0),
orm varchar2(500),
riz number(1) not null check (riz= '0' or riz= '1'),
sro number(6) unique not null,
constraint radno_mesto_srm_rb_rm_pk primary key (srm,rb_rm)
);

create table radna_okolina(
sro number(6) primary key check (sro>=0),
naz_ro varchar2(50) not null,
constraint radna_okolina_sro_fk foreign key (sro) references
radno_mesto(sro)INITIALLY DEFERRED DEFERRABLE
);

alter table radno_mesto
add constraint radno_mesto_sro_fk foreign key (sro) references
radna_okolina(sro);

create table radnik(
mbr number(6) primary key check(mbr>=0),
ime varchar2(50) not null,
prz varchar2(50) not null,
email varchar2(100),
adr varchar2(100),
tel varchar2(50),
odg_ovr number(1) not null check (odg_ovr = '0' or odg_ovr = '1'),
odg_zad number(1) not null check (odg_zad = '0' or odg_zad = '1'));

create table ispitivanje(
sif_ispit number(6) primary key check(sif_ispit >= 0),
pib_pl number(8) not null unique,
srm number(6) ,
rb_rm number(6),
dat_isp date,
rok_isp date,
sro number(6),
rok_za_obav date,
dat_obav_isp date,
constraint ispitivanje_srm_fk foreign key (srm,rb_rm) references
radno_mesto(srm,rb_rm),
constraint ispitivanje_sro_fk foreign key(sro) references radna_okolina(sro)
);

create table pravno_lice(
pib_pl number(8) primary key check ((pib_pl >= 10000001) and (pib_pl <=
99999999)),
naz_pl varchar2(50) not null,
email_pl varchar2(50),
zak_zast varchar2(50) not null,
tel_pl varchar2(30) not null,
lic_opr number(1) not null,
lic_uro number(1) not null,
constraint pravo_lice_pib_pl_fk foreign key (pib_pl) references
ispitivanje(pib_pl) INITIALLY DEFERRED DEFERRABLE);

alter table ispitivanje
add constraint ispitivanje_pib_pl foreign key(pib_pl) references
pravno_lice(pib_pl);

create table strucni_nalaz_okoline(
sif_sn_ok number(6) check (sif_sn_ok >= 0),
dat_izd date not null,
oc_okl number(1) not null check (1<=oc_okl and oc_okl<=5),
temp number(6,2),
brz_st number(6,2) check (brz_st>=0),
rel_vlvz number(6,2) check (rel_vlvz >= 0),
para number(6,2),
pras number(6,2) check (pras >= 0),
buka number(6,2) check (buka>= 0),
vibr number(6,2) check (vibr >= 0),
osv number(6,2) check (osv >= 0),
sifra_ispit number(6) unique,
mbr number(6) not null,
dat_pot_okol date,
constraint strucni_nalaz_okoline_pk primary key (sifra_ispit,sif_sn_ok),
constraint strucni_nalaz_okoline_sif_isp_fk foreign key (sifra_ispit)
references ispitivanje(sif_ispit),
constraint strucni_nalaz_okoline_mbr_fk foreign key (mbr) references
radnik(mbr)
);

alter table ispitivanje
add constraint ispitivanje_sif_ispit_fk foreign key (sif_ispit) references
strucni_nalaz_okoline (sifra_ispit) INITIALLY DEFERRED DEFERRABLE;

create table opasnost(
sop number(6) primary key check(sop>=0),
naz_op varchar2(60) not null,
ops_opst varchar2(500)
);

create table stetnost(
sst number(6) primary key check (sst >= 0),
naz_st varchar2(60) not null,
ops_st varchar2(500),
min_doz_vr_st number(20,2) not null,
max_doz_vr_st number(20,2) not null,
jed_mer_st varchar2(50) not null
);

create table bioloska_stetnost(
sif_bs number(6) primary key check(sif_bs >= 0),
naz_bs varchar2(50) not null,
jed_mer_bs varchar2(50) not null
);

create table sadrzi_bs(
izm_vr_bs number(20,2) not null,
sif_bs number(6) not null,
sif_ispit number(6) not null,
sif_sn_ok number(6) not null,
constraint sadrzi_bs_pk primary key (sif_bs,sif_ispit,sif_sn_ok),
constraint sadrzi_bs_sif_bs foreign key (sif_bs) references
bioloska_stetnost(sif_bs),
constraint sadrzi_bs_sif_ispit_sn_ok foreign key (sif_ispit,sif_sn_ok)
references strucni_nalaz_okoline(sifra_ispit,sif_sn_ok)
);

create table gas(
sif_g number(6) primary key check(sif_g >= 0),
naz_g varchar2(50) not null,
jed_mer_g varchar2(50) not null
);

create table sadrzi_g(
izm_vr_g number(20,2),
sif_g number(6) not null,
sif_ispit number(6) not null,
sif_sn_ok number(6) not null,
constraint sadrzi_g_pk primary key (sif_g,sif_ispit,sif_sn_ok),
constraint sadrzi_g_sif_g foreign key (sif_g) references gas(sif_g),
constraint sadrzi_g_sif_ispit_sn_ok foreign key (sif_ispit, sif_sn_ok)
references strucni_nalaz_okoline (sifra_ispit, sif_sn_ok)
);

create table stetno_zracenje(
sif_z number(6) primary key check (sif_z >= 0),
naz_z varchar2(50) not null,
jed_mer_z varchar2(50) not null
);

create table sadrzi_sz (
izm_vr_z number(20,2),
sif_z number(6) not null,
sif_ispit number(6) not null,
sif_sn_ok number(6) not null,
constraint sadrzi_sz_pk primary key (sif_z,sif_ispit,sif_sn_ok),
constraint sadrzi_sz_sif_z foreign key (sif_z) references
stetno_zracenje(sif_z),
constraint sadrzi_sz_sif_ispit_sn_ok foreign key (sif_ispit,sif_sn_ok)
references strucni_nalaz_okoline(sifra_ispit,sif_sn_ok)
);

create table ukazuje(
sif_ispit number(6) not null,
sif_sn_ok number(6) not null,
sop number(6) not null,
constraint ukazuje_pk primary key (sif_ispit, sif_sn_ok, sop),
constraint ukazuje_sif_ispit_sn_ok_fk foreign key (sif_ispit,sif_sn_ok)
references strucni_nalaz_okoline(sifra_ispit,sif_sn_ok),
constraint ukazuje_sif_opst_sop_fk foreign key ( sop) references
opasnost(sop)
);

create table ukazuje_na(
sif_ispit number(6) not null,
sif_sn_ok number(6) not null,
sst number(6) not null,
constraint ukazuje_na_pk primary key (sif_ispit, sif_sn_ok, sst),
constraint ukazuje_na_sif_ispit_sn_ok_fk foreign key (sif_ispit, sif_sn_ok)
references strucni_nalaz_okoline (sifra_ispit, sif_sn_ok),
constraint ukazuje_na_sif_opst_sst_fk foreign key (sst) references stetnost
(sst)
);

