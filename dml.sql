insert into bioloska_stetnost values (seq_bs.nextval, 'Mask', 'Becquerel');
insert into bioloska_stetnost values (seq_bs.nextval, 'Robe', 'Becquerel');
insert into bioloska_stetnost values (seq_bs.nextval, 'Gloves', 'Becquerel');
insert into bioloska_stetnost values (seq_bs.nextval, 'Injection', 'Becquerel');
insert into bioloska_stetnost values (seq_bs.nextval, 'Container', 'Becquerel');


insert into gas values (772695,'Bromine Br2', 'ppm');
insert into gas values (214887,'Hydrogen sulfide H2S', 'ppm');
insert into gas values (780352,'Stibine H3Sb', 'ppm');
insert into gas values (778380,'Tellurium hexafluoride TeF6', 'ppm');
insert into gas values (778250,'Chlorine Cl2', 'ppm');


insert into opasnost values (911911, 'Meltdown', 'A large amount of energy suddenly released vapourising superheated cooling water and ruptures the reactor pressure vessel in a highly destructive steam explosion. This immediately follows an open-air reactor core fire which releaseds considerable airborne radioactive contamination.');
insert into opasnost values (911302, 'Radiation Leak', 'There is a leak somewhere');
insert into opasnost values (911303, 'Radiation Poisoning', 'Death is imminent, get your affairs in order');
insert into opasnost values (911304, 'Graphite on the roor', 'There is no graphite on the roof you are delusional');
insert into opasnost values (911305, 'Explosion', 'Boom');


insert into pravno_lice values (28129898, 'Comrade Ulana Khomyuk', 'umlana@chernobyl.com', 'RBMK', '1-463-357-3364',1,1);
insert into pravno_lice values (28129897, 'Comrade Emily Watson', null, 'RBMK', '1-225-548-4804',1,0);
insert into pravno_lice values (14019678, 'Comrade Lyudmila Ignatenko', 'lyudmila@chernobyl.com', 'RBMK', '1-572-616-2121',1,1);
insert into pravno_lice values (14019677, 'Comrade Jessie Byckley', null, 'RBMK', '869-209-3602', 1, 0);
insert into pravno_lice values (12129960, 'Comrade Boris Jovanovic', 'boristheanimal@gmail.com', 'RBMK', '1-905-575-7654', 0, 0);

insert into radna_okolina values (seq_sro.nextval, 'Control room');
insert into radna_okolina values (seq_sro.nextval, 'Coolling station');
insert into radna_okolina values (seq_sro.nextval, 'Reactor');
insert into radna_okolina values (seq_sro.nextval, 'Waste disposal');
insert into radna_okolina values (seq_sro.nextval, 'Office');



insert into radnik values (110595, 'Anatoly', 'Dyatlov', 'nographite@chernobyl.com', 'Chernobyl Exclusion Zone', 63123456,1,1 );
insert into radnik values (120606, 'Valery', 'Legasov', 'yesgraphite@chernobyl.com', 'Chernobyl Exclusion Zone', 63234567,0,1);
insert into radnik values (131717, 'Boris', 'Shcherbina', 'bullet@chernobyl.com', 'Chernobyl Exclusion Zone', 63345678,1,0);
insert into radnik values (142828, 'Vasily', 'Ignatenko', 'touch@chernobyl.com', 'Chernobyl Exclusion Zone', 63456789, 0, 0 );
insert into radnik values (153939, 'Stefan', 'Bolesnikov', 'stele@gmail.com', 'Novi Sad',64123456,0,0);


insert into radno_mesto values(123111, 1, 'Button operator', 8, 3, 'Pray you push the right buttons', 1, 123101);
insert into radno_mesto values(123111, 2, 'Dyatlov desk', 8, 3, '3.6 Roentgen, not great not terrible', 1, 123102);
insert into radno_mesto values(123112, 1, 'Valve operator', 8, 3, 'Find the righ pipe', 0, 123103);
insert into radno_mesto values(123113, 1, 'Desk job', 8, 2, 'Waste your life away', 0, 123104);
insert into radno_mesto values(123114, 1, 'SWTrashCompactor', 8, 1, 'Do not dump the waste in the river', 0, 123105);


insert into stetno_zracenje values (987100, 'Alpha radiation', 'Roentgen');
insert into stetno_zracenje values (987101, 'Beta radiation', 'Roentgen');
insert into stetno_zracenje values (987102, 'Gamma radiation', 'Roentgen');
insert into stetno_zracenje values (987103, 'Neutron radiation', 'Roentgen');


insert into stetnost values (926100, 'Radiation', 'In physics, radiation is the emission or transmission of energy in the form of waves or particles through space or through a material medium.',0,0.25,'Sv');
insert into stetnost values (926101, 'Radioactive burns', 'Burns that are a result of beta radiation they are created when the body comes into contact with contaminated particles',0,0.1,'Not defined');
insert into stetnost values (926102, 'Effect on the natural world', 'An uncontrolled nuclear reaction in a nuclear reactor could result in widespread contamination of air and water.',0,0.3, 'Units effected');
insert into stetnost values (926103, 'Effect on the wild life', 'As people were evacuated 25 years ago, the animals have remained.', 0,0.4,'Units infected');


insert into ispitivanje values (911201, 28129898, 123111, 1, to_date('29.04.2018', 'dd.mm.yyyy'),to_date('28.04.2021', 'dd.mm.yyyy'), null, null, null);
insert into ispitivanje values (911202, 28129897, 123111, 2, to_date('26.12.2018', 'dd.mm.yyyy'), to_date('25.12.2021', 'dd.mm.yyyy'), null, null, null);
insert into ispitivanje values (911203, 14019678, null, null, null, null, 123103, to_date('19.5.2019', 'dd.mm.yyyy'), to_date('19.11.2018', 'dd.mm.yyyy'));
insert into ispitivanje values (911204, 14019677, 123114, 1, to_date('03.07.2018', 'dd.mm.yyyy'), to_date('02.07.2021', 'dd.mm.yyyy'), null, null, null);
insert into ispitivanje values (911205, 12129960, null, null, null, null, 123105, to_date('06.09.2018', 'dd.mm.yyyy'), to_date('06.03.2018', 'dd.mm.yyyy') );

insert into strucni_nalaz_okoline values (123456, to_date('19.07.2018', 'dd.mm.yyyy'), 5, 31.5, 0.5, 60, 15.5, 5, 70,20, 300, 911201, 110595, to_date('19.07.2018', 'dd.mm.yyyy'));
insert into strucni_nalaz_okoline values (234567, to_date('26.09.2018', 'dd.mm.yyyy'), 5, null, 1.3, 30, 10.7, 1, 90,25, 400, 911202, 120606, to_date('26.09.2018', 'dd.mm.yyyy'));
insert into strucni_nalaz_okoline values (345678, to_date('06.02.2019', 'dd.mm.yyyy'), 5, 33.1, 2.4, 20, 3, null, 60, 10, 350, 911203, 131717, to_date('06.02.2019', 'dd.mm.yyyy'));
insert into strucni_nalaz_okoline values (456789, to_date('02.05.2019', 'dd.mm.yyyy'), 5, 35.8, 0.9, 40, 7, 6, 110, null, 500, 911204, 142828, to_date('02.05.2019', 'dd.mm.yyyy'));
insert into strucni_nalaz_okoline values (567890, to_date('19.07.2018', 'dd.mm.yyyy'), 5, null, 1.7, 10, 2, 7, 100, null, 550, 911205,153939, to_date('19.07.2018', 'dd.mm.yyyy'));


insert into sadrzi_bs values (1018,911101, 911201, 123456);
insert into sadrzi_bs values (1015,911102, 911202, 234567);
insert into sadrzi_bs values (1012,911103, 911203, 345678);
insert into sadrzi_bs values (109, 911104, 911204, 456789);
insert into sadrzi_bs values (106, 911105, 911205, 567890);


insert into sadrzi_g values(0.37, 772695, 911201, 123456);
insert into sadrzi_g values(0.66, 214887, 911202, 234567);
insert into sadrzi_g values(0.05, 780352, 911203, 345678);
insert into sadrzi_g values(0.22, 778380, 911204, 456789);
insert into sadrzi_g values(0.29, 778250, 911205, 567890);


insert into sadrzi_sz values (0.03, 987100, 911201, 123456);
insert into sadrzi_sz values (10, 987101, 911202, 234567);
insert into sadrzi_sz values (300, 987102, 911203, 345678);
insert into sadrzi_sz values (10, 987103, 911204, 456789);
insert into sadrzi_sz values (0.15, 987100, 911205, 567890);


insert into ukazuje values (911201,123456,911911);
insert into ukazuje values (911202,234567,911302);
insert into ukazuje values (911203,345678,911303);
insert into ukazuje values (911204,456789,911304);
insert into ukazuje values (911205,567890,911305);



insert into ukazuje_na values (911201,123456,926100);
insert into ukazuje_na values (911202,234567,926101);
insert into ukazuje_na values (911203,345678,926102);
insert into ukazuje_na values (911204,456789,926103);
insert into ukazuje_na values (911205,567890,926100);
commit;
