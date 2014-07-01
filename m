From: eric@regit.org (Eric Leblond)
Date: Tue, 01 Jul 2014 16:41:02 +0200
Subject: [Cocci] Problem with spatch 1.0rc21
Message-ID: <1404225662.25017.20.camel@ice-age2.regit.org>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

Suricata is using some coccinelle based tests for its QA and it seems
there has been a change leading to a problem in a recent coccinelle
release. Running them with coccinelle rc21 lead to an error.

When I run the following spatch on a file using strcpy, I've got a match
and an error:

@banned@
identifier func =~ "^(sprintf|strcat|strcpy|strncpy|strncat|strndup|strchrdup)$";
position p1;
@@

<+...
func(...)@p1
...+>

@script:python@
p1 << banned.p1;
func << banned.func;
@@

print("Banned function %s() used at %s:%s" % (func, p1[0].file, p1[0].line))
import sys
sys.exit(1)


The error is the following:

spatch  --sp-file qa/coccinelle/banned-functions.cocci src/source-af-packet.c 
init_defs_builtins: /usr/share/coccinelle/standard.h
HANDLING: src/source-af-packet.c
Fatal error: exception Invalid_argument("equal: abstract value")

After some try it seems that the crashing part is the affection of p1
and func. Commenting (p<< and func<<) result in a complaint about
undefined variable which is logical.

Spatch version:

spatch version 1.0.0-rc21 with Python support and with PCRE support

BR,
-- 
Eric Leblond <eric@regit.org>
