From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 9 Feb 2016 09:27:34 +0100
Subject: [Cocci] [PATCH v2] coccinelle: add style check for assignment
	in if
In-Reply-To: <1454935571-4054-1-git-send-email-kborer@gmail.com>
References: <1454935571-4054-1-git-send-email-kborer@gmail.com>
Message-ID: <56B9A2F6.4040109@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +virtual patch

How do you think about to use this variable in a subsequent
SmPL rule?

Would you like to consider also the reuse of SmPL variables
like "org" and "report"?

Regards,
Markus
