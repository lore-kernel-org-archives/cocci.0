From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 21 Jul 2016 21:00:41 +0200
Subject: [Cocci] Changing return value determination in if statements with
	SmPL
In-Reply-To: <20160721163714.GB1616@katana>
References: <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net>
 <66bd684a-98f1-0ec4-aa95-1a966d7c4e90@users.sourceforge.net>
 <6a8f4258-188e-36f6-28fa-1626c29cf361@users.sourceforge.net>
 <alpine.DEB.2.10.1607172056220.3177@hadrien> <20160720155333.GE1688@katana>
 <b249584b-47b8-ffd9-432e-986d69260ff1@users.sourceforge.net>
 <20160721062726.GC1664@katana>
 <b221aadb-2af7-8d0f-ce8e-99b1efa31edd@users.sourceforge.net>
 <20160721163714.GB1616@katana>
Message-ID: <6f2ca140-9384-bc3f-9d20-2433b808d566@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I am trying the software combination "spatch version 1.0.5-00058-g36edc2b-dirty
compiled with OCaml version 4.03.0" out a bit more with the following approach.


@checking_function_calls_directly@
identifier checker, retval, work;
parameter list pl;
statement is, es;
type rt;
@@
 rt checker(...)
 {
  ...
-retval = work(pl);
 if (
-    retval
+    work(pl)
    )
    is
 else
    es
  ...
 }


elfring at Sonne:~/Projekte/Coccinelle/janitor> spatch.opt -sp-file checking_function_calls_directly1.cocci ~/Projekte/Linux/next-patched/drivers/staging/ks7010/ks7010_sdio.c
init_defs_builtins: /usr/local/lib64/coccinelle/standard.h
minus: parse error: 
  File "checking_function_calls_directly1.cocci", line 10, column 15, charpos = 151
  around = 'pl',
  whole content = -retval = work(pl);



Do I overlook anything in my SmPL script?

Regards,
Markus
