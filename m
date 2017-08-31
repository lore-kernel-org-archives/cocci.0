From: joe@perches.com (Joe Perches)
Date: Thu, 31 Aug 2017 11:11:26 -0700
Subject: [Cocci] cocci script to add static to const declarations ?
In-Reply-To: <alpine.DEB.2.20.1708311618500.6822@hadrien>
References: <1504090145.2786.16.camel@perches.com>
 <alpine.DEB.2.20.1708301334550.3184@hadrien>
 <1504094110.2786.18.camel@perches.com>
 <alpine.DEB.2.20.1708302340290.2201@hadrien>
 <1504132391.2786.31.camel@perches.com>
 <alpine.DEB.2.20.1708311618500.6822@hadrien>
Message-ID: <1504203086.2786.40.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, 2017-08-31 at 16:22 +0200, Julia Lawall wrote:
> On Wed, 30 Aug 2017, Joe Perches wrote:
> > fyi: This doesn't find const structs that could be static.
> > 
> > Things like: drivers/gpu/drm/i915/selftests/i915_vma.c
> > []
> > static int igt_vma_rotate(void *arg)
> > {
> > []
> > 	const struct intel_rotation_plane_info planes[] = {
> > 		{ .width = 1, .height = 1, .stride = 1 },
[]
> > 		{ }
> > 	}, *a, *b;
> 
> Here's a new version.  Unfortuntely, the ability of Coccinelle to break up
> declarations of multiple variables like the above (planes, a, and b) is
> rather limited.  So it doesn't get the above case.  But it does get some
> others that have structures containing constants.  The new output is
> attached.  You also need the latest version of Coccinelle from github.

Thanks again.  This looks very good to me.

Could you (or one of your minions) please submit these?

gcc doesn't currently optimize these declarations into
.text sections and instead places these bits onto stack
along with initialization code for these bits.

With the addition of static, the object code is smaller.

And btw:

Some of the output could still be improved by addition
of even more static markers.

For instance:

diff -u -p a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -627,7 +627,7 @@ static void hdmi_dbg_sta(struct seq_file
?static void hdmi_dbg_sw_di_cfg(struct seq_file *s, int val)
?{
????????int tmp;
-???????char *const en_di[] = {"no transmission",
+???????static char *const en_di[] = {"no transmission",
?????????????????????????????? "single transmission",
?????????????????????????????? "once every field",
?????????????????????????????? "once every frame"};

Perhaps this would be nicer as

	static const char * const en_di[] = {...

Although that is a very small nit indeed.
