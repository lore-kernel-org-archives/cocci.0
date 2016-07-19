From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 19 Jul 2016 12:07:42 +0200 (CEST)
Subject: [Cocci] version 1.0.4 released
In-Reply-To: <20160719100538.GA16888@redhat.com>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <20151027101421.GA14273@redhat.com>
 <20151027102517.GA3871@pl-59055.rocqadm.inria.fr>
 <20151027115733.GB14273@redhat.com>
 <20151027123748.GA27349@pl-59055.rocqadm.inria.fr>
 <alpine.DEB.2.02.1510282304240.2054@localhost6.localdomain6>
 <20160719100538.GA16888@redhat.com>
Message-ID: <alpine.DEB.2.10.1607191206540.2930@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Tue, 19 Jul 2016, Richard W.M. Jones wrote:

> On Wed, Oct 28, 2015 at 11:06:34PM +0100, Julia Lawall wrote:
> > Version 1.0.4 is released.  This removes the make of spgen when making
> > spatch, removes the pre-generated menhir file when menhir is available,
> > and adds the ability to reason about the lengths of statement lists.
>
> This problem has reoccured in 1.0.5.  The generated files must
> be removed first, if compiling with external menhir.

OK.  I think this problem has been fixed, but we need to make a new
release.  Maybe you should just wait for 1.0.6, if it is causing a
problem.  Thanks for the report.

julia
