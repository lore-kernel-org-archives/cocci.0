From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 30 Apr 2015 15:51:08 +0200 (CEST)
Subject: [Cocci] Packages for release 1.0.0
In-Reply-To: <554232B2.10107@redhat.com>
References: <44BEB158-144E-4ADA-9B1E-9AC634906DE0@gmail.com>
 <alpine.DEB.2.02.1504292115570.2042@localhost6.localdomain6>
 <554232B2.10107@redhat.com>
Message-ID: <alpine.DEB.2.10.1504301549510.2415@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 30 Apr 2015, Michael Stefaniuc wrote:

> Hello Julia,
>
> On 04/29/2015 09:16 PM, Julia Lawall wrote:
> > On Wed, 29 Apr 2015, Eliseo Mart?nez wrote:
> >
> >> Hi,
> >>
> >> I?ve seen release 1.0.0 has been published recently. Congrats!
> >> Unfortunately, it seems distribution packages (at least those for Ubuntu) are still stuck on 1.0.0-rc23 (Oct 2014).
> >> Are there plans to update these?
> >
> > I could ping them, but I have already found a bug.  I'll see if I can fix
> > it by Monday.
> I found a whitespace placement "regression" too. But I didn't get the
> time yet to create a simple test case for that. Are you interested in
> that too? I can do it only tonight as I have it on my home desktop only.

Yes, please.  Tonight is competely fine.

As a side note, the previous release contained improved regression testing
for whitespace problems, so I hope that in the future the handling of
whitespace will only improve...

julia
