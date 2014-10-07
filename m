From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 7 Oct 2014 21:44:33 +0200 (CEST)
Subject: [Cocci] Searching for pass-through functions
In-Reply-To: <5434416C.40205@users.sourceforge.net>
References: <54303340.3090901@users.sourceforge.net>
 <5434416C.40205@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1410072144150.2079@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 7 Oct 2014, SF Markus Elfring wrote:

> > I have retried a source code analysis approach which was discussed a while ago.
> 
> http://git.minix3.org/index.cgi?p=minix.git;a=summary
> 
> elfring at Sonne:~/Projekte/MINIX/lokal> date && spatch.opt -timeout 30 -sp-file
> ~/Projekte/Coccinelle/lokal/demos/pass-through/list_pass-through_functions.cocci
> -dir . > list_pass-through_functions.txt 2>
> list_pass-through_functions-errors.txt && date
> Di 7. Okt 19:51:59 CEST 2014
> Di 7. Okt 19:58:10 CEST 2014
> 
> 
> The exceptions in the mentioned log file can be transformed into a small statistic.
> 
> Nr. | Message | Incidence
>  1  | Failure("lexing: empty token") | 24
>  2  | File "./ctlcocci_integration.ml", line 246, characters 4-10: Assertion
> failed | 3
>  3  | Common.Timeout | 3
>  4  | Failure("is_pass_through: node 612: return ...[1,2,259] in getanswer
> reachable by inconsistent control-flow paths") | 1
>  5  | Failure("internal error: there is no noconst or novolatile keyword") | 1
> 
> 
> How do you think about such a result?
> Would you like to clarify corresponding details?

It is completely useless to me without knowing what C files are affected.

julia
