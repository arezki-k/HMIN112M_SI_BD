prompt insertion dans les tables
insert into troupe values('Le Splendid','Paris');
insert into troupe values('Theatre 14','Paris');
insert into troupe values('Les Sales Gosses','Paris');
insert into troupe values('Royal De Luxe','Nantes');

insert into artiste values('Dessay','Natalie','19/04/1965','f','Theatre 14');
insert into artiste values('Ferreol','Andrea','06/01/1947','f','Theatre 14');
insert into artiste values('Bouajila','Sami','12/05/1966','h','Theatre 14');
insert into artiste values('Starr','Joey','27/10/1967','h','Royal De Luxe');
insert into artiste values('Benezech','Alix','25/09/1991','f','Le Splendid');
insert into artiste values('Kouyat','Mabo','01/09/1989','h','Royal De Luxe');
insert into artiste values('Felix','Zoe','07/05/1976','f','Royal De Luxe');
insert into artiste values('Belmondo','Paul','23/04/1963','h','Royal De Luxe');
insert into artiste values('Vardar','Alil','07/02/1970','h','Royal De Luxe');
insert into artiste values('Essaidi','Sofia','06/08/1984','f','Theatre 14');

insert into spectacle values ('A1','Chicago','Mogador','Paris','12/07/2016','Theatre 14');
insert into spectacle values ('A2','Chicago','Mogador','Paris','06/08/2016','Theatre 14');
insert into spectacle values ('A3','Absolutely Hilarious','Les Mathurins','Paris','23/09/2019','Royal De Luxe');


insert into seProduitDans values('Essaidi','Sofia','A1','Roxie Hart');
insert into seProduitDans values('Dessay','Natalie','A1','Velma Kelly');
insert into seProduitDans values('Bouajila','Sami','A1','Billy Flynn');
insert into seProduitDans values('Essaidi','Sofia','A2','Roxie Hart');
insert into seProduitDans values('Dessay','Natalie','A2','Velma Kelly');
insert into seProduitDans values('Bouajila','Sami','A2','Billy Flynn');
insert into seProduitDans values('Kouyat','Mabo','A3','Pierre');
insert into seProduitDans values('Belmondo','Paul','A3','Antoine');
insert into seProduitDans values('Felix','Zoe','A3','Zoe');

commit;
