From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sat, 13 Oct 2018 23:19:44 +0200 (CEST)
Subject: [Cocci] Problem with improper multi-line string literals
In-Reply-To: <CAOZdJXWJLLZdttCJmZVbZU9EEjxxHGdvnRCmT+3=8O=Cv4yx-w@mail.gmail.com>
References: <CAOZdJXWJLLZdttCJmZVbZU9EEjxxHGdvnRCmT+3=8O=Cv4yx-w@mail.gmail.com>
Message-ID: <alpine.DEB.2.21.1810132318330.15695@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 12 Oct 2018, Timur Tabi wrote:

> I've attached a test.c and nv_printf.cocci file that demonstrates the problem.
>
> It appears that Coccinelle sometimes cannot handle multi-line string
> literals that are syntactically correct but still improper.  For
> example:
>
>         DBG_PRINTF((DBG_MODULE_OS, DBG_LEVEL_ERRORS,
>                     "NVRM: %s: this is a test \
>                     of multiline " NvP64_fmt " strings %p\n",
>                     __FUNCTION__,
>                     p1,
>                     p2));
>
> This is valid C, but technically the string literal should have
> quotation marks at the beginning of each line.  When Coccinelle
> attempts to process my script with this, it gets confused and mangles
> the parameters after the string literal:
>
>  void func(void)
>  {
> -        DBG_PRINTF((DBG_MODULE_OS, DBG_LEVEL_ERRORS,
> -                    "NVRM: %s: this is a test \
> -                    of multiline " NvP64_fmt " strings %p\n",
> -                    __FUNCTION__,
> -                    p1,
> -                    p2));
> -}
> +        NV_PRINTF(DBG_LEVEL_ERRORS, "NVRM: %s: this is a test \
> +                    of multiline " NvP64_fmt " strings %p\n", __FUNCTION__,
> +                    of multiline "p1, p2);
> +}"

This problem has been fixed.  Actually, it thought that "    of multiline " was the new amount to indent...

julia
