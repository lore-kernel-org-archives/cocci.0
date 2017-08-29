From: okuznik@symas.com (=?utf-8?B?T25kxZllaiBLdXpuw61r?=)
Date: Tue, 29 Aug 2017 16:08:11 +0100
Subject: [Cocci] OpenLDAP debug statements
Message-ID: <20170829150811.xnttkxd47mknqzzn@eos.mistotebe.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi again,
having achieved some consensus to go ahead with this in the project and
some time to spare again, I have started on refining the patch to get as large
part of the OpenLDAP source code converted as possible.

There seem to be a few hundred occurrences that I can't seem to get
coccinelle to process, a few too many to process manually (by an order
of magnitude).

An example file with the most is servers/slapd/back-sql/add.c (55
instances of the Debug macro that should get some arguments dropped but
don't). Like others, spatch --parse-c finds no issues with the file.

Is there some way to improve the patch to get the false negatives down?

These are the instances I would expect removed (including the 9 that do
get picked up):
------8<-------
@@
expression E, E1, E2, S;
@@

Debug( E, S, E1, E2
*, 0
 );
------8<-------

This is the patch:
------8<-------
@@
identifier Logs =~ "Log[0-9]";
@@
-Logs
+Log

@@
@@
-StatslogTest
+LogTest

@@
format list[2] fmt;
expression list[2] args;
expression E;
@@

Debug( E, "%@fmt@", args
-, 0
 );

@@
format list[2] fmt;
expression list[2] args;
expression E;
@@

Debug( E, "%@fmt@", args
-, NULL
 );

@@
format list[1] fmt;
expression list[1] args;
expression E;
@@

Debug( E, "%@fmt@", args
-, 0, 0
 );

@@
format list[1] fmt;
expression list[1] args;
expression E;
@@

Debug( E, "%@fmt@", args
-, NULL, NULL
 );

@@
expression E, S;
@@

Debug( E, S
-, 0, 0, 0
 );

@@
expression E, S;
@@

Debug( E, S
-, NULL, NULL, NULL
 );

@@
format list[5] fmt;
expression list[5] args;
expression E;
@@

-Statslog
+Debug
 ( E, "%@fmt@", args );

@@
format list[4] fmt;
expression list[4] args;
expression E;
@@

-Statslog
+Debug
 ( E, "%@fmt@", args
-, 0
 );

@@
format list[3] fmt;
expression list[3] args;
expression E;
@@

-Statslog
+Debug
 ( E, "%@fmt@", args
-, 0, 0
 );

@@
format list[2] fmt;
expression list[2] args;
expression E;
@@

-Statslog
+Debug
 ( E, "%@fmt@", args
-, 0, 0, 0
 );

@@
format list[1] fmt;
expression list[1] args;
expression E;
@@

-Statslog
+Debug
 ( E, "%@fmt@", args
-, 0, 0, 0, 0
 );

@@
expression E, S;
@@

-Statslog
+Debug
 ( E, S
-, 0, 0, 0, 0, 0
 );

@@
identifier Stats =~ "^Statslog";
@@
(
 StatslogEtime
|
-Stats
+Debug
)
------8<-------

And this is the macro file I use:
------8<-------
#define LDAP_PF_LOCAL_SENDMSG_ARG(x)

#define LDAP_P(x) x
#define LDAP_F(x) extern x
#define LDAP_V(x) extern x

#define LDAP_GCCATTR(x)                                 
#define LDAP_XSTRING(x) ""                              
#define LDAP_CONCAT(x,y) x                              

#define LDAP_CONST const                                
#define LDAP_BEGIN_DECL                                 
#define LDAP_END_DECL                                   

#define SLAP_EVENT_DECL                                 
#define SLAP_EVENT_FNAME

#define BACKSQL_ARBITRARY_KEY
#define BACKSQL_IDNUMFMT "%llu"
#define BACKSQL_IDFMT "%s"
#define BACKSQL_IDARG(arg) ((arg).bv_val)
------8<-------

Thanks,

-- 
Ond?ej Kuzn?k
Senior Software Engineer
Symas Corporation                       http://www.symas.com
Packaged, certified, and supported LDAP solutions powered by OpenLDAP
