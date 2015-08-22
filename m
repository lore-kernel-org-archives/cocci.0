From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 22 Aug 2015 07:17:45 -0700 (PDT)
Subject: [Cocci] Checking data structure modification with SmPL
In-Reply-To: <55D31848.1060900@users.sourceforge.net>
References: <55D31848.1060900@users.sourceforge.net>
Message-ID: <alpine.DEB.2.10.1508220716010.2531@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 18 Aug 2015, SF Markus Elfring wrote:

> Hello,
>
> I have tried another small SmPL script out.
>
> @show_modification_before_memory_release@
> expression value;
> identifier element, var;
> @@
>  <+...
> *var->element = value;
>  ...+>
>  free(var);
>
>
> This approach is working to some degree.
> Now I would like to support more possibilities for the determination
> of affected members from the shown variable.
>
>
> @show_modification_before_memory_release@
> expression element, value;
> identifier var;
> @@
>  <+...
> *var->element = value;

Element is not an expression.  An expression is something that has a
value.  A field name has no value.  It just enables selecting a field.
Probably what you want is <+...var->element...+>, ie something that has
var->element as a subexpression.  To avoid parsing ambiguities, you will
need to put () around this, but it will not affect the results.

julia

>  ...+>
>  free(var);
>
>
> elfring at Sonne:~/Projekte/Miller/lokal> spatch.opt -sp-file ~/Projekte/Coccinelle/janitor/show_modification_before_memory_release1.cocci c/containers/hss.c
> init_defs_builtins: /usr/local/lib/coccinelle/standard.h
> 101 108
> Fatal error: exception Failure("minus: parse error: \n = File \"/home/elfring/Projekte/Coccinelle/janitor/show_modification_before_memory_release1.cocci\", line 6, column 6,  charpos = 101\n    around = 'element', whole content = *var->element = value;\n")
>
>
> How can this source code analysis be improved?
>
> Regards,
> Markus
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
