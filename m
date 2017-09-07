From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Thu, 7 Sep 2017 15:10:50 +0200
Subject: [Cocci] Checking statement order for patch generation with SmPL
	support
Message-ID: <2a2b1ae2-ff84-2bda-3701-548dd9ee1edf@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hello,

I have constructed another small script for the semantic patch language.

@usage@
identifier action, member, release=~"^.+free$";
expression context;
@@
*release(context);
 <+...
*action(..., (context)->member, ...)
 ...+>


The following source code place can be found by such a simple approach
for further software development considerations.
https://lkml.org/lkml/2017/9/6/669

elfring at Sonne:~/Projekte/Linux/next-patched> git checkout next-20170905 && spatch.opt ~/Projekte/Coccinelle/janitor/show_use_after_free1.cocci sound/pci/ymfpci/ymfpci.c
?
@@ -336,8 +336,6 @@ static int snd_card_ymfpci_probe(struct
 			legacy_ctrl &= ~YMFPCI_LEGACY_FMEN;
 			pci_write_config_word(pci, PCIR_DSXG_LEGACY, legacy_ctrl);
 		} else if ((err = snd_opl3_hwdep_new(opl3, 0, 1, NULL)) < 0) {
-			snd_card_free(card);
-			dev_err(card->dev, "cannot create opl3 hwdep\n");
 			return err;
 		}
 	}


I have tried the SmPL script out on another source file.

elfring at Sonne:~/Projekte/Linux/next-patched> spatch.opt ~/Projekte/Coccinelle/janitor/show_use_after_free1.cocci sound/core/seq/seq_queue.c
?
@@ -246,9 +246,7 @@ struct snd_seq_queue *snd_seq_queue_find
 
 	for (i = 0; i < SNDRV_SEQ_MAX_QUEUES; i++) {
 		if ((q = queueptr(i)) != NULL) {
-			if (strncmp(q->name, name, sizeof(q->name)) == 0)
 				return q;
-			queuefree(q);
 		}
 	}
 	return NULL;


Now I wonder why the software ?Coccinelle 1.0.6-00242-g3f038a5d? finds
this place relevant when the function call sequence does not fit to the order
I tried to express for a known use case.
I would appreciate further advice.

Regards,
Markus
