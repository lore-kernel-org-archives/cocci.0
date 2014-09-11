From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 11 Sep 2014 15:37:00 +0200 (CEST)
Subject: [Cocci] How to add a few declarations?
In-Reply-To: <20140911131614.GA23824@synchrotron-soleil.fr>
References: <20140911121635.GA23610@synchrotron-soleil.fr>
 <54119DC7.7020005@users.sourceforge.net>
 <20140911131614.GA23824@synchrotron-soleil.fr>
Message-ID: <alpine.DEB.2.10.1409111535550.2419@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 11 Sep 2014, picca at synchrotron-soleil.fr wrote:

> On Thu, Sep 11, 2014 at 03:04:07PM +0200, SF Markus Elfring wrote:
> > > So the idea is to replace a method by another one but to be able to do that, I need to add two new variables n_values and values.
> >
> > Have you got any expectations on the placement for the added variables?
>
> I imagine at the begining of the scope where the ..._set_v method is located.

My solution was to put them all at the beginning of the function.

The innermost enclosing scope would be a bit hard to specify.

If you want to just add a new scope around the replaced call, that would
be easiest, and would not require the fresh identifier names.

julia
