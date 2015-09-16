set serveroutput on size 1000000;
set serveroutput on;

declare
 type curtype is ref cursor;
 subtype sqltype is varchar(1000);

 objcur     		curtype;
 sqlCommand 		sqlType;
 max_id integer;
 stmt varchar(700);
 stmt_index varchar(100);
 seq_name varchar(100);
 error_msg varchar(32000);

procedure drop_seq(var in varchar) is 
begin 
    sqlCommand := 'SELECT u.sequence_name FROM USER_SEQUENCES u where u.sequence_name like ''SEQ_MB\_%'' escape ''\''';
    
	open objcur for sqlCommand;
    loop    
        fetch objcur
            into seq_name;
        exit when objcur%notfound;		
		begin        
			stmt_index := 'drop sequence ' || seq_name;
	  	    dbms_output.put_line(stmt_index);
			execute immediate stmt_index;
		exception 
		  	when others then null;
	    end;				  
    end loop;
    close objcur;
end;

  
procedure create_seq(tab_name in varchar) is 
  begin 
   stmt := 'select max(id) from ' || tab_name;   
   EXECUTE IMMEDIATE stmt into max_id;
   if max_id is not null  then
	max_id := max_id +1;
   else
    max_id :=1;
   end if;
   stmt := 'CREATE SEQUENCE SEQ_' || tab_name || ' START WITH ' || max_id || ' MINVALUE '|| max_id || ' MAXVALUE 999999999999 NOCYCLE NOORDER nocache';
   dbms_output.put_line(stmt);
   EXECUTE IMMEDIATE stmt;
   exception
    when others  
    then 
	    error_msg := error_msg || tab_name;
  end;

begin 
	drop_seq('');

	create_seq('MB_ANLAGETYP');
	create_seq('MB_ANLAGETYPPATTERN');
	create_seq('MB_ATTRIBUT');
	create_seq('MB_AUFTRAGSART_OBJEKTTYP');
	create_seq('MB_AUFTRAGSARTPATTERN');
	create_seq('MB_AUFTRAGSARTZUSATZ');
	create_seq('MB_AUFTRAGSKOPFPATTERN');
	create_seq('MB_AUSDRUCK');
	create_seq('MB_BASISEINHEIT');
	create_seq('MB_BENUTZER');
	create_seq('MB_BEREICH');
	create_seq('MB_BEREICH_KONFIG');
	create_seq('MB_BEREICH_RECHT');
	create_seq('MB_BEWERTUNG');
	create_seq('MB_BEWERTUNGSGRUPPE');
	create_seq('MB_BEWERTUNGSGRUPPE_BEWERTUNG');
	create_seq('MB_BOOL');
	create_seq('MB_CLIENT_PROPERTY');
	create_seq('MB_CLIENT_PROPERTY_MODUL');
	create_seq('MB_CLIENT_PROPERTY_VALUES');
	create_seq('MB_CRITERIA');
	create_seq('MB_CRITERIA_RANGE');
	create_seq('MB_DATATYPE');
	create_seq('MB_EINHEIT');
	create_seq('MB_ENTITAETSTYP');
	create_seq('MB_FEEDBACK');
	create_seq('MB_FUNCTION');
	create_seq('MB_GANGFOLGE');
	create_seq('MB_GANGFOLGE_PBEDINGUNG');
	create_seq('MB_GRUPPE');
	create_seq('MB_GRUPPE_MODUL');
	create_seq('MB_GRUPPE_RECHT');
	create_seq('MB_GRUPPE_SUBSCRIPTION');
	create_seq('MB_GRUPPEPROZESS');
	create_seq('MB_HIS_AUFTRAG');
	create_seq('MB_HIS_MATERIALRUECK');
	create_seq('MB_HIS_OBJEKT');
	create_seq('MB_HIS_SERVICE');
	create_seq('MB_HIS_SUBSCRIPTION');
	create_seq('MB_HIS_TRANSAKTION');
	create_seq('MB_HIS_ZEITRUECK');
	create_seq('MB_HISAKTION');
	create_seq('MB_IDENT');
	create_seq('MB_IDENT_TYPE');
	create_seq('MB_INTERVALL');
	create_seq('MB_INVENTUR');
	create_seq('MB_INVENTURBESTAND');
	create_seq('MB_KONFIG');
	create_seq('MB_LOG');
	create_seq('MB_LOHNART_AUSDRUCK');
	create_seq('MB_LOHNARTPATTERN');
	create_seq('MB_LOHNSTUNDEN');
	create_seq('MB_LOKATION');
	create_seq('MB_MANAGER');
	create_seq('MB_MATERIALPATTERN');
	create_seq('MB_MESSBELEG');
	create_seq('MB_MESSBELEG_09');
	create_seq('MB_MESSPUNKT');
	create_seq('MB_MESSPUNKT_GANGFOLGE');
	create_seq('MB_MESSPUNKTTYP');
	create_seq('MB_MESSPUNKTTYP_SICH');
	create_seq('MB_MESSPUNKTTYPKLAS');
	create_seq('MB_MITARBEITER');
	create_seq('MB_MODUL');
	create_seq('MB_OBJEKT');
	create_seq('MB_OBJEKT_PRUEFPLANTYP');
	create_seq('MB_OBJEKTPATTERN');
	create_seq('MB_OBJEKTTYP');
	create_seq('MB_OBJEKTTYP_PRUEFPLANTYP');
	create_seq('MB_OBJEKTTYPPATTERN');
	create_seq('MB_OBJEKTTYPZUSATZ');
	create_seq('MB_PARAMETERTYP');
	create_seq('MB_PBEDINGUNG');
	create_seq('MB_PBEDINGUNG_BEWERTUNG');
	create_seq('MB_PBEDINGUNG_OBJEKT');
	create_seq('MB_PBEDINGUNG_OBJEKTTYP');
	create_seq('MB_PBEDINGUNG_PROCESSING');
	create_seq('MB_PBEDINGUNGKLAS');
	create_seq('MB_PRIORITY');
	create_seq('MB_PROFIL');
	create_seq('MB_PROFIL_PROZESSTYP');
	create_seq('MB_PROPERTY_TAG');
	create_seq('MB_PROZESSTYP');
	create_seq('MB_PRUEFAKTION');
	create_seq('MB_PRUEFAUFTRAG');
	create_seq('MB_PRUEFERGEBNIS');
	create_seq('MB_PRUEFERGEBNIS_MESSBELEG');
	create_seq('MB_PRUEFMITTEL');
	create_seq('MB_PRUEFMITTEL_TYP');
	create_seq('MB_PRUEFOBJEKT_PRUEFPLANTYP');
	create_seq('MB_PRUEFPLANTYP');
	create_seq('MB_PRUEFPLANTYP_PBEDINGUNG');
	create_seq('MB_PRUEFPLANTYPGRUPPE');
	create_seq('MB_PRUEFUNG');
	create_seq('MB_RANGE');
	create_seq('MB_RECHT');
	create_seq('MB_RELEASE');
	create_seq('MB_RESULT');
	create_seq('MB_SCHADENSDEFINITION');
	create_seq('MB_SCHADENSDEFINITIONPATTERN');
	create_seq('MB_SCHADENSURSACHE');
	create_seq('MB_SCHADENSURSACHEPATTERN');
	create_seq('MB_SELECTION');
	create_seq('MB_SELECTIONFILTEROPERATION');
	create_seq('MB_SELECTIONOPERATION');
	create_seq('MB_SERVICE');
	create_seq('MB_SERVICE_ALIAS');
	create_seq('MB_SINGLECYLEPLAN');
	create_seq('MB_SPALTE');
	create_seq('MB_STATE');
	create_seq('MB_SUBSCRIPTION');
	create_seq('MB_SUBSCRIPTION_MANAGER');
	create_seq('MB_SYSTEM');
	create_seq('MB_TRANSAKTIONAUSDRUCK');
	create_seq('MB_TRANSAKTIONREGISTRY');
	create_seq('MB_TYP');
	create_seq('MB_TYP_BEWERTUNG');
	create_seq('MB_VERBRAUCH');
	create_seq('MB_WI_OBJ');
	create_seq('MB_WI_PPT');
	create_seq('MB_ZUSATZINFO');
	create_seq('MB_ZUSATZINFOENTITY');
	
	dbms_output.put_line('Tabelle existiert nicht: ' || error_msg);
end;
/
quit;