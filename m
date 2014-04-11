From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 11 Apr 2014 08:15:11 +0200
Subject: [Cocci] [PATCH] coccinelle: add pycocci wrapper for
 multithreaded support
In-Reply-To: <alpine.DEB.2.02.1404110800120.2032@localhost6.localdomain6>
References: <1397152097-315-1-git-send-email-mcgrof@do-not-panic.com>
 <1397152289.4757.28.camel@jlt4.sipsolutions.net>
 <20140410175748.GK14815@wotan.suse.de>
 <534783DB.4080200@users.sourceforge.net>
 <alpine.DEB.2.02.1404110800120.2032@localhost6.localdomain6>
Message-ID: <5347886F.8070307@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

>> Could you find out during the data processing which parts or files
>> result in a special application behaviour you would like to point out here?
> I don't understand the question at all, but since the various files have 
> different properties, it is hard to determine automatically in advance how 
> much work Coccinelle will need to do on each one.

It was reported that a system utilisation did not fit to some
expectations. I am curious if any more details or patterns can be
determined for an observed situation.

Do the involved files need also another look?
- semantic patches
- source directories

Regards,
Markus
