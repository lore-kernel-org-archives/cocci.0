From: timur@kernel.org (Timur Tabi)
Date: Tue, 9 Oct 2018 17:30:39 -0500
Subject: [Cocci] Dummy rule for simplifying "depends on" clauses?
Message-ID: <CAOZdJXUWj-U87j6p-AK8wx_V4qRPD2ogyLyOgLE7pSFofzQ_Gw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

In my cocci script, I have several rules, only one of which will
match.  I then have a bunch of other rules that should be run only if
one of the first rules is run.  So I have something like this:

@rule1@
@@
...

@rule2@
@@
...

@rule3@
@@
...

@depends on rule1 || rule2 || rule3@
...

@depends on rule1 || rule2 || rule3@
...

How can I create a dummy rule so that I can do something like this:

@rule1@
@@
...

@rule2@
@@
...

@rule3@
@@
...

@depends on rule1 || rule2 || rule3@
@dummy@
...

@depends on dummy@
...

@depends on dummy@
...
