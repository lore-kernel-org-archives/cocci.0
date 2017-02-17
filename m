From: mstefani@redhat.com (Michael Stefaniuc)
Date: Fri, 17 Feb 2017 14:29:10 +0100
Subject: [Cocci] Python Output Not Flushed With -j > 1
Message-ID: <9bb393fd-22cf-8b1e-33e8-755e0ba02ed3@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

this is a follow up on the "[Cocci] coccilib.report.print_report Broken
For Redirected STDOUT".

But this not only affects coccilib.report.print_report but also the
normal print. I noticed this only when running my real script in my own
coccicheck implementation that automatically uses -j <nr_cpus>.
I have another script that uses the python print() but that produces so
much output to more than fill the buffers.


With a slightly modified .cocci file from last time:
sibiu:/tmp$ spatch -j 1 cocciprint.cocci cocciprint.c > out 2> /dev/null
&& cat out
cocciprint.c:3:8-9: coccilib.report.print_report Suceeded
print() Succeded
sibiu:/tmp$ spatch -j 2 cocciprint.cocci cocciprint.c > out 2> /dev/null
&& cat out
sibiu:/tmp$ spatch -j 3 cocciprint.cocci cocciprint.c > out 2> /dev/null
&& cat out
sibiu:/tmp$


I use for now print(..., flush=True) to workaround the issue.

bye
	michael
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cocciprint.c
Type: text/x-csrc
Size: 42 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170217/3adf9aa6/attachment.bin>
-------------- next part --------------
@r@
identifier i;
position p;
@@
 int i at p;


@ script:python @
p << r.p;
@@
coccilib.report.print_report(p[0], "coccilib.report.print_report Suceeded")
print("print() Succeded")
