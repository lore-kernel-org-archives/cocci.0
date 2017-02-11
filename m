From: mstefani@redhat.com (Michael Stefaniuc)
Date: Sat, 11 Feb 2017 20:13:24 +0100
Subject: [Cocci] coccilib.report.print_report Broken For Redirected STDOUT
Message-ID: <b3ad7723-acf2-e642-8d9b-d448bb719f03@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello!

coccilib.report.print_report is not producing any output when STDOUT is
redirected to a file or a pipe. I have attached a simple test case.

spatch cocciprint.cocci cocciprint.c
cocciprint.c:3:8-9: Printing Suceeded

spatch cocciprint.cocci cocciprint.c  > /tmp/nothing
wc -c /tmp/nothing
0 /tmp/nothing


thanks
bye
	michael
-------------- next part --------------
A non-text attachment was scrubbed...
Name: cocciprint.c
Type: text/x-csrc
Size: 42 bytes
Desc: not available
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20170211/5020f4c4/attachment.bin>
-------------- next part --------------
@r@
identifier i;
position p;
@@
 int i at p;


@ script:python @
p << r.p;
@@
coccilib.report.print_report(p[0], "Printing Suceeded")
