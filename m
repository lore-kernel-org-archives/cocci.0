From: waldemar.rymarkiewicz@gmail.com (Waldemar Rymarkiewicz)
Date: Tue, 20 Sep 2016 14:38:11 +0200
Subject: [Cocci] Match #define with SmPL
In-Reply-To: <42692ede-c509-7a9e-04d4-5eec51a2fc25@users.sourceforge.net>
References: <CAHKzcEN9fcOk1HCar=u+htx=o61xF61VmbO9PeYPBaedTQYDcg@mail.gmail.com>
 <alpine.DEB.2.10.1609141615560.3033@hadrien>
 <CAHKzcEMih-YHeaaa6hp1-Hf3PUY7GDdqG90wL6zZwuMjaQv=-g@mail.gmail.com>
 <alpine.DEB.2.10.1609150803290.6497@hadrien>
 <CAHKzcEMSxEXkDRqwTKq-AXZmFsH8uwsniQoCd1Uj_xCzn-nU_Q@mail.gmail.com>
 <42692ede-c509-7a9e-04d4-5eec51a2fc25@users.sourceforge.net>
Message-ID: <CAHKzcEO7E5GTujn58B0V=Q8WcZ2AiLXu5uN2y9D+r-VxWXJqoA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I would be also looking for an interface to store the text from the macro definition
> into a corresponding data structure.
>
> * How do think about to look at another "story" like "Checking printk() calls with SmPL"
>   once more?
>   https://github.com/coccinelle/coccinelle/issues/54#issuecomment-169988424
>
> * Which metavariable types would be appropriate for the discussed source code transformation?
>
>
> I would like to point another detail out for further considerations according to
> your initial request.
>
> 1. I guess that you should use the SmPL asterisk functionality if you are interested
>    in only finding (or "matching") a bit of code.
>
> @macro_definition@
> @@
> *#define pr_fmt(fmt) "SVM: " fmt
>
>
> init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
> minus: parse error:
>   File "/home/elfring/Projekte/Coccinelle/Probe/show_macro_definition1.cocci", line 3, column 29, charpos = 51
>   around = 'fmt',
>   whole content = *#define pr_fmt(fmt) "SVM: " fmt
>
>
> 2. Do you want to try another source code adjustment out?
>
> @statement_addition@
> @@
> +#undef  pr_fmt
>  #define pr_fmt(fmt) "SVM: " fmt
>
>
> elfring at Sonne:~/Projekte/Linux/next-patched> spatch.opt ~/Projekte/Coccinelle/Probe/add_undef1.cocci arch/x86/kvm/svm.c
> init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
> minus: parse error:
>   File "/home/elfring/Projekte/Coccinelle/Probe/add_undef1.cocci", line 4, column 29, charpos = 69
>   around = 'fmt',
>   whole content =  #define pr_fmt(fmt) "SVM: " fmt
>
>
> How often would you like to use such search patterns for your source files?

I've already tried all above, but always I get parser error.
Apparently parsing #defines is not working as expected specially if
you use argument list.


/Waldek
