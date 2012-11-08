From: tipecaml@gmail.com (Cyril Roelandt)
Date: Thu, 08 Nov 2012 02:29:17 +0100
Subject: [Cocci] =?iso-8859-1?q?_=5BReview_needed=5D=A0Ensure_that_calls_t?=
 =?iso-8859-1?q?o_d=5Ffind=5Falias=28=29_are_followed_by_dput=28=29=2E?=
Message-ID: <509B0AED.6050208@gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

After seeing this patch 
http://permalink.gmane.org/gmane.linux.kernel.commits.head/348204 I 
tried to write a semantic patch that ensures that a call to 
d_find_alias() is followed by a call to dput().

The attached patch seems to do that. I wrote it by copying the example 
found in the "Reference counter: the of_xxx API" paragraph of the 
grammar. I haven't played with Coccinelle in a while though, and I can't 
remember exactly the semantics of the "exists" keyword and of the "<... 
...>" and "<+... ...+>". Could you enlighten me ?

If the patch looks good to you, I'll send it to kernel-janitors (unless 
there is a more approriate list for semantic patches) along with a few 
patches.


WBR,
Cyril Roelandt.
-------------- next part --------------
An embedded and charset-unspecified text was scrubbed...
Name: d_find_alias.cocci
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20121108/62a6d448/attachment.ksh>
-------------- next part --------------
_______________________________________________
Cocci mailing list
Cocci at diku.dk
http://lists.diku.dk/mailman/listinfo/cocci
(Web access from inside DIKUs LAN only)
