From: j.lancia@serma.com (LANCIA Julien)
Date: Tue, 26 Mar 2013 14:29:06 +0000
Subject: [Cocci] Control flow query across files
Message-ID: <13CEBF2EC72707459166C3356C1FEC8B7C3B22E0@ST-PES-MBX-01.serma.local>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,
I've stumbled accross coccinelle and I'm interested in using it to perform queries on the control flow graph (quite similarly to what have been done in "Finding Error Handling Bugs in OpenSSL using Coccinelle" by Lawall and al.).
However, I wonder if it is possible to perform queries on the control flow graph that span across a single C file.

An example to be clear:

fileA.h : f(), g(), h()
fileA.c : f() calls g() calls h() calls i()

fileA.h : i() j() k()
fileA.c : i() calls j() calls k()

Is it possible with coccinelle to match the query
f()
...
k()

that spans across fileA.c and fileB.c ?

Thanks in advance for your help,
Regards,

Julien Lancia

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20130326/98a420b0/attachment-0001.html>
