From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 31 Jul 2015 09:03:23 +0200
Subject: [Cocci] autotools: add localversion information
In-Reply-To: <1438034612-10595-3-git-send-email-mcgrof@do-not-panic.com>
References: <1438034612-10595-1-git-send-email-mcgrof@do-not-panic.com>
 <1438034612-10595-3-git-send-email-mcgrof@do-not-panic.com>
Message-ID: <55BB1DBB.4030606@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> When working from source, the average user and developer will run just
> ./autogen, this will peg the local version into the version string.

How do you think about to collaborate with a command like "autoreconf --install"?
http://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.69/html_node/autoreconf-Invocation.html


Do the available build scripts need any more clean-up and improvements?
https://github.com/coccinelle/coccinelle/blob/e7dd46783d6addd7efad735144d85ed8fde841ce/configure.ac#L11

Regards,
Markus
