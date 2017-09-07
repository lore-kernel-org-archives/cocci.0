From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 7 Sep 2017 20:10:45 +0200
Subject: [Cocci] Checking statement order for patch generation with SmPL
	support
In-Reply-To: <alpine.DEB.2.20.1709071619340.3168@hadrien>
References: <2a2b1ae2-ff84-2bda-3701-548dd9ee1edf@users.sourceforge.net>
 <alpine.DEB.2.20.1709071519240.3168@hadrien>
 <c803beac-9fbe-f52d-18b5-6ef3ca3cbcb3@users.sourceforge.net>
 <alpine.DEB.2.20.1709071619340.3168@hadrien>
Message-ID: <a99dbaa2-8bfd-7ee1-0122-9b99d4d9fdda@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Thers is a control-flow path from the bottom of a loop back up to the top.

I wonder also about the information how an ordinary for loop could influence
the shown source code analysis result for the function ?snd_seq_queue_find_name?
when the questionable marked statements are contained in a single if branch.
http://elixir.free-electrons.com/linux/v4.13/source/sound/core/seq/seq_queue.c#L241
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/tree/sound/core/seq/seq_queue.c?id=c6be5a0e3cebc145127d46a58350e05d2bcf6323#n252


I have tried the following SmPL script variant out on another source file.

@usage@
identifier action!~"^.+free$", member, release=~"^.+free$";
expression context, ex;
@@
*release(context);
 ... when != context = ex
     when any
*action(..., (context)->member, ...)


elfring at Sonne:~/Projekte/Linux/next-patched> spatch.opt ~/Projekte/Coccinelle/janitor/show_use_after_free3.cocci sound/soc/soc-pcm.c
?
@@ -1199,14 +1199,11 @@ void dpcm_be_disconnect(struct snd_soc_p
 			stream ? "<-" : "->", dpcm->be->dai_link->name);
 
 		/* BEs still alive need new FE */
-		dpcm_be_reparent(fe, dpcm->be, stream);
 
 #ifdef CONFIG_DEBUG_FS
-		debugfs_remove(dpcm->debugfs_state);
 #endif
 		list_del(&dpcm->list_be);
 		list_del(&dpcm->list_fe);
-		kfree(dpcm);
 	}
 }


I find the shown matches also questionable for this test result.
Would you like to clarify such software situations a bit more
for the desired handling of statement sequences?

Regards,
Markus
