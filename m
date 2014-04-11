From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 11 Apr 2014 07:55:39 +0200
Subject: [Cocci] [PATCH] coccinelle: add pycocci wrapper for
	multithreaded support
In-Reply-To: <20140410175748.GK14815@wotan.suse.de>
References: <1397152097-315-1-git-send-email-mcgrof@do-not-panic.com>
 <1397152289.4757.28.camel@jlt4.sipsolutions.net>
 <20140410175748.GK14815@wotan.suse.de>
Message-ID: <534783DB.4080200@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I checked the profile results, the reason the jobs finish is some threads
> had no work or little work.

Could you find out during the data processing which parts or files
result in a special application behaviour you would like to point out here?

Regards,
Markus
