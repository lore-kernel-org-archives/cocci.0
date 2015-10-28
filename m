From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 28 Oct 2015 08:08:15 +0100 (CET)
Subject: [Cocci] version 1.0.3 released
In-Reply-To: <20151027212658.GC14273@redhat.com>
References: <alpine.DEB.2.02.1510262151580.2079@localhost6.localdomain6>
 <20151027101421.GA14273@redhat.com>
 <20151027102517.GA3871@pl-59055.rocqadm.inria.fr>
 <20151027115733.GB14273@redhat.com>
 <20151027123748.GA27349@pl-59055.rocqadm.inria.fr>
 <20151027212658.GC14273@redhat.com>
Message-ID: <alpine.DEB.2.02.1510280805420.2056@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 27 Oct 2015, Richard W.M. Jones wrote:

> On Tue, Oct 27, 2015 at 01:37:48PM +0100, S?bastien Hinderer wrote:
> > Hi again Richard and all,
> > 
> > Richard W.M. Jones (2015/10/27 11:57 +0000):
> > > BTW the 'spgen' program is installed, but it's broken.  It's built as
> > > a bytecode program using 'ocamlc -custom', RPM strips it (removing the
> > > bytecode), and consequently the binary won't function on Fedora.  It
> > > should have been built as a native program since I requested 'make
> > > world'.
> > 
> > A new release of coccinelle fixing this issue will be published soon
> > (hopefully tomorrow).
> 
> So this means I shouldn't be distributing spgen in our binary package?
> 
> I was a bit confused about what this program does - there didn't seem
> to be much documentation for it :-(

It is used to make a semntic patche acceptable for inclusion in the Linux 
kernel.  There is actually a very nice documentation for it in the 
spgen/documentation directory.  But don't worry about distributing it now.  
We will try to make it available in a better manner for the next release 
(not the one planned for today, but after that).

julia
