From: picca@synchrotron-soleil.fr (picca at synchrotron-soleil.fr)
Date: Fri, 12 Sep 2014 10:59:45 +0200
Subject: [Cocci] How to add a few declarations?
In-Reply-To: <alpine.DEB.2.10.1409121043310.2580@hadrien>
References: <alpine.DEB.2.10.1409111550170.2419@hadrien>
 <20140911140325.GA7341@synchrotron-soleil.fr>
 <20140911141340.GA7418@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111614550.2419@hadrien>
 <20140911142737.GA7480@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409111634070.2419@hadrien>
 <20140911145145.GA8047@synchrotron-soleil.fr>
 <5412ACF0.8050408@users.sourceforge.net>
 <20140912084025.GA3099@synchrotron-soleil.fr>
 <alpine.DEB.2.10.1409121043310.2580@hadrien>
Message-ID: <20140912085945.GE3099@synchrotron-soleil.fr>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Sep 12, 2014 at 10:43:55AM +0200, Julia Lawall wrote:
> On Fri, 12 Sep 2014, picca at synchrotron-soleil.fr wrote:
> 
> > On Fri, Sep 12, 2014 at 10:21:04AM +0200, SF Markus Elfring wrote:
> > > > is there exemple of use of transformation on the vaargs part of a method ?
> > >
> > > Are you looking for a way to adjust source code with functions that
> > > contain an ellipsis in their signature?
> > > Would you like to inspect parameter lists?
> >
> > Yes exactly.
> 
> Sorry, but that is not clear enough for me to have an idea of what you
> want to do.  Please send a concrete example.
> 
> julia

Hello,

I want to transform this method

int f(T1 x, T2 y, T3 z, ...);

called like this

f(x, y, z, 0.0, 6.0, 5.0)

into

{
	double values[] = {0.0, 6.0, 5.0};
	unsigned int n_values = ARRAY_SIZE(values);
	f2(x, values, n_values, y, z);
}

where the signature of f2 is

int f(T1 x, double[] v, unsigned int n_v, T2 y, T3, z)


the variadic part of the method contain only double in my case.

BEtter ?

Frederic
