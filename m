From: rjones@redhat.com (Richard W.M. Jones)
Date: Tue, 19 Jul 2016 11:13:55 +0100
Subject: [Cocci] version 1.0.4 released
In-Reply-To: <alpine.DEB.2.10.1607191206540.2930@hadrien>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <20151027101421.GA14273@redhat.com>
 <20151027102517.GA3871@pl-59055.rocqadm.inria.fr>
 <20151027115733.GB14273@redhat.com>
 <20151027123748.GA27349@pl-59055.rocqadm.inria.fr>
 <alpine.DEB.2.02.1510282304240.2054@localhost6.localdomain6>
 <20160719100538.GA16888@redhat.com>
 <alpine.DEB.2.10.1607191206540.2930@hadrien>
Message-ID: <20160719101355.GE16797@redhat.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, Jul 19, 2016 at 12:07:42PM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 19 Jul 2016, Richard W.M. Jones wrote:
> 
> > On Wed, Oct 28, 2015 at 11:06:34PM +0100, Julia Lawall wrote:
> > > Version 1.0.4 is released.  This removes the make of spgen when making
> > > spatch, removes the pre-generated menhir file when menhir is available,
> > > and adds the ability to reason about the lengths of statement lists.
> >
> > This problem has reoccured in 1.0.5.  The generated files must
> > be removed first, if compiling with external menhir.
> 
> OK.  I think this problem has been fixed, but we need to make a new
> release.  Maybe you should just wait for 1.0.6, if it is causing a
> problem.  Thanks for the report.

It's no problem - I have added a workaround in the RPM build.

I was just noting that the workaround was necessary.

Rich.

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-builder quickly builds VMs from scratch
http://libguestfs.org/virt-builder.1.html
