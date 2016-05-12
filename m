From: iago.abal@gmail.com (Iago Abal)
Date: Thu, 12 May 2016 23:09:05 +0200
Subject: [Cocci] Ignoring all code in #ifdef blocks
In-Reply-To: <alpine.DEB.2.02.1605092153370.2057@localhost6.localdomain6>
References: <5730D1FE.5020100@ti.com>
 <alpine.DEB.2.02.1605092153370.2057@localhost6.localdomain6>
Message-ID: <CAGbDTvpOmX-_BgTm2Mg6YBRTPRQRJmMUz-Q_xdf_-J0w8p1T7g@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Hi,

Indeed, --undefined only works for #ifdef and #ifndef. In any case,
Coccinelle doesn't know the definition of "IS_ENABLED". It would have to
support undefine'ing an expression, as in --undefined
"IS_ENABLED(CONFIG_OF)". Undefine'ing happens during lexing, when #if
expressions are still raw strings, so perhaps one could support
undefine'ing regular expressions over those strings.


Iago

On Mon, May 9, 2016 at 10:01 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:

>
>
> On Mon, 9 May 2016, Andrew F. Davis wrote:
>
> > Hello all,
> >
> > I am working on a cocci script to remove unneeded code and I have
> > hopefully a simple question. My script attempts to remove a macro's use,
> > but only when a relevant struct definition is *not* blocked off by #if
> > and/or #ifdef CONFIG_OF. I think I would just like to have cocci ignore
> > all code in-between any blocks but I cannot seem to get it to work. I
> > have tried --no-includes and --undefined CONFIG_OF, but it still removes
> > the target macro, even when the struct is in an ifdef block. Example:
> >
> > static const struct of_device_id gpio_ids[];
> >
> > static int somefunction()
> > {
> >       const struct of_device_id *match;
> >
> >       match = of_match_device(of_match_ptr(davinci_gpio_ids));
> > }
> >
> > #if IS_ENABLED(CONFIG_OF)
> > static const struct of_device_id gpio_ids[] = {
> >       { .compatible = "gpio", },
> >       { /* sentinel */ },
> > };
> > MODULE_DEVICE_TABLE(of, gpio_ids);
> > #endif
> >
> > static struct platform_driver gpio_driver = {
> >       .probe          = gpio_probe,
> >       .driver         = {
> >               .name           = "gpio",
> >               .of_match_table = of_match_ptr(gpio_ids),
> >       },
> > };
> >
> > None of the of_match_ptr should be removed in the above file, but if the
> > #if/endif were remove all should be removed, but I'm not sure how to
> > match for the ifdef?
>
> I'm not very familiar with the --undefined option, but it seems that it
> only works with #ifdef and #ifndef, not #if.
>
> There is no way to match against a #if or #ifdef.  Here the problem is
> particularly complex, because the #if surround multiple top-level code
> units, and Coccinelle matches the top-level code units one at a time.
>
> julia
>
> >
> > Here is my script so far:
> >
> > @s@
> > identifier arr;
> > @@
> > (
> >   struct of_device_id arr[] = {
> >       ...
> >   };
> > )
> >
> > @depends on s@
> > identifier s.arr;
> > @@
> > (
> > - of_match_ptr(arr)
> > + arr
> > )
> >
> > Thanks,
> > Andrew
> > _______________________________________________
> > Cocci mailing list
> > Cocci at systeme.lip6.fr
> > https://systeme.lip6.fr/mailman/listinfo/cocci
> >
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <https://systeme.lip6.fr/pipermail/cocci/attachments/20160512/6e3ac9ed/attachment.html>
