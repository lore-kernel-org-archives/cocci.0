From: lars@metafoo.de (Lars-Peter Clausen)
Date: Mon, 07 Jan 2013 16:43:28 +0100
Subject: [Cocci] Problem matching macro invoked on file scope
In-Reply-To: <CAACXqO-cqgSvc4k-881NV5Q7MrAs-HN28Aha-pM8deo+hA9gQg@mail.gmail.com>
References: <CAACXqO-cqgSvc4k-881NV5Q7MrAs-HN28Aha-pM8deo+hA9gQg@mail.gmail.com>
Message-ID: <50EAED20.8040500@metafoo.de>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 01/07/2013 04:34 PM, H?kon L?vdal wrote:
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

Hi,

try to add

declarer name ASYNC_DOMAIN;

to your cocci rule.

- Lars
