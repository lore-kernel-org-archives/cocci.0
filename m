From: mmcconville@mykolab.com (Michael McConville)
Date: Tue, 29 Sep 2015 13:38:11 -0400
Subject: [Cocci] Finding all uses of a flag define
Message-ID: <20150929173810.GA10442@thinkpad.swarthmore.edu>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

This is probably a simple question. I'm trying to find all uses of the
preproc define M_WAITOK used in the second argument of malloc() or
mallocarray(). It may be or'd with other flags in any order.

A relevant example would be enough.

Thanks,
Michael
