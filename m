From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 31 Aug 2017 21:25:28 +0200 (CEST)
Subject: [Cocci] cocci script to add static to const declarations ?
In-Reply-To: <1504203086.2786.40.camel@perches.com>
References: <1504090145.2786.16.camel@perches.com>
 <alpine.DEB.2.20.1708301334550.3184@hadrien>
 <1504094110.2786.18.camel@perches.com>
 <alpine.DEB.2.20.1708302340290.2201@hadrien>
 <1504132391.2786.31.camel@perches.com>
 <alpine.DEB.2.20.1708311618500.6822@hadrien>
 <1504203086.2786.40.camel@perches.com>
Message-ID: <alpine.DEB.2.20.1708312123450.1984@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 31 Aug 2017, Joe Perches wrote:

> On Thu, 2017-08-31 at 16:22 +0200, Julia Lawall wrote:
> > On Wed, 30 Aug 2017, Joe Perches wrote:
> > > fyi: This doesn't find const structs that could be static.
> > >
> > > Things like: drivers/gpu/drm/i915/selftests/i915_vma.c
> > > []
> > > static int igt_vma_rotate(void *arg)
> > > {
> > > []
> > > 	const struct intel_rotation_plane_info planes[] = {
> > > 		{ .width = 1, .height = 1, .stride = 1 },
> []
> > > 		{ }
> > > 	}, *a, *b;
> >
> > Here's a new version.  Unfortuntely, the ability of Coccinelle to break up
> > declarations of multiple variables like the above (planes, a, and b) is
> > rather limited.  So it doesn't get the above case.  But it does get some
> > others that have structures containing constants.  The new output is
> > attached.  You also need the latest version of Coccinelle from github.
>
> Thanks again.  This looks very good to me.
>
> Could you (or one of your minions) please submit these?

I think there was a discussion recently that suggested that one should
just submit a patch to gcc instead of 100 patches to the Linux kernel?

> gcc doesn't currently optimize these declarations into
> .text sections and instead places these bits onto stack
> along with initialization code for these bits.
>
> With the addition of static, the object code is smaller.
>
> And btw:
>
> Some of the output could still be improved by addition
> of even more static markers.
>
> For instance:
>
> diff -u -p a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
> --- a/drivers/gpu/drm/sti/sti_hdmi.c
> +++ b/drivers/gpu/drm/sti/sti_hdmi.c
> @@ -627,7 +627,7 @@ static void hdmi_dbg_sta(struct seq_file
> ?static void hdmi_dbg_sw_di_cfg(struct seq_file *s, int val)
> ?{
> ????????int tmp;
> -???????char *const en_di[] = {"no transmission",
> +???????static char *const en_di[] = {"no transmission",
> ?????????????????????????????? "single transmission",
> ?????????????????????????????? "once every field",
> ?????????????????????????????? "once every frame"};
>
> Perhaps this would be nicer as
>
> 	static const char * const en_di[] = {...
>
> Although that is a very small nit indeed.

I'm not sure what you are suggesting here.  Are there some cases where an
opportunity for static is missed?

thanks,
julia
