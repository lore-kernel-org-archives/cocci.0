From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 7 Jan 2013 16:45:51 +0100 (CET)
Subject: [Cocci] Problem matching macro invoked on file scope
In-Reply-To: <CAACXqO-cqgSvc4k-881NV5Q7MrAs-HN28Aha-pM8deo+hA9gQg@mail.gmail.com>
References: <CAACXqO-cqgSvc4k-881NV5Q7MrAs-HN28Aha-pM8deo+hA9gQg@mail.gmail.com>
Message-ID: <alpine.DEB.2.02.1301071645080.1908@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

declarer name ASYNC_DOMAIN;

Off topic, but worth mentioning, there is also iterator name for declaring
loop constructs.

julia

On Mon, 7 Jan 2013, H?kon L?vdal wrote:

> Hi list. I have trouble getting coccinelle to match macros invoked on
> file scope (as opposed to invoked inside a function).
>
> Example: grepping the whole linux source code for ASYNC_DOMAIN gets
> three matches:
>
> linux/drivers/scsi/scsi.c:ASYNC_DOMAIN(scsi_sd_probe_domain);
> linux/include/linux/async.h:#define ASYNC_DOMAIN(_name) \
> linux/kernel/async.c:static ASYNC_DOMAIN(async_running);
>
> so if I want to know what identifier names that are used as arguments
> to ASYNC_DOMAIN I see the answer right there, but let's say I want to
> use coccinelle to find the answer.
>
>
>
> $ cat find_ASYNC_DOMAIN.cocci
>
> @rule1@
> identifier id;
> @@
>
> ASYNC_DOMAIN(id);
>
> @script:python@
> id << rule1.id;
> @@
>
> print "ASYNC_DOMAIN is called with _name equal to %s" % (id)
>
>
> $ ./spatch --sp-file find_ASYNC_DOMAIN.cocci linux/drivers/scsi/scsi.c
> linux/kernel/async.c
> init_defs_builtins: /tmp/coccinelle/share/coccinelle/standard.h
> HANDLING: linux/drivers/scsi/scsi.c linux/kernel/async.c
> $ cat dummy_async_domain_test.c
>
>
> ASYNC_DOMAIN(mytest1);
> ASYNC_DOMAIN(
>         mytest2
> );
>
> int main(int argc, char *argv[])
> {
>         ASYNC_DOMAIN(mytest3);
>         ASYNC_DOMAIN(
>                 mytest4
>         );
>         return 0;
> }
>
> $ ./spatch --sp-file find_ASYNC_DOMAIN.cocci dummy_async_domain_test.c
> init_defs_builtins: /tmp/coccinelle/share/coccinelle/standard.h
> HANDLING: dummy_async_domain_test.c
> ASYNC_DOMAIN is called with _name equal to mytest3
> ASYNC_DOMAIN is called with _name equal to mytest4
> $
>
>
>
> As you can see the script fails to match ASYNC_DOMAIN when it is put on
> file scope but if I put it inside a function it is found. What do I need
> to change in order to match on file scope?
>
> BR H?kon L?vdal
>
>
> PS
> This was sort of a continuation of my last post, but I drilled down to the
> problem to be just macro on file scope and I though it is more clean to
> start a new thread.
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
