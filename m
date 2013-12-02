From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Mon, 02 Dec 2013 23:00:41 +0100
Subject: [Cocci] [PATCH 1/2] coccinelle: mkdir ocaml/coccilib/ upon
	install
In-Reply-To: <1385999169-19497-1-git-send-email-mcgrof@do-not-panic.com>
References: <1385999169-19497-1-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <529D0309.6020604@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>  Makefile | 1 +
>  1 file changed, 1 insertion(+)

Would you really like to change Coccinelle's main make file?
https://github.com/coccinelle/coccinelle/blob/a74652145f2a7c7dbd2bf6d9b9be6bacefe677e0/Makefile

How do you think about to adjust the autotools build specification instead?

Regards,
Markus
