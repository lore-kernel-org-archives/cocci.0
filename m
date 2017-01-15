From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 15 Jan 2017 17:47:14 +0100 (CET)
Subject: [Cocci] More coccinelle problems
In-Reply-To: <5c27cf78-f9b2-8306-4009-1e284ac8ee5c@roeck-us.net>
References: <5c27cf78-f9b2-8306-4009-1e284ac8ee5c@roeck-us.net>
Message-ID: <alpine.DEB.2.20.1701151731560.3751@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 15 Jan 2017, Guenter Roeck wrote:

> Hi Julia,
>
> I got another script which hangs for me. It actually works on almost all
> files,
> but hangs in drivers/input/keyboard/gpio_keys_polled.c. The hang does not
> happen
> if I remove the 'reformat' rule.
>
> In case you wonder, the idea is to reformat the code if another rule touched
> function parameters. I stripped the context to make the problem easier to
> reproduce.
>
> If you have an idea what might cause the hang, please let me know.

I haven't tested it yet, but I believe that the <+... ...+> is never
useful outermost, in a rule like the following:

@reformat@
identifier fn;
position c.p1;
expression list EL;
@@
<+...
- fn@p1(EL)
+ fn(EL)
...+>

The typical use of <+... P ...+> is when you are between point A and point
B, and you want to be sure that there is at least one match of P between
them.  Nothing depends on reformat, so you don't actually care if there
are any occurrences at all.  If there are, they will get changed and if
there aren't then nothing will happen.  So it should be:

@reformat@
identifier fn;
position c.p1;
expression list EL;
@@

- fn at p1(EL)
+ fn(EL)

Does this remove the point of the example?

julia
