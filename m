From: Thierry.Martinez@inria.fr (Thierry Martinez)
Date: Wed, 12 Oct 2016 17:12:55 +0200
Subject: [Cocci] Error: This expression has type t but an expression was
	expected of type, string option option
In-Reply-To: <alpine.DEB.2.10.1610121448500.2927@hadrien>
References: <4a34076e-3fd3-33ea-0ff8-b18e0bc39439@c-s.fr>
 <alpine.DEB.2.10.1610121448500.2927@hadrien>
Message-ID: <ow4insxy51k.fsf@inria.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Julia:
> Apparently 3.12 is still supported.  The error will be fixed shortly.

It should be fixed now. Thanks for the report.
-- 
Thierry.

Julia Lawall (2016/10/12, 14:49 CEST)?:
> On Wed, 12 Oct 2016, Christophe LEROY wrote:
>
>> Hi
>>
>> I'm trying to compile coccinelle on a CentOS 6 system, and I'm facing
>> the following compilation error.
>>
>> I have the following version of ocaml: ocaml-3.12.0-21.el6.i686
>
> Apparently 3.12 is still supported.  The error will be fixed shortly.
>
> Thanks for the report.
>
> julia
>
>>
>> What can be done to solve this issue ?
>>
>> /usr/bin/ocamlc.opt -unsafe -I pyml-current -custom -cclib -lpyml_stubs
>> -c pyml-current/py.ml -o pyml-current/py.cmo
>> File "pyml-current/py.ml", line 500, characters 11-15:
>> Error: This expression has type t but an expression was expected of type
>>           string option option
>> make[6]: *** [pyml-current/py.cmo] Erreur 2
>> make[6]: quittant le r?pertoire ? /root/coccinelle-1.0.6/bundles/pyml ?
>> make[5]: *** [all.opt] Erreur 2
>> make[5]: quittant le r?pertoire ? /root/coccinelle-1.0.6/bundles/pyml ?
>> make[4]: *** [/root/coccinelle-1.0.6/bundles/pyml/.opt] Erreur 2
>> make[4]: quittant le r?pertoire ? /root/coccinelle-1.0.6 ?
>> make[3]: *** [subdirs.opt] Erreur 1
>> make[3]: quittant le r?pertoire ? /root/coccinelle-1.0.6 ?
>> make[2]: *** [opt-compil] Erreur 2
>> make[2]: quittant le r?pertoire ? /root/coccinelle-1.0.6 ?
>> make[1]: *** [all-release] Erreur 2
>> make[1]: quittant le r?pertoire ? /root/coccinelle-1.0.6 ?
>> make: *** [all] Erreur 2
>>
>> Christophe
>> _______________________________________________
>> Cocci mailing list
>> Cocci at systeme.lip6.fr
>> https://systeme.lip6.fr/mailman/listinfo/cocci
>>_______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
