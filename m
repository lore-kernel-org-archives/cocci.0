From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 31 Aug 2017 07:04:39 +0200 (CEST)
Subject: [Cocci] cocci script to add static to const declarations ?
In-Reply-To: <1504132391.2786.31.camel@perches.com>
References: <1504090145.2786.16.camel@perches.com>
 <alpine.DEB.2.20.1708301334550.3184@hadrien>
 <1504094110.2786.18.camel@perches.com>
 <alpine.DEB.2.20.1708302340290.2201@hadrien>
 <1504132391.2786.31.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1708310703270.2010@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 30 Aug 2017, Joe Perches wrote:

> On Wed, 2017-08-30 at 23:41 +0200, Julia Lawall wrote:
> > New version.
>
> Thanks.
>
> fyi: This doesn't find const structs that could be static.

Indeed, neither version intended to do that.  I can extend it.  It will
remain fixed to some level of nesting though.

julia

>
> Things like: drivers/gpu/drm/i915/selftests/i915_vma.c
> []
> static int igt_vma_rotate(void *arg)
> {
> []
> 	const struct intel_rotation_plane_info planes[] = {
> 		{ .width = 1, .height = 1, .stride = 1 },
> 		{ .width = 2, .height = 2, .stride = 2 },
> 		{ .width = 4, .height = 4, .stride = 4 },
> 		{ .width = 8, .height = 8, .stride = 8 },
>
> 		{ .width = 3, .height = 5, .stride = 3 },
> 		{ .width = 3, .height = 5, .stride = 4 },
> 		{ .width = 3, .height = 5, .stride = 5 },
>
> 		{ .width = 5, .height = 3, .stride = 5 },
> 		{ .width = 5, .height = 3, .stride = 7 },
> 		{ .width = 5, .height = 3, .stride = 9 },
>
> 		{ .width = 4, .height = 6, .stride = 6 },
> 		{ .width = 6, .height = 4, .stride = 6 },
> 		{ }
> 	}, *a, *b;
>
>
