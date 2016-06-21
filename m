From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 21 Jun 2016 19:47:30 +0200
Subject: [Cocci] [PATCH v2 1/3] docs/demos: add a few ++ documentation
 and demos
In-Reply-To: <1466459648-17477-2-git-send-email-mcgrof@kernel.org>
References: <1466459648-17477-1-git-send-email-mcgrof@kernel.org>
 <1466459648-17477-2-git-send-email-mcgrof@kernel.org>
Message-ID: <19333678-f008-fc1d-d201-834e312ec031@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +Coccinelle allows for transformations to enable modifying C code using

Can the word "for" be omitted here?


> +You may run into the situation where grammar you specificy for

Did you overlook to fix a typo here once more?

? specify ?


> +in code, in such cases Coccinelle cannot gaurantee order when making

? guarantee ?


> +additions. If you are sure that order does not matter you can use the

Have you got other preferences (than me) for the usage of commas?


> +may add things out of order. This may be for intance rather safe in

? instance ?


> +precise order of the where each float is placed is however not gauranteed

? guaranteed


How do you think about to improve spell checking for such update suggestions?

Regards,
Markus
