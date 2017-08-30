From: joe@perches.com (Joe Perches)
Date: Wed, 30 Aug 2017 04:55:10 -0700
Subject: [Cocci] cocci script to add static to const declarations ?
In-Reply-To: <alpine.DEB.2.20.1708301334550.3184@hadrien>
References: <1504090145.2786.16.camel@perches.com>
 <alpine.DEB.2.20.1708301334550.3184@hadrien>
Message-ID: <1504094110.2786.18.camel@perches.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Wed, 2017-08-30 at 13:41 +0200, Julia Lawall wrote:
> The main rule is "worrisome", which will set a position variable if any
> field is not a constant.??This considers anything that is in all capital
> letters to be a constant, which is not safe.??To forbid all arrays that
> contain any identifier, in capital letters or not, one could convert
> \(c\|e at bad\)
> 
> to
> 
> \(i at bad\|c\|e at bad\)
[]
> diff -u -p a/drivers/video/fbdev/tmiofb.c b/drivers/video/fbdev/tmiofb.c
> --- a/drivers/video/fbdev/tmiofb.c
> +++ b/drivers/video/fbdev/tmiofb.c
> @@ -436,7 +436,7 @@ static int tmiofb_sync(struct fb_info *f
> ?static void
> ?tmiofb_fillrect(struct fb_info *fbi, const struct fb_fillrect *rect)
> ?{
> -???????const u32 cmd[] = {
> +???????static const u32 cmd[] = {
> ????????????????TMIOFB_ACC_DSADR((rect->dy * fbi->mode->xres + rect->dx) * 2),
> ????????????????TMIOFB_ACC_DHPIX(rect->width - 1),
> ????????????????TMIOFB_ACC_DVPIX(rect->height - 1),

False positives like the above exist in the attachment so
it seems the additional check is necessary.
