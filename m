From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Tue, 11 Jul 2017 23:17:02 +0100
Subject: [Cocci] Matching format strings
In-Reply-To: <20170711220554.otb33muo5v7o2gcz@eos.mistotebe.net>
References: <20170710162835.xnkjn7btb3cwplsy@eos.mistotebe.net>
 <alpine.DEB.2.20.1707101925350.1978@hadrien>
 <WM!5b84796296144341d624902eddc2fab8cb72294094f53296fafa12642d6a73a74f5216fe1a48aa1018fdaf2162eca726!@mailstronghold-2.zmailcloud.com>
 <20170711130640.heuc3m4mca7vxy52@eos.mistotebe.net>
 <alpine.DEB.2.20.1707111508220.2316@hadrien>
 <WM!c47e11010083686c9aadfde329eb4f31090053d095a60ac9df8bbc8224796e493af84b1948709a4b0a11aa0da4f34967!@mailstronghold-2.zmailcloud.com>
 <20170711142544.dodc2awelxffs6oi@eos.mistotebe.net>
 <alpine.DEB.2.20.1707112123000.2316@hadrien>
 <WM!722e339a1005fef2c134dd9ac0ae6a397244b31d97d213bd70f018388df0843856b835981db31cfffbbceb8ea4d36bdf!@mailstronghold-2.zmailcloud.com>
 <20170711220554.otb33muo5v7o2gcz@eos.mistotebe.net>
Message-ID: <20170711221701.2zgryrwx4wyhxhnk@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jul 11, 2017 at 11:05:54PM +0100, Ond?ej Kuzn?k wrote:
> Yes, it removes the sprintfs, but I would have expected it to produce
> this patch (note the if()s have been removed) as it manages in other
> files:
> 
> --- servers/slapd/back-sql/add.c
> +++ /tmp/cocci-output-22443-aee224-add.c
> @@ -858,12 +858,10 @@ backsql_add_attr(
>  
>  #ifdef LDAP_DEBUG
> -               if ( LogTest( LDAP_DEBUG_TRACE ) ) {
> -                       snprintf( logbuf, sizeof( logbuf ), "val[%lu], id=" BACKSQL_IDNUMFMT,
> -                                       i, new_keyval );
> -                       Debug( LDAP_DEBUG_TRACE, "   backsql_add_attr(\"%s\"): "
> -                               "executing \"%s\" %s\n", 
> -                               op->ora_e->e_name.bv_val,
> -                               at_rec->bam_add_proc, logbuf );
> -               }
> +               Debug(LDAP_DEBUG_TRACE,
> +                     "   backsql_add_attr(\"%s\"): " "executing \"%s\" val[%lu], id=" BACKSQL_IDNUMFMT\n",

Oh, somehow the end of the format string gets mangled, presumably in the
Python code, which doesn't expect this at all, so I guess this would be
the reason the last part of the patch never applies. Sorry.

> +                     op->ora_e->e_name.bv_val, at_rec->bam_add_proc,
> +                     i, new_keyval);
>  #endif
>                 rc = SQLExecute( sth );
> @@ -1387,14 +1385,11 @@ backsql_add( Operation *op, SlapReply *r
>         }
>  
> -       if ( LogTest( LDAP_DEBUG_TRACE ) ) {
> -               char buf[ SLAP_TEXT_BUFLEN ];
> -
> -               snprintf( buf, sizeof(buf),
> -                       "executing \"%s\" for dn=\"%s\"  oc_map_id=" BACKSQL_IDNUMFMT " p_id=" BACKSQL_IDFMT " keyval=" BACKSQL_IDNUMFMT,
> -                       bi->sql_insentry_stmt, op->ora_e->e_name.bv_val,
> -                       oc->bom_id, BACKSQL_IDARG(bsi.bsi_base_id.eid_id),
> -                       new_keyval );
> -               Debug( LDAP_DEBUG_TRACE, "   backsql_add(): %s\n", buf);
> -       }
> +       Debug(LDAP_DEBUG_TRACE,
> +             "   backsql_add(): executing \"%s\" for dn=\"%s\"  oc_map_id=" BACKSQL_IDNUMFMT " p_id=" BACKSQL_IDFMT " keyval=" BACKSQL_IDNUMFMT\n",
> +             bi->sql_insentry_stmt, op->ora_e->e_name.bv_val,
> +             oc->bom_id, BACKSQL_IDARG(bsi.bsi_base_id.eid_id),
> +             new_keyval);
>  
>         rc = SQLExecute( sth );
> 

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
