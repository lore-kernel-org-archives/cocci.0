From: peter.senna@gmail.com (Peter Senna Tschudin)
Date: Wed, 9 Jan 2013 15:01:34 -0200
Subject: [Cocci] Matching outside of blocks
In-Reply-To: <20130109123454.GA29477@avionic-0098.adnet.avionic-design.de>
References: <20130109123454.GA29477@avionic-0098.adnet.avionic-design.de>
Message-ID: <CA+MoWDpyz1+mWF-DCqgnY-b4ksgreyK9EMu0U21j95U9aKj7kA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

What version of Coccinelle are you using? I suggest you try the latest
one available at:
http://coccinelle.lip6.fr/download.php

On Wed, Jan 9, 2013 at 10:34 AM, Thierry Reding
<thierry.reding@avionic-design.de> wrote:
> Hi,
>
> I'm trying to come up with a semantic patch to modify the meaning of the
> devm_request_and_ioremap() functions return value. The goal is to return
> an ERR_PTR() encoded errno in order to allow the proper error code to be
> propagated to the caller.
Will you change the function itself so it will return ERR_PRT() encoded errno?

>
> Since devm_request_and_ioremap() is called quite often, I thought this
> would be an interesting task to solve with coccinelle. I've come up with
> this semantic patch:
>
>         virtual patch
>         virtual report
>
>         @depends on patch@
>         expression e;
>         @@
>
>          e = devm_request_and_ioremap(...);
>          ...
>         (
>         -if (\(e == NULL\|!e\)) {
>         +if (IS_ERR(e)) {
>                 ...
>         -       return ...;
>         +       return PTR_ERR(e);
>          }
>         |
>         -if (\(e == NULL\|!e\))
>         -       return ...;
>         +if (IS_ERR(e))
>         +       return PTR_ERR(e);
>         )
>
>         @r depends on report@
>         expression e;
>         position p1;
>         @@
>
>         *e = devm_request_and_ioremap at p1(...);
>          ...
>         (
>          if (\(e == NULL\|!e\)) {
>                 ...
>                 return ...;
>          }
>         |
>          if (\(e == NULL\|!e\))
>                 return ...;
>         )
>
>         @script:python depends on r@
>         p1 << r.p1;
>         @@
>
>         msg = "ERROR: old devm_request_and_ioremap() API used on line %s" % (p1[0].line)
>         coccilib.report.print_report(p1[0], msg)

I made some changes for patch mode:
@@
expression e;
@@

e = devm_request_and_ioremap(...);
...
if
-(e == NULL)
+(IS_ERR(e))
{
<...
-       return ...;
+       return PTR_ERR(e);
...>
}

You can save this text in a .cocci file then use it with:
$ cd /linux-source
$ spatch -dir . /tmp/file.cocci

Note that some isomorphisms like e = NULL and !e are automatically
taken care for you. Check Coccinelle iso file for more details.

>
> This seems to work fine for most cases, but I've come across a tricky
> one in drivers/gpio/gpio-mxs.c. The code looks roughly like this:
>
>         if (np) {
>                 ...
>                 base = of_iomap(parent, 0);
>                 ...
>         } else {
>                 iores = platform_get_resource(...);
>                 base = devm_request_and_ioremap(...);
>         }
>         if (!base)
>                 return -EADDRNOTAVAIL;
>
> The odd thing is that in report mode this case is actually detected, but
> the patch mode doesn't generate a hunk for this occurrence.

The position variable is storing the position of
devm_request_and_ioremap, this is why the report mode detect it. The
problem is that base could receive its content from
devm_request_and_ioremap(...); or from of_iomap(parent, 0);. For this
case I would manually add different return for each case. Something
like:

if (np) {
        ...
        base = of_iomap(parent, 0);
        ...
        if (!base)
                return -EADDRNOTAVAIL;
} else {
        iores = platform_get_resource(...);
        base = devm_request_and_ioremap(...);
        if (!base)
                return PTR_ERR(base);
}

>
> I wonder what I need to change to make this case work. From my very
> limited understanding of coccinelle it would seem that the issue is that
> the devm_request_and_ioremap() call and the return value check are in
> different blocks, but I have no idea how to take that into account. Then
> again, maybe the problem is something completely different.
>
> Does anybody have any hints?
1 - I would work on a Coccinelle script that works for the common
cases and do the exceptions manually.
2 - Even for changes made by Coccinelle I would double check if the
proposed transformation is what I was expecting.
3 - There are a lot of examples at: coccinellery.org

>
> Thanks,
> Thierry
>
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>



--
Peter
