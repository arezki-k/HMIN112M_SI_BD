                                /*contraintes*/
alter table PRODUIT add constraint cout_produit
            CHECK(cout>0);
alter table PRODUIT add constraint PRODUIT_fk1 foreign key (nomf) references fournisseur (nomf);

alter table COMMANDE add constraint qte_commende
            CHECK (qte>0);
alter table COMMANDE add constraint COMMANDE_fk2 foreign key (nomc) references CLIENT(nomc);