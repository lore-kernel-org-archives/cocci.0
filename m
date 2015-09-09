From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 9 Sep 2015 10:22:47 +0200
Subject: [Cocci] coccinelle problems with kernel code
In-Reply-To: <20150909055721.GD27133@Sligo.logfs.org>
References: <20150908180759.GA27133@Sligo.logfs.org>
 <alpine.DEB.2.02.1509082316550.2050@localhost6.localdomain6>
 <20150908214536.GC27133@Sligo.logfs.org>
 <alpine.DEB.2.02.1509090717080.2047@localhost6.localdomain6>
 <20150909055721.GD27133@Sligo.logfs.org>
Message-ID: <55EFEC57.8060505@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> On that note, it might make sense to add multithreading or
> multiprocessing.

Did you try out to pass the parameter "--jobs" to a current version of
the command "spatch"?
Would you like to experiment with parameters "--index" and "--max"?

Regards,
Markus
