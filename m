From: picca@synchrotron-soleil.fr (picca at synchrotron-soleil.fr)
Date: Thu, 11 Sep 2014 16:51:45 +0200
Subject: [Cocci] how to add a few decalrations
In-Reply-To: <alpine.DEB.2.10.1409111634070.2419@hadrien>
References: <20140911121635.GA23610@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111513080.2419@hadrien>
 <20140911134530.GA7006@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111550170.2419@hadrien>
 <20140911140325.GA7341@synchrotron-soleil.fr>
 <20140911141340.GA7418@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111614550.2419@hadrien>
 <20140911142737.GA7480@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111634070.2419@hadrien>
Message-ID: <20140911145145.GA8047@synchrotron-soleil.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Sep 11, 2014 at 04:34:34PM +0200, Julia Lawall wrote:
> > > But the more immediate problem is that your pattern has &error and you
> > > code always has NULL in that position.  Do you want to generalize the
> > > pattern (eg expression error;) or do you want to try some other code?
> >
> > Yes the error is a GError** or NULL;
> 
> I would just use expression error.  I'm not sure thereis a need to be more
> specific than that.

Yes it is better with expression error.

is there exemple of use of transformation on the vaargs part of a method ?


Frederic
