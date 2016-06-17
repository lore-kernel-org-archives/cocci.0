From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 17 Jun 2016 11:44:26 +0200 (CEST)
Subject: [Cocci] [PATCH v2 4/8] scripts: add glimpse.sh for indexing the
	kernel
In-Reply-To: <1466116292-21843-5-git-send-email-mcgrof@kernel.org>
References: <1466116292-21843-1-git-send-email-mcgrof@kernel.org>
 <1466116292-21843-5-git-send-email-mcgrof@kernel.org>
Message-ID: <alpine.DEB.2.10.1606171129200.3164@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

I'm not sure that this is worth it.  It adds a dependency on a tool that
seems not to be well maintained.  In terms of Coccinelle, I'm not sure
that it gives a big benefit.

Attached is a graph showing the file selection time for Coccinelle for a
selection of fairly complex semantic patches.  Coccigrep is just a
line-by-line regexp search implemented in ocaml, gitgrep uses git grep.
In most cases, glimpse is clearly faster.

On the other hand, it seems that glimpse often selects more files.
Sometimes a few more, eg 16 vs 14, and sometimes quite a lot more, eg 538
vs 236.  I suspect that this is because glimpse considers _ to be a space,
and thus it can have many false positives.  There are, however, a few
cases where glimpse also selects fewer files.

The file processing time (ie parsing the file, searching for, matches of
the semantic patch in the file, and performing the transformation) is
normally much higher than the file selection time.

So it seems that git grep is currently a better option for the kernel.

julia
-------------- next part --------------
A non-text attachment was scrubbed...
Name: fl.pdf
Type: application/pdf
Size: 16124 bytes
Desc: 
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160617/4455aab3/attachment-0001.pdf>
