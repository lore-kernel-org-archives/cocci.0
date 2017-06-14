From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 14 Jun 2017 22:56:21 +0200 (CEST)
Subject: [Cocci] Replacing suffix rules in make scripts?
In-Reply-To: <9c2abe52-5ef9-62e0-26ab-f4fc69513257@users.sourceforge.net>
References: <020f8c95-fcaa-d47e-410b-7fb633fefa09@users.sourceforge.net>
 <9c2abe52-5ef9-62e0-26ab-f4fc69513257@users.sourceforge.net>
Message-ID: <alpine.DEB.2.20.1706142255480.3610@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 14 Jun 2017, SF Markus Elfring wrote:

> > So I get the impression that an other build approach will be safer there.
> > How do you think about to add a dependency specification so that interface
> > descriptions will be always compiled before the corresponding OCaml code?
>
> Hello,
>
> I have achieved another bit of progress with my attempt to replace suffix rules
> by pattern rules in some make scripts.
> I stumbled on the next software development challenge as follows.
>
>
> elfring at Sonne:~/Projekte/Coccinelle/20160205> LANG=C make V=1
> ?
> make[6]: Entering directory '/home/elfring/Projekte/Coccinelle/20160205/globals'
> /usr/bin/ocamlopt.opt -unsafe -I ../commons -I /home/elfring/Projekte/Coccinelle/20160205/bundles/pcre/ -c iteration.ml
> File "iteration.ml", line 36, characters 4-28:
> Error: Unbound module Flag
> make[6]: *** [/home/elfring/Projekte/Coccinelle/20160205/common_rules.make:12: iteration.cmx] Error 2
> ?
>
>
> * Do I overlook an ?obvious? software dependency once more in this use case?
>
> * How should the relevant details be resolved here?

If you have changed things, then perhaps you have caused the problem?

julia

>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
