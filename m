From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 5 Apr 2017 16:18:17 +0200 (CEST)
Subject: [Cocci] question on parsing g_assert_cmpint() macro
In-Reply-To: <093bdf57-0d50-8075-b0a1-6c4cbb9eda38@redhat.com>
References: <ec3eceb6-9f04-b04c-a09c-92f744d23f36@redhat.com>
 <alpine.DEB.2.20.1704050723290.2242@hadrien>
 <093bdf57-0d50-8075-b0a1-6c4cbb9eda38@redhat.com>
Message-ID: <alpine.DEB.2.20.1704051617480.3005@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 5 Apr 2017, Eric Blake wrote:

> On 04/05/2017 12:25 AM, Julia Lawall wrote:
>
> >> What is the trick for teaching coccinelle about what g_assert_cmpint()
> >> expands to, and/or completely ignoring the use of that macro, so that I
> >> don't have to manually look for spots that the cleanup missed?
> >
> > Try adding
> >
> > #define g_assert_cmpint(x,y,z)
> >
> > to the macro definition file standard.h.  Or you can make your own macro
> > definition file for qemu and give it as an argument --macro-file file.h
> >
> > Write back if that does not solve the problem.
>
> Thanks. I didn't realize qemu already had a scripts/cocci-macro-file.h
> designed just for this purpose, and it includes
>
> #define g_assert_cmpint(a, op, b)   g_assert(a op b)

This definition looks fine too.

julia

>
> which indeed solves the problem.
>
> --
> Eric Blake   eblake redhat com    +1-919-301-3266
> Libvirt virtualization library http://libvirt.org
>
>
