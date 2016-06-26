From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sun, 26 Jun 2016 09:40:33 +0200
Subject: [Cocci] [PATCH v3] bundles/pycaml/: use .NOTPARALLEL on bundles
In-Reply-To: <1466461206-6960-1-git-send-email-mcgrof@kernel.org>
References: <1466461206-6960-1-git-send-email-mcgrof@kernel.org>
Message-ID: <936c5e24-58b0-61bd-48ea-940dc16c6c13@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> make[6]: *** No rule to make target
> 'chemoelectric-pycaml-8614105/pycaml.a', needed by
> 'all-opt-build-targets'.

How do you think about to complete the dependency specification
because of this error message?
https://github.com/coccinelle/coccinelle/blob/b102e7684f79aa05ba7bcc7927d0382f2ab51e72/bundles/Makefile.bundles#L32

Regards,
Markus
