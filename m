From: hlovdal@gmail.com (=?UTF-8?B?SMOla29uIEzDuHZkYWw=?=)
Date: Tue, 8 Jan 2013 10:22:55 +0100
Subject: [Cocci] Problem matching macro invoked on file scope
In-Reply-To: <50EAED20.8040500@metafoo.de>
References: <CAACXqO-cqgSvc4k-881NV5Q7MrAs-HN28Aha-pM8deo+hA9gQg@mail.gmail.com>
 <50EAED20.8040500@metafoo.de>
Message-ID: <CAACXqO8YWmf6hNCZGUU4-WNptxnR2T=Ph55b-w4xWAT_uCE-WQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 7 January 2013 16:43, Lars-Peter Clausen <lars@metafoo.de> wrote:
> Hi,
>
> try to add
>
> declarer name ASYNC_DOMAIN;
>
> to your cocci rule.

Exellent, yes this was exactly what I was missing. With that the script prints

ASYNC_DOMAIN is called with _name equal to async_running
ASYNC_DOMAIN is called with _name equal to scsi_sd_probe_domain

for the linux files. So the problem I started with is solved.
The following is not important to get an answer to, but I was a little
bit surprised and would like to understand the issue.

I ran the script on the dummy_async_domain_test.c file as well and it
now only matches mytest1 and mytest2, which is expected behaviour as far
as I can tell. Out of curiosity I thought that if I wanted to match all
four cases then I could just add an additional rule without declarer, e.g.


// with declarer
@rule1@
declarer name ASYNC_DOMAIN;
identifier id;
@@
ASYNC_DOMAIN(id);

@script:python@
id << rule1.id;
@@
print "1: ASYNC_DOMAIN is called with _name equal to %s" % (id)

// without declarer
@rule2@
identifier id;
@@
ASYNC_DOMAIN(id);

@script:python@
id << rule2.id;
@@
print "2: ASYNC_DOMAIN is called with _name equal to %s" % (id)


but running with this gives

1: ASYNC_DOMAIN is called with _name equal to mytest1
1: ASYNC_DOMAIN is called with _name equal to mytest2
2: ASYNC_DOMAIN is called with _name equal to mytest1
2: ASYNC_DOMAIN is called with _name equal to mytest2

so it seems that the declarer property from rule1 is "leaking" into
rule2 as well. Is this intended behaviour? If I reverse the order and
put rule2 and the corresponding python script@the top then it prints
like I expected in the first place.

2: ASYNC_DOMAIN is called with _name equal to mytest3
2: ASYNC_DOMAIN is called with _name equal to mytest4
1: ASYNC_DOMAIN is called with _name equal to mytest1
1: ASYNC_DOMAIN is called with _name equal to mytest2


BR H?kon L?vdal
