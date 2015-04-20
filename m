From: michal.kazior@tieto.com (Michal Kazior)
Date: Mon, 20 Apr 2015 11:14:38 +0200
Subject: [Cocci] Is list_entry/rcu2.cocci example from coccinellery broken?
Message-ID: <CA+BoTQkZfT2_9-b48GSY19H7fRWpsq0R1Kd5yKR0Kqs2w7=6hQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I'm trying to learn spatch. While playing around I've hit a problem of
not being able to figure out how to rename hash_for_each_safe() in
Linux kernel. I've looked around and found an adequate example which
seemed to do what I'm interested in as well. However upon trying to
test it it fails:

 ; cd /usr/src/linux
 ; wget https://raw.githubusercontent.com/coccinelle/coccinellery/c53a020006e37c40f006c3ab2f016b76b0de4d01/list_entry/rcu2.cocci
 ; spatch --version
spatch version 1.0.0-rc24 with Python support and with PCRE support
 ; spatch --sp-file rcu2.cocci --dir .
init_defs_builtins: /usr/local/share/coccinelle/standard.h
1179 1196
Fatal error: exception Failure("minus: parse error:
 = File "rcu2.cocci", line 80, column 2,  charpos = 1179
    around = 'list_for_each_rcu', whole content = - list_for_each_rcu(_X(I),E1)
")

Is this known? Is this a bug in spatch or is the example out of date?
If it's the latter can anyone give me a hint how such a rename should
be done now?


Micha?
