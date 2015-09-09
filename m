From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Sep 2015 16:18:00 +0200 (CEST)
Subject: [Cocci] Comments removed on (adjacent) lines not touched ... ?
In-Reply-To: <CAB3z_Rp9V9U8KcD6OgY=tuTmO3AHVT-UwwVim+yxitMAvQWWgw@mail.gmail.com>
References: <CAB3z_Rpt-nF3=V_OFcBiLkYvbPefPZXA0DsRm+BUJU6gG95RMw@mail.gmail.com>
 <alpine.DEB.2.10.1509091559330.2798@hadrien>
 <CAB3z_Rp9V9U8KcD6OgY=tuTmO3AHVT-UwwVim+yxitMAvQWWgw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1509091617370.2798@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 9 Sep 2015, Kieran Bingham wrote:

> Hi Julia
>
> On 9 September 2015 at 15:01, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> >
> > On Wed, 9 Sep 2015, Kieran Bingham wrote:
> >
> >> Reviewing the changes made by my s-patch, I've come across the following hunk :
> >>
> >> ============================================================
> >> --- a/drivers/hwmon/jc42.c
> >> +++ b/drivers/hwmon/jc42.c
> >> ...
> >> @@ -529,13 +529,7 @@ static const struct dev_pm_ops jc42_dev_pm_ops = {
> >>  #define JC42_DEV_PM_OPS (&jc42_dev_pm_ops)
> >>  #else
> >>  #define JC42_DEV_PM_OPS NULL
> >> -#endif /* CONFIG_PM */
> >> -
> >> -static const struct i2c_device_id jc42_id[] = {
> >> -       { "jc42", 0 },
> >> -       { }
> >> -};
> >> -MODULE_DEVICE_TABLE(i2c, jc42_id);
> >> +#endif
> >>
> >>  static struct i2c_driver jc42_driver = {
> >>         .class          = I2C_CLASS_SPD,
> >> ============================================================
> >>
> >> Is this removal of the /* CONFIG_PM */ expected behaviour?
> >>
> >> I guess under the hood, Coccinelle is stripping comments from code to
> >> make parsing possible/easier?
> >
> > Not at all. It sees this as a comment before the start of a top level
> > declaration, and considers that since you don't want the declaration any
> > more, you don't want the comment either.
> >
>
>
> Ahh yes, I see this here! (Actually sounds like a reasonable thing to do!)
> @@ -207,37 +207,6 @@ enum chips { lm90, adm1032, lm99, lm86, max6657,
> max6659, adt7461, max6680,
>  #define MAX6696_STATUS2_LOT2   (1 << 7) /* local emergency limit tripped */
>
>  /*

Is there really no - here?

julia

> - * Driver data (common to all clients)
> - */
> -
> -static const struct i2c_device_id lm90_id[] = {
> -       { "adm1032", adm1032 },
> -       { "adt7461", adt7461 },
> -       { "adt7461a", adt7461 },
> -       { "g781", g781 },
>
>
>
>
>
>
> > It would need to observe that the comment does not start at the beginning
> > of the line, and treat it differntly.  Just to check, are you using
> > Coccinelle 1.0.2?  I made a change in this regard recently, but I'm not
> > sure it was an overall improvement.
>
> No - I'm afraid I'm using the version shipped with ubuntu 15.04:
>
> spatch --version
> spatch version 1.0.0-rc22 with Python support and with PCRE support
>
>
> --
> Regards
>
> Kieran
>
> >
> > julia
>
