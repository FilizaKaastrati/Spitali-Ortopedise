create database Spitali_Ortopedise

use Spitali_Ortopedise

create table pacienti(
  idPacienti int primary key identity (1,1) not null, 
  emri varchar(20) not null,
  mbiemri varchar(20),
  dateLindja date,
  qyteti varchar(30),
  rruga varchar (49),
  gjinia char (1) not null check(gjinia in ('F','M')),
)

select*
from pacienti

create table stafi(
   idStaf int primary key,
   emri varchar (50) not null,
   dataLindjes date,
   gjinia char (1) not null check(gjinia in ('F','M')),
   data_pranimit date,
   dataLargimit date,
   OrariPunes varchar(20),
   LLojiStafit varchar (30),
   menaxhuesi int foreign key references stafi(idStaf)
)


create table doktori(
    dokId int references stafi(idStaf),
	primary key (dokId),
)
Alter table doktori
add specializon varchar(50) 

alter table doktori
add paga money

select*
from doktori

create table menaxheri(
	idMenaxheri int foreign key references stafi(idstaf),
	primary key (idMenaxheri)
)
Alter table menaxheri
add paga money 

create table Recepcionisti(
    idRecepcionisti int foreign key references stafi(idStaf),
	primary key (idRecepcionisti),
)
Alter table Recepcionisti
add lloji varchar(30)

Alter table Recepcionisti
add paga money 


create table pacienti_recepcionist(
  Pacienti int not null references pacienti(idPacienti),
  Recepcionisti int not null references recepcionisti (idRecepcionisti),
  primary key (Pacienti,Recepcionisti)
)

select *
from recepcionisti


create table email(
  emaili varchar(70) not null unique,
  idPacienti int foreign key references pacienti(idPacienti),
  primary key(emaili, idPacienti),
)

select *
from email

create table diagnoza(
   idPacienti int not null foreign key references pacienti(idPacienti),
   idDiagnoza int not null,
   semundja varchar(50),
   Shtrihet_dhom char (2) not null check(Shtrihet_dhom in ('po','jo')),
   operacion  char (2) not null check(operacion in ('po','jo')),
   analizat varchar (50),
   primary key (idDiagnoza,idPacienti),
   doktori int foreign key references doktori(dokId) 
)
select *
from diagnoza

Alter table diagnoza
add  rentgen char (2) check(rentgen in ('po','jo'))

--drop table diagnoza

create table dhoma(
    idDhoma int primary key,
	nrShtreterve int
)
select* from dhoma

create table dhoma_diagnoza(
 idDiagnoza int,
 idPacienti int,
 foreign key (idDiagnoza,idPacienti) references diagnoza(idDiagnoza,idPacienti),
 dhoma int foreign key references dhoma(idDhoma),
 primary key (idDiagnoza,idPacienti,Dhoma)
)
-- drop table dhoma_diagnoza
select*
from dhoma_diagnoza

create table infermieri(
    idInfermieri int references stafi(idStaf),
	dhoma int foreign key references dhoma(idDhoma) not null,
	primary key (idInfermieri)
)
Alter table infermieri
add paga money  

select *
from infermieri

create table pastruesi(
    idpastruesi int references stafi(idStaf),
	primary key (idpastruesi),
)
Alter table pastruesi
add lloji  varchar (50) 

Alter table pastruesi
add paga money 

select *
from pastruesi f inner join  stafi s on s.idStaf = f.idpastruesi

create table Kuzhinieret(
    idKuzhinieret int references stafi(idStaf),
	primary key (idKuzhinieret),
)
Alter table Kuzhinieret
add paga money  

select *
from Kuzhinieret

create table Departamenti(--done
    idDepartamenti int primary key,
	emri_departamentit varchar(30),
)
select *
from Departamenti

create table Sallat(
    idSalles int primary key,
)

Alter table sallat
add emri_salles varchar(50) not null

 select *
 from Sallat

create table medikamentet(
   idMedikamentet int primary key,
   emriMedikamentit varchar(50),
   cmimi money,
   doza varchar(30)
)
select *
from medikamentet


create table Diagnoza_Medikamentet(
 iddiagnoza int not null,
 idPacienti int not null,
 idMedikamentet int not null,
 doza varchar(255),
 foreign key (idDiagnoza,idPacienti) references diagnoza(idDiagnoza,idPacienti),
 primary key (iddiagnoza,idpacienti,idmedikamentet)
)
--drop table Diagnoza_Medikamentet

 select*
 from Diagnoza_Medikamentet

create table intervali(
  iddiagnoza int not null,
  idmedikamentet int not null,
  idpacienti int not null,
  nr_intervali int,
  primary key( nr_intervali, iddiagnoza, idmedikamentet, idpacienti),
  foreign key (idDiagnoza,idPacienti,idmedikamentet) references Diagnoza_Medikamentet(idDiagnoza,idPacienti,idmedikamentet),
)
Alter table intervali
add intervali_kohor varchar(70) not null

 select*
 from intervali

create table salla_diagnoza(
  iddiagnoza int not null,
  idPacienti int not null,
  idSalles int not null,
  foreign key (idDiagnoza,idPacienti) references diagnoza(idDiagnoza,idPacienti),
  primary key (idDiagnoza,idPacienti, idsalles)
)
select *
from salla_diagnoza

 create table stafi_sallat_departamenti(
   idDepartamenti int not null  foreign key references Departamenti(idDepartamenti),
   idStaf int not null foreign key references Stafi(idStaf),
   idSalles int not null foreign key references Sallat(idsalles),
   primary key (idDepartamenti,idStaf,idSalles )
 )
 select*
 from stafi_sallat_departamenti

create table fatura(
   idFatura int primary key,
   cmimi_analizave money,
   cmimi_medikamenteve money,
   cmimi_dhomes money
)
create table paguhet(--undone
   idPacienti int not null,
   idRecepcionisti int not null,
   foreign key (idPacienti,idRecepcionisti) references pacienti_recepcionist(Pacienti,Recepcionisti),
   idfatura int foreign key references fatura(idfatura),
   primary key (idPacienti, idRecepcionisti,idfatura)
)

select*
from paguhet


select*
from pacienti_recepcionist
  
  
update diagnoza
set analizat= 'te pergjithshme'
where analizat ='asnje'

update diagnoza
set analizat= 'asnje'
where analizat ='e pergjithshme'

update pacienti
set gjinia= 'F'
where gjinia ='M'

update email
set emaili= 'gent.berisha12@gmail.com'
where emaili ='gent.berisha@gmail.com'

update stafi
set dataLargimit= null
where dataLargimit ='01-01-2020'

update diagnoza
set semundja='Morbus Pot'
where semundja ='Demtimi I Ligamenteve,'

update pacienti
set emri = 'kasltrina'
where emri ='filiza'

update pacienti
set mbiemri='shala'
where mbiemri ='kastrati'

update stafi
set dataLargimit= '01-01-2020'
where dataLargimit =null

update stafi
set emri= 'adem'
where emri ='cene'

update diagnoza
set semundja='pev'
where semundja ='pondilolisteza'

update diagnoza
set operacion= 'J0'
where operacon ='PO'

update diagnoza
set operacion= 'PO'
where operacon ='JO'

update medikamentet
set doza='400mg'
where doza='200mg'

update diagnoza
set analizat= 'te pergjithshme'
where analizat ='asnje'

update diagnoza
set analizat= 'asnje'
where analizat ='e pergjithshme'

update pacienti
set gjinia= 'F'
where gjinia ='M'

update email
set emaili= 'filizakastrati1@gmail.com'
where emaili ='filiza.kastrati@gmail.com'

update medikamentet
set emriMedikamentit='paracetamol'
where emriMedikamentit='Aspirin'

update medikamentet
set doza='200mg'
where doza='100mg'


delete from pacienti
where emri ='filiza'

 delete from pacienti
 where mbiemri ='Kastrati'

 delete stafi
 where emri ='kosovare'

 delete stafi 
 where dataLargimit= ' 05-12-2011'

 delete medikamentet 
 where doza = '100mg'

 delete intervali
 where intervali_kohor ='21:00'

 delete fatura
 where cmimi_dhomes=150.0

 delete Departamenti
 where emri_departamentit='gjinokologjia'

 delete dhoma
 where nrShtreterve = 5

 delete email
 where emaili ='filiza.kastrati@gmail.com'



 -- < Të krijoni min. 8 query të thjeshta (4 për student), të realizohen vetëm me një relacion >

 --1. te listohen te gjith pacientet qe jan femra 

 select p.emri, p.mbiemri, p.gjinia
 from pacienti p
 where gjinia='F'

 --2 selektoj te gjith menaxherat qe jan larguar selektimi te behet sipas 
 --emrit te menaxherit, gjinise, dates se pranimit dhe dates se largimit
select s.emri, s.gjinia, s.data_pranimit, s.dataLargimit
from stafi s
where s.LLojiStafit ='menaxher' and s.dataLargimit is not null


 --3. te listohen te gjith doktoret qe gjenden ne tabelen stafi 

 select  s.emri, s.LLojiStafit
 from stafi s
 where LLojiStafit = 'doktorr'

 -- 4 te shfaqet id e te gjith pacienteve qe shtrihen ne dhome 

select d.idPacienti, d.idDiagnoza, d.shtrihet_dhom
from diagnoza d
where shtrihet_dhom ='po'


--5 te listohen te gjith medikamentet qe kan dozen 200mg

select m.emriMedikamentit, m.doza
from medikamentet m
where doza ='200mg '

--6 te listohen te gjith stafi te cilet daten e largimit nuk e kan null 

select s.emri, s.dataLargimit
from stafi s
where s.dataLargimit is not null

--7 te listohen te gjith kuzhinieret qe gjenden ne tabelen stafi

 select  s.emri, s.LLojiStafit, s.gjinia
 from stafi s
 where LLojiStafit = 'kuzhiner'

--8 te listohen pacientet me ane te id-se qe ju nevoitet ti bejn analizat e pergjithshme 

select d.idpacienti, d.analizat
from diagnoza d 
where d.analizat ='te pergjithshme'

--9 te listohen i gjith stafi ku orari i tyre i punes eshte paradite 

select s.emri, s.gjinia, s.LLojiStafit, s.OrariPunes
from stafi s
where s.OrariPunes='08:00-17:00'

 --10. te listohen te gjithe pacientet qe vine nga peja 

 select p.emri, p.mbiemri , p.qyteti
 from pacienti p
 where qyteti='peje'



-- < Të krijoni min. 8 query të thjeshta (4 për student), të realizohen në minimum dy relacione >

--1 selekto infermierin qe kujdeset per dhomen me id-101 ku selektimi te behet 
--nbaz te id-se se infermieri po ashtu dhe id-se se dhomes

select i.idInfermieri, dh.idDhoma
from  infermieri i, dhoma dh
where dh.idDhoma = i.Dhoma and i.Dhoma= 103


--select i.idInfermieri, dh.idDhoma
--from  infermieri i inner join on dhoma dh   dh.idDhoma = i.Dhoma and i.Dhoma= 103
--where dh.idDhoma = i.Dhoma and i.Dhoma= 103

--2 te shfaqen te gjith email-at e pacienteve

select p.emri, p.mbiemri , e.emaili
from pacienti p, email e
where p.idPacienti = e.idPacienti 

--3 te shfaqen te gjith pacientet qe si semundje kan Dëmtimi I miniskusit
select p.idPacienti, p.emri, d.semundja
from diagnoza d, pacienti p
where p.idPacienti = d.idpacienti and d.semundja ='Dëmtimi I miniskusit'

--4 selektoni te gjith pacientet qe shtrihen ne dhomen me id 104 
select p.emri, p.mbiemri, dhd.dhoma
from pacienti p, diagnoza d, dhoma dh, dhoma_diagnoza dhd
where p.idPacienti = dhd.idPacienti and d.idDiagnoza = dhd. idDiagnoza and dh.idDhoma = dhd.dhoma
and dhd.dhoma=104

--5 te selektooni te gjith pacientet qe marin medikamentet 09:00 dhe 21:00 selektimi te behet 
-- me ane te emrit te pacientit, mbiemrit te pacientit dhe emrit te medikamentit.

select p.emri, p.mbiemri, m.emriMedikamentit, i.intervali_kohor
from pacienti p, medikamentet m, intervali i 
where i.idpacienti = p.idPacienti and m.idMedikamentet = i.idmedikamentet and i.intervali_kohor ='09:00 dhe 21:00'

--6 te selektohen te gjith pacientet qe jan regjistruar nga i njejti recepcionist me id 30
-- selektimi te behet me na te emrit te pacientit mbimerit te pacientit dhe id-se se recepcionistit

select p.emri, p.mbiemri, r.idRecepcionisti
from pacienti p, pacienti_recepcionist pr, Recepcionisti r 
where p.idPacienti = pr.Pacienti and r.idRecepcionisti = pr.Recepcionisti 
and pr.Recepcionisti = 030

--7 te selektohen te gjith pacientet qe marin medikamentet me doze 100mg 
-- selektimi te behet emri i pacientit emri i medikamentit dhe doza e medikametit 

select p.emri, p.mbiemri, m.emriMedikamentit, dm.doza
from pacienti p, medikamentet m, Diagnoza_Medikamentet dm
where dm.idpacienti = p.idPacienti and m.idMedikamentet = dm.idmedikamentet and dm.doza ='100mg'

--8 te selektohen te gjith pacientet qe gjenden ne sallen e laboratorikes 
select p.emri, p.mbiemri, s.emri_salles 
from Sallat s, salla_diagnoza sd, pacienti p
where s.idSalles = sd.idSalles and p.idPacienti = sd.idPacienti and 
sd.idSalles=502



-- < Të krijoni min. 8 query të avancuara (4 për student), të realizuara në minimum dy relacione >

-- 1.te numerohen te gjth pacientet se sa her kan ber pagesen per dhomen  me shume mbi 100 euro
select p.idpacienti, p.emri , count(*) [cmimi dhomes]
from pacienti p inner join paguhet pg on p.idPacienti = pg. idPacienti inner join fatura f on pg.idfatura = f.idFatura
where f.cmimi_dhomes >=100
group by p.idPacienti, p.emri

--2 te shfaqen te gjith pacientet qe kan paguar faturat me shume se nje her te selektohen ne baz te emrit te pacientit
select p.emri, count(*)[nr_pagesave]
from pacienti p inner join paguhet pag on p.idPacienti = pag.idPacienti
group by p.emri
having count(*)>1


--3 te shfaqen pacientet femra te cilet marrin medikamentet qe kan dozen mes 100mg or 400mg 

select p.emri,p.gjinia, m.emriMedikamentit, dm.doza
from pacienti p inner join  Diagnoza_Medikamentet dm on p.idPacienti = dm.idPacienti inner join medikamentet m
 on m.idMedikamentet = dm.idMedikamentet
 where dm.doza between '100mg' and '400mg' and (p.gjinia = 'F')
 order by  dm.doza asc

-- 4. te shfaqen pacientet qe kan me shume se nje diagnoz  
select distinct p.idPacienti, p.emri, p.mbiemri, count(d.idpacienti) [nr.diagnozave]
from  pacienti p left  join diagnoza d on p.idPacienti= d.idPacienti
group by p.idPacienti, p.emri, p.mbiemri
having count(d.idpacienti)>1

--5. te selektohen pastruesit qe pastrojn sallat qe jan femra dhe kan pagen me mes 230 deri 500 euro
select s.emri, p.lloji, p.paga
from stafi s right join  pastruesi p on s.idStaf = p.idpastruesi
where p.lloji = 'pastron sallat' and s.gjinia = 'F' and p.paga between 230 and 500
order by s.emri

--6. te shfaqet dhoma qe ka me shume se dy pacienta pacientet dhe te renditen sipas numrit t pacientave 
select dh.idDhoma, count(dhd.dhoma) [nr.pacienteve]
from dhoma_diagnoza dhd inner join pacienti p on p.idPacienti= dhd.idpacienti inner join dhoma dh on dhd.dhoma=dh.idDhoma
group by dh.idDhoma
having count(dhd.dhoma)>= 2
order by [nr.pacienteve]

--7.Shtoni per 15% pagen e secilit doktor qe ka specializuar traumatologji --selektimi te behet ne baz te emrit te doktorit  select s.emri, d.paga, (Paga+Paga* 15/100) [paga e re] from Doktori d inner join stafi s on s.idStaf=d.dokId where d.specializon ='traumatologji' update doktori set Paga= Paga +(Paga *10/100)

 --8. te shfaqen emailat e pacienteve qe permbajn shkronjen e dhe pacientet qe permbajn shkronjen a
 select p.emri , p.mbiemri, e.emaili
 from email e full join pacienti p on p.idPacienti= e.idPacienti
 where e.emaili like '%e%'and p.emri like'%a%'
 order by p.emri




-- < Të krijoni min. 8 subquery të thjeshta (4 për student) >

-- 1.te selektohen te gjith pacientet qe kan ber pages mbi 50euro per cmimin e analizave 
-- selektimi te behet ne baz te id se fatures, emrit te pacientit, cmimit te analizave dhe mos te ket duplikim te dhanave
SELECT  distinct f.idFatura ,p.emri ,f.cmimi_analizave
   FROM fatura f , pacienti p, paguhet pg
   WHERE f.idFatura =pg.idfatura and p.idPacienti = pg.idPacienti
   and pg.idfatura in(SELECT f.idFatura 
						 FROM fatura f 
						 WHERE f.cmimi_analizave > 50);



--2 te shfaqen te gjitha diagnozat te cilat i ka caktuar doktoresha dafina
select s.emri, p.emri, p.mbiemri, d.semundja
from stafi s inner join diagnoza d on s.idStaf = d.doktori inner join pacienti p on p.idPacienti= d.idpacienti
where s.idStaf in(select d.doktori
					from diagnoza d 
					where d.doktori =003)


--3 te shfaqen te gjitha departamentet qe e kan perdorur sallen e operacionit tek departamenti i ortopedise
select  distinct d.emri_departamentit, s.emri_salles, ssd.idSalles
from  departamenti d,stafi_sallat_departamenti ssd, sallat s
where d.idDepartamenti = ssd.idDepartamenti and s.idSalles= ssd.idSalles 
and ssd.idSalles =(select s.idSalles
					from sallat s
					where s.idSalles= 500)

--4 te shfaqen medikamentet qe marin pacientet  brenda intervalit kohor 09:00 dhe 21:00
-- selektimi te behet ne baz te emrit te pacientit, emrit te medikametit dhe intervalit kohor 
select p.emri, m.emriMedikamentit, i.intervali_kohor
from pacienti p, intervali i, medikamentet m 
where p.idPacienti= i.idpacienti and m.idMedikamentet=i.idmedikamentet
and i.intervali_kohor in(select i.intervali_kohor
						from intervali i
						where i.intervali_kohor = '09:00 dhe 21:00')
						

--5 te shfaqen te gjith infermieret qe kujdesen per dhomen me id 108 dhe te shfaqet sa shtreter i ka ajo dhome 
select s.emri,i.dhoma, dh.nrShtreterve
from infermieri i, stafi s, dhoma dh 
where i.dhoma= dh.idDhoma and i.idInfermieri= s.idStaf 
and i.dhoma =(select dh.idDhoma
			   from dhoma dh 
			   where dh.idDhoma like 108)

--6 te shfaqen te gjith pasturesit qe kan rrogen me te madhe ose barazi 250
-- te insertohet emri i pastruesit, lloji i pastruesite edhe paga 
SELECT s.emri, p.lloji , p.paga
 from stafi s, pastruesi p
 where p.idpastruesi = s.idStaf and p.idpastruesi in (SELECT p.idpastruesi
         FROM pastruesi p
         WHERE p.paga  >= 250) 


--7 te shfaqet infermieri me emrin  besian se ne cilat departamente ben pjese

select s.idStaf, s.emri, d.emri_departamentit
from stafi s, stafi_sallat_departamenti ssd, Departamenti d 
where s.idStaf = ssd.idStaf and ssd.idDepartamenti = d.idDepartamenti
and ssd.idStaf =(select s.idStaf
				from stafi s
				where s.idStaf like 22 and s.dataLindjes = '04-08-1987')


--8  te shfaqet numri i pacienteve qe kan kryer operacion dhe qe kan bere analizat e pergjithshme

select d.idpacienti, p.emri,  d.operacion, d.analizat
from diagnoza d, pacienti p
where p.idPacienti= d.idpacienti 
and p.idPacienti in(select d.idpacienti
					from diagnoza d
					where d.operacion ='po' and d.analizat = 'te pergjithshme')


--9 te selektohen te gjith pacientet  qe vin nga qyteti pejes qe i ka kontrolluar doktori florim  
select s.emri, d.idpacienti, p.emri, p.qyteti
from diagnoza d inner join doktori doc on d.doktori = doc.dokId inner join stafi s
on doc.dokId= s.idStaf inner join pacienti p on d.idpacienti=p.idPacienti
where d.doktori = 1 and d.idpacienti in (select p.idPacienti
											from pacienti p 
											where p.qyteti = 'peje' )


--<Të krijoni min. 8 subquery të avancuara (4 për student). (min. 1 subquery në klauzolën SELECT, dhe min. 1 subquery ne klauzolën FROM) >

--1. te shfaqet se cilet pacient marin dozen me te vogel se doza maksimale e medikamenteve
select p.emri, dm.doza
from pacienti p inner join  diagnoza_medikamentet  dm on  dm.idpacienti= p.idPacienti
where dm.doza <any(select max(m.doza)
                   from medikamentet m )

--2 te shfaqen pastruesit qe kan pagen me te madhe se mesatarja e pagave te doktoreve 
select s.emri, p.paga 
from pastruesi p inner join stafi s on p.idpastruesi=s.idStaf
where p.paga >any(select avg(d.paga)from doktori d)


--3. te selektohen diagnozat qe pacientet e kan moshen me te madhe se sa mesatarja
-- e moshave e te gjith pacienteve
select d.iddiagnoza, p.emri, p.mbiemri
from diagnoza d left join pacienti p on d.idPacienti = p.idPacienti 
where  DATEDIFF(year, p.dateLindja,  GETDATE()) > 
(select AVG(DATEDIFF(year, p.dateLindja, GETDATE())) from pacienti p)

	
--4. te selektohen te gjith pacientet qe kan bere pages me te madhe se mesatarja e shumave te faturave 
select DISTINCT p.emri, pg.idfatura
from pacienti p left join paguhet pg on p.idPacienti = pg.idPacienti
 inner join fatura f on f.idFatura = pg.idfatura 
where f.cmimi_analizave + f.cmimi_dhomes + f.cmimi_medikamenteve > 
(select  avg(f.cmimi_analizave + f.cmimi_dhomes + f.cmimi_medikamenteve) as cmimi_total 
from fatura f )


--5.te shfaqen te dhanat e stafit qe ben pjese ne deparatamente te ndryshme 
create view stafiNeDepartamenteTeNdryshem 
as
(
select  s.idStaf, s.emri,s.gjinia, ssd.idDepartamenti, d.emri_departamentit
from stafi s inner join stafi_sallat_departamenti ssd on s.idStaf =ssd.idStaf inner join Departamenti d
on ssd.idDepartamenti=d.idDepartamenti
where s.idStaf in(select  ssd.idStaf
					from stafi_sallat_departamenti ssd inner join Departamenti d on 
					d.idDepartamenti =ssd.idDepartamenti
					where ssd.idDepartamenti in(select d.idDepartamenti
													from Departamenti d))

)
--6. te shfaqet rroga e te gjith doktoreve qe  kan specializuar ortopedi

select emri, specializon, paga
 from (select d.paga, s.emri, d.specializon
		from doktori d inner join stafi s on s.idStaf= d.dokId
		where d.specializon='ortopedi') as tblStafiInfermieri


--7.Gjeni infermiert qe kan pagen me te madhe se paga ma e vogel e infermiereve qe kujdesen per dhomen me id 108
alter view InfermieriMePagenMeTeVogel
as
(
select s.emri, f.paga, (select AVG(paga) from infermieri) as pagaMestareEshte
from infermieri f inner join stafi s on s.idStaf= f.idInfermieri
where f.paga >any(select min(f.paga)
					from infermieri f inner join stafi s on s.idStaf= f.idInfermieri
					where f.dhoma=108)
)


--8.te shfaqen te gjith doktoret qe kan diagnoztifikuar me shume pacienta se sa doktori me emrin adem  

select s.emri,count(d.doktori)
from diagnoza d inner join doktori doc on doc.dokId =d.doktori 
inner join stafi s on s.idStaf = doc.dokId
group by s.emri
having count(d.doktori) >=any(select count(*)
								from diagnoza d inner join doktori doc on doc.dokId =d.doktori 
								inner join stafi s on s.idStaf = doc.dokId
								where d.doktori =5)




--< Të krijoni min. 8 query/subquery (4 për student). Duke përdorur operacionet e algjebrës relacionale (Union, Prerja, diferenca, etj.)

--1 te selektohet vetem stafi qe punon akoma dhe jo ata qe jan larguar 

select s.idStaf, s.emri, s.gjinia, s.LLojiStafit, s.dataLargimit
from stafi s
where s.dataLargimit  is  null
except 
select s.idStaf, s.emri, s.gjinia, s.LLojiStafit,s.dataLargimit
from stafi s
where s.dataLargimit  is not  null

--2 te selektohen te gjith pacientet qe shtrihen ne spital qe vin nga peja dhe nga prishtina 
create view pacientetNgaPejaDhePrishtina
 as
 (
select p.idPacienti, p.emri, p.qyteti, d.shtrihet_dhom
from diagnoza d inner join pacienti p on d.idpacienti = p.idPacienti
 and d.shtrihet_dhom='po' and d.idpacienti in(select p.idPacienti
												from pacienti  p 
												where p.qyteti ='peje')
union
select p.idPacienti, p.emri, p.qyteti, d.shtrihet_dhom
from diagnoza d inner join pacienti p on d.idpacienti = p.idPacienti
 and d.shtrihet_dhom='po' and d.idpacienti in(select p.idPacienti
												from pacienti  p 
												where p.qyteti ='prishtine')
)
												
--3 te selektohen pacientet te cilet kan ber pagesen per analiza me shume ne mes 50 dhe 90 
--dhe jo pacientet qe kan ber pages me shume mes 30 dhe 40 
select p.idPacienti,pac.emri, f.cmimi_analizave
from fatura f inner join paguhet p on f.idFatura= p.idfatura 
inner join pacienti pac on pac.idPacienti = p.idPacienti
where p.idFatura in (select f.idFatura
					from fatura f 
					where f.cmimi_analizave between 50 and 90 )
except  

select p.idPacienti,pac.emri, f.cmimi_analizave 
from fatura f inner join paguhet p on f.idFatura= p.idfatura 
inner join pacienti pac on pac.idPacienti = p.idPacienti
where p.idFatura in (select f.idFatura
						from fatura f 
						where f.cmimi_analizave between 30 and 40)
 

-- 4 te selektohen pacientet dhe stafi te cilet vitin e lindjes e kan te njejt 
 select s.emri, YEAR(s.dataLindjes) as vitiLindjes
 from stafi s
 where s.dataLindjes between '01-11-1985' and '04-07-1990'
 intersect
 select s.emri, YEAR(s.dataLindjes) as vitiLindjes
 from stafi s
 where s.dataLindjes between '01-11-1985' and '04-07-1990'

 --5 te shfaqen te gjith emrat e pacienteve dhe te stafit qe jan te njejt 
 select  p.emri, p.gjinia
 from pacienti p 
 intersect 
 select s.emri, s.gjinia
 from stafi s
 
 --6 te selektohen pacientet qe marin medikamentet ne intervalin kohor 09:00 dhe 21:00 
 --dhe jo ata qe marin ne intervalin kohor 21:00

 select p.emri, p.mbiemri,  i.intervali_kohor, m.emriMedikamentit
 from intervali i inner join pacienti p on i.idpacienti=p.idPacienti 
 inner join medikamentet m on i.idmedikamentet = m.idMedikamentet
 where i.intervali_kohor ='09:00 dhe 21:00'
 except 
 select p.emri, p.mbiemri, i.intervali_kohor, m.emriMedikamentit
 from intervali i inner join pacienti p on i.idpacienti=p.idPacienti 
 inner join medikamentet m on i.idmedikamentet = m.idMedikamentet
 where i.intervali_kohor =' 21:00'

 --7 te shfaqen te gjitha dhomat qe kan dy infermier apo me shume por jo ata qe kan vetem 1 infermier
 create view dhomatMeShumeInfermier
 as
 (
 select f.dhoma, count(*) as nr_infermiereve
 from infermieri f inner join dhoma dh on f.dhoma= dh.idDhoma
 group by f.dhoma
  having count(*)>=2
except 
 select f.dhoma, count(*) as nr_infermiereve
 from infermieri f inner join dhoma dh on f.dhoma= dh.idDhoma
 group by f.dhoma
  having count(*)=1)

--8 te shfaqen stafi qe gjendet ne departamentin e emergjences dhe ata qe gjenden ne departamentin e psikologjis

select s.idStaf, s.emri, s.LLojiStafit, d.emri_departamentit
from stafi_sallat_departamenti ssd inner join Departamenti d  on ssd.idDepartamenti = d.idDepartamenti 
inner join stafi s on ssd.idStaf = s.idStaf
where ssd.idDepartamenti in (select  d.idDepartamenti
								from Departamenti d 
								where d.emri_departamentit = 'psikologjia')
union 

select s.idStaf, s.emri, s.LLojiStafit, d.emri_departamentit
from stafi_sallat_departamenti ssd inner join Departamenti d  on ssd.idDepartamenti = d.idDepartamenti 
inner join stafi s on ssd.idStaf = s.idStaf
where ssd.idDepartamenti in (select  d.idDepartamenti
								from Departamenti d 
								where d.emri_departamentit = 'emergjenca')


--< Të krijoni min. 8 Proceduara të ruajtura (Stored Procedure) (4 për student) >
-- Minimum 2 procedura me parametra input dhe output
-- Min. 2 procedura me kombinime të shprehjeve (IF…ELSE, WHILE, CASE )
--1 te krijohet nje procedur e ruajtur ku selektohen pacientet 
--qe marin medikamentet ne intervalin kohor 09:00 dhe 21:00 

create proc intervaliKohorImedikamenteve
as
begin
 select p.emri, p.mbiemri,  i.intervali_kohor, m.emriMedikamentit
 from intervali i inner join pacienti p on i.idpacienti=p.idPacienti 
 inner join medikamentet m on i.idmedikamentet = m.idMedikamentet
 where i.intervali_kohor ='09:00 dhe 21:00'
 end 
 intervaliKohorImedikamenteve 

--2  te shfaqen te gjitha dhomat  nese nje dhome ka 1 infermier te sfaqet dhoma ka vetem nje infermier
-- nese dhoma ka me shume se 1 infermier te sshfaqet dhoma ka shume infermier, ndera nese nuk ka asnje infermier te shfaqet nuk ka asnje infermier
 create procedure  numriInfermierve_NeDHoma
 @idDhoma int
 as
 begin
  
  declare @numriinfermiereve int;

 select @numriinfermiereve = ( select count(*) as nr_infermiereve
 from infermieri f inner join dhoma dh on f.dhoma= dh.idDhoma
 where f.dhoma =@idDhoma 
 group by f.dhoma)


 if @numriinfermiereve =1
 begin 
 print 'dhoma me id ' + convert (varchar,@idDhoma) +' ka vetem nje infermier'
 end 

 else
   if @numriinfermiereve >1
   begin
   print 'dhoma me id  '  + convert (varchar,@idDhoma) + ' ka me shume se nje infermier'
   end 

   else 
   begin
     print 'dhoma me id  ' + convert (varchar,@idDhoma)+ ' nuk ka asnje infermier'
	 end
		
end

 numriInfermierve_NeDHoma @idDhoma=107




 --3 te krijohet nje procedure e ruajtur e cila selekton diagnozat qe pacientet e kan
 --moshen me te madhe se sa mesatarja e moshave e te gjith pacienteve
 create proc MoshaEPacienteve
 @emripacientit varchar (255)
 as 
 begin
 declare @moshaMaEMadhe int  ;
 declare @mesatarja int ;

select @moshaMaEMadhe = (select d.iddiagnoza
from diagnoza d left join pacienti p on d.idPacienti = p.idPacienti 
where p.emri=@emripacientit and  DATEDIFF(year, p.dateLindja,  GETDATE()) >
(select AVG(DATEDIFF(year, p.dateLindja, GETDATE())) from pacienti p))

 if  @moshaMaEMadhe is not null  nb
 begin
print 'pacienti ka moshen  ma te madhe se mesatarja e moshave te pacienteve'
end 

else
if @moshaMaEMadhe is null 
 begin
print 'pacienti ka moshen  ma te vogel se mesatarja e moshave te pacienteve'
end 

end

MoshaEPacienteve @emripacientit = 'ardian'


--4. te krijohet nje procedur e ruajtur ku tregon se a ka specializuar nje doktor ortopedi ose jo 

create proc specializimiidoketorve
@id int out
as
begin
declare @ortoped int;
 select @ortoped=(select d.dokId
		from doktori d inner join stafi s on s.idStaf= d.dokId
		where  d.dokId = @id and  d.specializon='ortopedi')

if @ortoped is not null 
begin
print 'doktori me id ' +convert(varchar, @id)+ ' ka specializuar ortopedi '
end

else if @ortoped is null
begin 
print 'doktori me id '+convert(varchar, @id)+ ' nuk ka specializuar ortpedi'
end

end 

specializimiidoketorve @id=1


--5 te krijohet nje procedur e cila e shton nje pacient qe ka te njejten diagnoz qe caktohet nga inputi
create  proc shtonPacient
	@idPacientitQeKaTeNjejtnDiagnoze int,

    @Emri varchar(50),
	@Mbiemri varchar(50),
	@Data_Lindjes date,
	@qyteti varchar(50), 
	@rruga char(11),
	@gjinia char

as
  begin 

   insert into pacienti values ( @Emri,@Mbiemri, @Data_Lindjes, @qyteti,@rruga, @gjinia)
   declare @lastIDPacienti int;
   SELECT  @lastIDPacienti =  SCOPE_IDENTITY()


  declare @semundja varchar;
  select @semundja= (select TOP 1 d.semundja from diagnoza d where d.idPacienti = @idPacientitQeKaTeNjejtnDiagnoze )

   declare @shtrihet_dhom char(2);
  select @shtrihet_dhom= (select TOP 1 d.shtrihet_dhom from diagnoza d where d.idPacienti = @idPacientitQeKaTeNjejtnDiagnoze)

   declare @operacion char(2);
  select @operacion= (select TOP 1 d.operacion from diagnoza d where d.idPacienti = @idPacientitQeKaTeNjejtnDiagnoze)


  declare @analizat varchar;
  select @analizat =(select TOP 1 d.analizat from diagnoza d where d.idPacienti = @idPacientitQeKaTeNjejtnDiagnoze)

   declare @doktori int;
  select @doktori =(select TOP 1 d.doktori from diagnoza d where d.idPacienti = @idPacientitQeKaTeNjejtnDiagnoze)

   declare @rentgen char(2);
  select @rentgen=(select TOP 1 d.rentgen from diagnoza d where d.idPacienti = @idPacientitQeKaTeNjejtnDiagnoze)


  INSERT INTO diagnoza (idPacienti, idDiagnoza, semundja, Shtrihet_dhom, operacion, analizat, doktori, rentgen ) 
  VALUES (@lastIDPacienti, @@IDENTITY ,@semundja, @shtrihet_dhom, @operacion, @analizat,@doktori, @rentgen )

  end 

shtonPacient 1, 'diellza','muharremi', '1999-02-28', 'prishtine','mark gashi', 'f'


--6 te shfaqen te gjith pacientet qe i ka diagnoztifikuar doktori me id qe caktohet nga input-i
create proc pacientatqeIcaktonnjedoktor
@iddoc int 
as 
begin
select s.emri, p.emri, p.mbiemri, d.semundja
from stafi s inner join diagnoza d on s.idStaf = d.doktori inner join pacienti p on p.idPacienti= d.idpacienti
where s.idStaf in(select d.doktori
					from diagnoza d 
					where d.doktori =@iddoc)

end 

pacientatqeIcaktonnjedoktor @iddoc = 3


--7 te shfaqen te gjith pacientet qe kan paguar faturat me shume se nje her te selektohen ne baz te emrit te pacientit


create proc faturatEPacienteve
@idPacienti int
as
begin
declare @nrPagesavePacienteve varchar(255);

select @nrPagesavePacienteve=(select  count(*)
from pacienti p inner join paguhet pag on p.idPacienti = pag.idPacienti
where p.idPacienti=@idPacienti)

if @nrPagesavePacienteve >1
begin
print 'pacienti ka bere  me shume se 1 her pages'
end

else 
if @nrPagesavePacienteve =1
begin 
print 'pacienti ka bere vetem nje pages'
end

end
faturatEPacienteve @idPacienti= 8


--8 te shfaqen pacientet femra te cilet marrin  dozen  e cila caktohet ne input 

create proc dozaMedikamenteve
@doza varchar(50)
as 
begin 

select p.emri,p.gjinia, m.emriMedikamentit, dm.doza
from pacienti p inner join  Diagnoza_Medikamentet dm on p.idPacienti = dm.idPacienti inner join medikamentet m
 on m.idMedikamentet = dm.idMedikamentet
 where dm.doza = @doza and (p.gjinia = 'F')
end 
dozaMedikamenteve @doza = '100mg'