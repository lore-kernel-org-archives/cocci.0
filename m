From: tipecaml@gmail.com (Cyril Roelandt)
Date: Thu, 08 Nov 2012 02:31:45 +0100
Subject: [Cocci] [Review needed] Ensure that calls to d_find_alias() are
 followed by dput().
Message-ID: <509B0B81.50304@gmail.com>
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
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20121108/715def61/attachment.ksh>
