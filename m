From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 14 Nov 2017 14:32:06 +0100
Subject: [Cocci] [v4] Coccinelle: fix parallel build with
	CHECK=scripts/coccicheck
In-Reply-To: <1510659487-16361-1-git-send-email-yamada.masahiro@socionext.com>
References: <1510659487-16361-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <81500e6b-6e36-ffa6-97a0-c396f3b62ca5@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> Setting NPROC=1 is a reasonable solution;

It can be sufficient for the usual purposes of the shell script ?scripts/coccicheck?.


> spatch does not create the subdirectory.

I would like to point out that further development efforts will be needed
if such a special directory handling should be avoided generally.
How much do care about consequences if parameters for additional parallelisation
would be passed over the command line option (or the environment variable)
?SPFLAGS? as it is described in the file ?Documentation/dev-tools/coccinelle.rst??

Regards,
Markus
