From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 31 Mar 2018 08:18:01 +0200 (CEST)
Subject: [Cocci] [PATCH] crypto: cavium: zip: Remove unnecessary
 parentheses
In-Reply-To: <CAAFX7JTfWdaGra+kWBJt-GXVVO601K03qWnExFKFD_9vxS-03g@mail.gmail.com>
References: <20180328175736.17360-1-rvarsha016@gmail.com>
 <1522260676.12357.121.camel@perches.com>
 <CAAFX7JTfWdaGra+kWBJt-GXVVO601K03qWnExFKFD_9vxS-03g@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1803310817420.2373@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 29 Mar 2018, Varsha Rao wrote:

> On Wed, Mar 28, 2018 at 11:41 PM, Joe Perches wrote:
> >
> > On Wed, 2018-03-28 at 23:27, Varsha Rao wrote:
> > > This patch fixes the clang warning of extraneous parentheses, with the
> > > following coccinelle script.
> > >
> > > @@
> > > identifier i;
> > > constant c;
> > > @@
> > > (
> > > -((i == c))
> > > +i == c
> > > >
> > >
> > > -((i <= c))
> > > +i <= c
> >
> > Why just the "==" and "<=" cases?
> > Why not "<", ">" and ">=" too?
> >
> > Why not expression instead of constant?
>
> Initially I had the other cases too and used expression instead of
> constant. But the results included only "==" and "<=" cases with
> constant. Along with one false positive case.
>
> --- a/drivers/crypto/cavium/zip/zip_main.c
> +++ b/drivers/crypto/cavium/zip/zip_main.c
> @@ -99,7 +99,7 @@ static struct zip_device *zip_alloc_devi
>   */
>  struct zip_device *zip_get_device(int node)
>  {
> -    if ((node < MAX_ZIP_DEVICES) && (node >= 0))
> +    if (node < MAX_ZIP_DEVICES && node >= 0)

Why is it a false positive?

julia

>          return zip_dev[node];
>
>      zip_err("ZIP device not found for node id %d\n", node);
>
> I checked if there was any case of extra parentheses around relational
> operators left, but there were none. Hence, in the script I included
> only the cases present in the result.
>
> Thanks,
> Varsha
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
>
