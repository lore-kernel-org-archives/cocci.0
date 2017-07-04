From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Tue, 4 Jul 2017 17:56:56 +0100
Subject: [Cocci] Matching format strings
In-Reply-To: <WM!eb7db9be9e260b8b332afe997cbb4412d355372680c68c06376375f785c138afeda43804b4aaff43c0242a17ff2d826f!@mailstronghold-3.zmailcloud.com>
References: <WM!65159de96edf810da1e56d42962da09a256f7f76b7d8eab05109b214b5dc8c18f88b6a34ac273725a5e7afd1a6bed1d7!@mailstronghold-2.zmailcloud.com>
 <20170704151108.2mvifcg7cyhztbh5@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041721300.11588@hadrien>
 <WM!e764e7a6685d1e3af9c59f905772f1c4a8db9db4c655054ccb07f1b8485096c0979716269a6920eeac860b62d25a700e!@mailstronghold-2.zmailcloud.com>
 <20170704160123.lilble53tmv5t5va@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041806150.11588@hadrien>
 <WM!cc508729d042cf12207adee814670b88c105ae73cdaf601fdeb9c3e26fa32e7df0d4d49f847a216810550421de0d8de6!@mailstronghold-3.zmailcloud.com>
 <20170704162732.urhtl54j3gbj3myh@eos.mistotebe.net>
 <alpine.DEB.2.20.1707041837300.11588@hadrien>
 <WM!eb7db9be9e260b8b332afe997cbb4412d355372680c68c06376375f785c138afeda43804b4aaff43c0242a17ff2d826f!@mailstronghold-3.zmailcloud.com>
Message-ID: <20170704165655.yu7wwg7aomihs4of@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jul 04, 2017 at 06:40:56PM +0200, Julia Lawall wrote:
> On Tue, 4 Jul 2017, Ond?ej Kuzn?k wrote:
>> My test file at the moment is https://github.com/openldap/openldap/blob/master/servers/slapd/back-asyncmeta/meta_result.c
>> which calls snprintf in two places only and both code blocks are very
>> short. Still, the spatch takes slightly over 1000 seconds to process the
>> file with the below:
>>
>> @shortcut@
>> identifier buf;
>> expression S, E, L;
>> expression list args_before, args, args_after;
>> expression format1, format2;
>> @@
>>
>> {
>> -char buf[S];
>> -snprintf( buf, E, format1, args );
>> -Debug( L, format2, args_before, buf, args_after );
>> +Debug( L, "merged", args_before, args, args_after );
>> ... when != buf
>> }
>>
>> I feel I'm missing something in how coccinelle works to be able to
>> make its job easier here.
> 
> It is searching though the control flow paths.  In this case, one of the
> blocks is:
> 
>                         {
> 		                char    buf[ SLAP_TEXT_BUFLEN ];
> 
>                                 snprintf( buf, sizeof( buf ),
> 	                                "%s meta_send_entry(\"%s\"): "
> 	                                "slap_bv2undef_ad(%s): %s\n",
> 					op->o_log_prefix, ent.e_name.bv_val,
> 	                                mapped.bv_val, text );
> 
>                                 Debug( LDAP_DEBUG_ANY, "%s", buf, 0, 0 );
>                                 ( void )ber_scanf( &ber, "x" /* [W] */ );
>                                 op->o_tmpfree( attr, op->o_tmpmemctx );
>                                 continue;
>                         }
> 
> I think that it is drifting off into infinity due to the continue.

Possibly, but "buf" is only declared in the local scope and by providing
the scope parenthesis without the ellipsis after it, I was hoping
coccinelle would be able to infer the scope and maybe even deduce that
the continue always means the scope is left and that path can be
ignored? But that's probably not that easy.

> How about adding a timeout (eg --timeout 120) and then see how much is
> left over.

I get:
timeout (we abort)
Fatal error: exception Common.Timeout

and no patch is produced, if I wait the 1028 seconds, I get the expected
patch. I think that supports your hypothesis about trying to process the
continue.

Thanks,

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
