From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Fri, 12 Sep 2014 11:00:22 +0200
Subject: [Cocci] Transformations around variadic functions
In-Reply-To: <20140912084025.GA3099@synchrotron-soleil.fr>
References: <alpine.DEB.2.10.1409111513080.2419@hadrien>
 <20140911134530.GA7006@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111550170.2419@hadrien>
 <20140911140325.GA7341@synchrotron-soleil.fr>
 <20140911141340.GA7418@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111614550.2419@hadrien>
 <20140911142737.GA7480@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111634070.2419@hadrien>
 <20140911145145.GA8047@synchrotron-soleil.fr>
 <5412ACF0.8050408@users.sourceforge.net>
 <20140912084025.GA3099@synchrotron-soleil.fr>
Message-ID: <5412B626.1080801@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


>> Are you looking for a way to adjust source code with functions that
>> contain an ellipsis in their signature?
>> Would you like to inspect parameter lists?
> Yes exactly.

There are some software development challenges in the corresponding
handling of variadic functions.
https://systeme.lip6.fr/pipermail/cocci/2014-March/000698.html
http://article.gmane.org/gmane.comp.version-control.coccinelle/3521

Have you got any more concrete imaginations for your use case?
