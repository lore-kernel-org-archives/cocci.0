From: ydroneaud@opteya.com (Yann Droneaud)
Date: Tue, 01 Aug 2017 16:23:18 +0200
Subject: [Cocci] Surprising parsing error occuring when casting C string
In-Reply-To: <alpine.DEB.2.20.1708011543570.21130@hadrien>
References: <1501592641.3791.10.camel@opteya.com>
 <alpine.DEB.2.20.1708011543570.21130@hadrien>
Message-ID: <1501597398.3791.12.camel@opteya.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Le mardi 01 ao?t 2017 ? 15:46 +0200, Julia Lawall a ?crit :
> On Tue, 1 Aug 2017, Yann Droneaud wrote:
> 
> > I'm wondering why coccinelle seems not to be able to apply simple
> > semantic patch when code source contains casted C string.
> 
> Fixed.  Take the github version.
> 
> Basically, Coccinelle makes some inferences during parsin about what
> maybe a typedef.  That explains the examples you have below about
> some cases working.  I extended those rules to take some more kinds
> of constants into account.
> 

It works ! Thanks a lot for this very quick fix.

$ ../../UPSTREAM/coccinelle/spatch.opt --version
spatch version 1.0.6-00186-g0acd38eed4e5 compiled with OCaml version
4.04.0
Flags passed to the configure script: [none]
Python scripting support: yes
Syntax of regular expresssions: PCRE

$ ../../UPSTREAM/coccinelle/spatch.opt --verbose-parsing --sp-file
test.cocci test.c
init_defs_builtins: ../../UPSTREAM/coccinelle/standard.h
HANDLING: test.c
diff = 
--- test.c
+++ /tmp/cocci-output-20045-ee70d9-test.c
@@ -7,7 +7,7 @@ static structure_t array[] =
 void function(void)
 {
         if (!other(1, (pointer_t)"value", 3))
-                foo();
+                FOO();
         else
                 bar();
 }


Regards.

-- 
Yann Droneaud
OPTEYA
