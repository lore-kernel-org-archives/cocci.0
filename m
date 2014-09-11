From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Sep 2014 16:34:34 +0200 (CEST)
Subject: [Cocci] how to add a few decalrations
In-Reply-To: <20140911142737.GA7480@synchrotron-soleil.fr>
References: <20140911121635.GA23610@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111513080.2419@hadrien>
 <20140911134530.GA7006@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111550170.2419@hadrien>
 <20140911140325.GA7341@synchrotron-soleil.fr>
 <20140911141340.GA7418@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111614550.2419@hadrien>
 <20140911142737.GA7480@synchrotron-soleil.fr>
Message-ID: <alpine.DEB.2.10.1409111634070.2419@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> > But the more immediate problem is that your pattern has &error and you
> > code always has NULL in that position.  Do you want to generalize the
> > pattern (eg expression error;) or do you want to try some other code?
>
> Yes the error is a GError** or NULL;

I would just use expression error.  I'm not sure thereis a need to be more
specific than that.

julia
