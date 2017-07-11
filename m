From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Tue, 11 Jul 2017 23:05:54 +0100
Subject: [Cocci] Matching format strings
In-Reply-To: <WM!722e339a1005fef2c134dd9ac0ae6a397244b31d97d213bd70f018388df0843856b835981db31cfffbbceb8ea4d36bdf!@mailstronghold-2.zmailcloud.com>
References: <WM!18ce1dcc914ca4f9b61f6c3aaf891296df9651e3b4d79666e0682dd2ff392a761c732ee0cf4f6500e93b392f83991daf!@mailstronghold-1.zmailcloud.com>
 <20170710162835.xnkjn7btb3cwplsy@eos.mistotebe.net>
 <alpine.DEB.2.20.1707101925350.1978@hadrien>
 <WM!5b84796296144341d624902eddc2fab8cb72294094f53296fafa12642d6a73a74f5216fe1a48aa1018fdaf2162eca726!@mailstronghold-2.zmailcloud.com>
 <20170711130640.heuc3m4mca7vxy52@eos.mistotebe.net>
 <alpine.DEB.2.20.1707111508220.2316@hadrien>
 <WM!c47e11010083686c9aadfde329eb4f31090053d095a60ac9df8bbc8224796e493af84b1948709a4b0a11aa0da4f34967!@mailstronghold-2.zmailcloud.com>
 <20170711142544.dodc2awelxffs6oi@eos.mistotebe.net>
 <alpine.DEB.2.20.1707112123000.2316@hadrien>
 <WM!722e339a1005fef2c134dd9ac0ae6a397244b31d97d213bd70f018388df0843856b835981db31cfffbbceb8ea4d36bdf!@mailstronghold-2.zmailcloud.com>
Message-ID: <20170711220554.otb33muo5v7o2gcz@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jul 11, 2017 at 09:24:24PM +0200, Julia Lawall wrote:
> On Tue, 11 Jul 2017, Ond?ej Kuzn?k wrote:
>> On Tue, Jul 11, 2017 at 03:10:36PM +0200, Julia Lawall wrote:
>>> Could you send the complete semantic patch that you are currently
>>> considering?  Then I can take a look.
>>
>> Attaching the patches I'm currently working with:
>> (-macro-file-builtins macros.h)
>> 1. variadic.cocci
>> 2. shortcut.cocci
>> 3. merge.cocci
>>
>> The back-sql issue above is when trying to apply 2. (shortcut.cocci).
>> But the one I pasted in my last email is simple enough to illustrate the
>> issue (trying to merge snprintf and Debug, then get rid of extra if()s)
>> even without the python stuff.
> 
> Sorry, but I'm lost.  I tried shortcut.cocci on
> ./servers/slapd/back-sql/add.c, and afterwards
> ./servers/slapd/back-sql/add.c has no snprintfs.  My command line is:
> 
> spatch -macro-file-builtins macros.h --in-place ./servers/slapd/back-sql/add.c shortcut.cocci

Yes, it removes the sprintfs, but I would have expected it to produce
this patch (note the if()s have been removed) as it manages in other
files:

--- servers/slapd/back-sql/add.c
+++ /tmp/cocci-output-22443-aee224-add.c
@@ -858,12 +858,10 @@ backsql_add_attr(
 
 #ifdef LDAP_DEBUG
-               if ( LogTest( LDAP_DEBUG_TRACE ) ) {
-                       snprintf( logbuf, sizeof( logbuf ), "val[%lu], id=" BACKSQL_IDNUMFMT,
-                                       i, new_keyval );
-                       Debug( LDAP_DEBUG_TRACE, "   backsql_add_attr(\"%s\"): "
-                               "executing \"%s\" %s\n", 
-                               op->ora_e->e_name.bv_val,
-                               at_rec->bam_add_proc, logbuf );
-               }
+               Debug(LDAP_DEBUG_TRACE,
+                     "   backsql_add_attr(\"%s\"): " "executing \"%s\" val[%lu], id=" BACKSQL_IDNUMFMT\n",
+                     op->ora_e->e_name.bv_val, at_rec->bam_add_proc,
+                     i, new_keyval);
 #endif
                rc = SQLExecute( sth );
@@ -1387,14 +1385,11 @@ backsql_add( Operation *op, SlapReply *r
        }
 
-       if ( LogTest( LDAP_DEBUG_TRACE ) ) {
-               char buf[ SLAP_TEXT_BUFLEN ];
-
-               snprintf( buf, sizeof(buf),
-                       "executing \"%s\" for dn=\"%s\"  oc_map_id=" BACKSQL_IDNUMFMT " p_id=" BACKSQL_IDFMT " keyval=" BACKSQL_IDNUMFMT,
-                       bi->sql_insentry_stmt, op->ora_e->e_name.bv_val,
-                       oc->bom_id, BACKSQL_IDARG(bsi.bsi_base_id.eid_id),
-                       new_keyval );
-               Debug( LDAP_DEBUG_TRACE, "   backsql_add(): %s\n", buf);
-       }
+       Debug(LDAP_DEBUG_TRACE,
+             "   backsql_add(): executing \"%s\" for dn=\"%s\"  oc_map_id=" BACKSQL_IDNUMFMT " p_id=" BACKSQL_IDFMT " keyval=" BACKSQL_IDNUMFMT\n",
+             bi->sql_insentry_stmt, op->ora_e->e_name.bv_val,
+             oc->bom_id, BACKSQL_IDARG(bsi.bsi_base_id.eid_id),
+             new_keyval);
 
        rc = SQLExecute( sth );



-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
