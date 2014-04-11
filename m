From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 11 Apr 2014 08:01:04 +0200 (CEST)
Subject: [Cocci] [PATCH] coccinelle: add pycocci wrapper
 for	multithreaded support
In-Reply-To: <534783DB.4080200@users.sourceforge.net>
References: <1397152097-315-1-git-send-email-mcgrof@do-not-panic.com>
 <1397152289.4757.28.camel@jlt4.sipsolutions.net>
 <20140410175748.GK14815@wotan.suse.de>
 <534783DB.4080200@users.sourceforge.net>
Message-ID: <alpine.DEB.2.02.1404110800120.2032@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 11 Apr 2014, SF Markus Elfring wrote:

> > I checked the profile results, the reason the jobs finish is some threads
> > had no work or little work.
> 
> Could you find out during the data processing which parts or files
> result in a special application behaviour you would like to point out here?

I don't understand the question at all, but since the various files have 
different properties, it is hard to determine automatically in advance how 
much work Coccinelle will need to do on each one.

julia
