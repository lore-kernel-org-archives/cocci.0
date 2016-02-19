From: harish.chegondi@intel.com (Chegondi, Harish)
Date: Fri, 19 Feb 2016 02:35:14 +0000
Subject: [Cocci] Coccinelle parse errors
Message-ID: <2821164A880A16429BC851319A6EBBC57128DD99@ORSMSX111.amr.corp.intel.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I am trying to run coccicheck (make coccicheck M=<path>) against my code and I have been seeing the following exception failure parse errors with Coccinelle releases 1.0.2 and 1.0.4. I have installed OCaml version 4.01.0. Any help on how to resolve these issues would be appreciated.


With release 1.0.2:

999 1000
Fatal error: exception Failure("minus: parse error:
= File "./scripts/coccinelle/iterators/device_node_continue.cocci", line 46, column 0,  charpos = 999
    around = 'i', whole content = i at p1(...) {
")


With release 1.0.4:

3561 3562
Fatal error: exception Failure("minus: parse error:
= File "./scripts/coccinelle/iterators/use_after_iter.cocci", line 126, column 0,  charpos = 3561
    around = '&', whole content = &c->member
")



Thank You very much
Harish.
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160219/a926e3bc/attachment.html>
