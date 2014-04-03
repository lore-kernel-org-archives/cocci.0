From: marcel.a@redhat.com (Marcel Apfelbaum)
Date: Thu, 03 Apr 2014 11:30:44 +0300
Subject: [Cocci] spatch issue with C struct initialization
Message-ID: <1396513844.24348.13.camel@localhost.localdomain>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,
I tried to use the coccinellery/doubleinit/doubleinit.cocci script
using the latest spatch version (1.0.0-rc20, I tried prev versions too).

I received the following error:
init_defs_builtins: /usr/local/share/coccinelle/standard.h
400 401
Fatal error: exception Failure("minus: parse error: 
 = File "coccinellery/doubleinit/doubleinit.cocci", line 17, column 22,  charpos = 400
    around = '.', whole content = struct I s =@p0 { ... .fld at p = E, ...};
")

Am I missing something, am I doing something wrong?

I need the following construct to work:
struct I s =
{
...
.fld = E,
...
};

Any help will be appreciated,
Thanks,
Marcel
