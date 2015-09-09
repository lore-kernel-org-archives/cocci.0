From: julia.lawall@lip6.fr (Julia Lawall)
Date: Wed, 9 Sep 2015 16:01:19 +0200 (CEST)
Subject: [Cocci] Comments removed on (adjacent) lines not touched ... ?
In-Reply-To: <CAB3z_Rpt-nF3=V_OFcBiLkYvbPefPZXA0DsRm+BUJU6gG95RMw@mail.gmail.com>
References: <CAB3z_Rpt-nF3=V_OFcBiLkYvbPefPZXA0DsRm+BUJU6gG95RMw@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1509091559330.2798@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Wed, 9 Sep 2015, Kieran Bingham wrote:

> Reviewing the changes made by my s-patch, I've come across the following hunk :
>
> ============================================================
> --- a/drivers/hwmon/jc42.c
> +++ b/drivers/hwmon/jc42.c
> ...
> @@ -529,13 +529,7 @@ static const struct dev_pm_ops jc42_dev_pm_ops = {
>  #define JC42_DEV_PM_OPS (&jc42_dev_pm_ops)
>  #else
>  #define JC42_DEV_PM_OPS NULL
> -#endif /* CONFIG_PM */
> -
> -static const struct i2c_device_id jc42_id[] = {
> -       { "jc42", 0 },
> -       { }
> -};
> -MODULE_DEVICE_TABLE(i2c, jc42_id);
> +#endif
>
>  static struct i2c_driver jc42_driver = {
>         .class          = I2C_CLASS_SPD,
> ============================================================
>
> Is this removal of the /* CONFIG_PM */ expected behaviour?
>
> I guess under the hood, Coccinelle is stripping comments from code to
> make parsing possible/easier?

Not at all. It sees this as a comment before the start of a top level
declaration, and considers that since you don't want the declaration any
more, you don't want the comment either.

It would need to observe that the comment does not start at the beginning
of the line, and treat it differntly.  Just to check, are you using
Coccinelle 1.0.2?  I made a change in this regard recently, but I'm not
sure it was an overall improvement.

julia
