From: timur@kernel.org (Timur Tabi)
Date: Fri, 12 Oct 2018 18:22:29 -0500
Subject: [Cocci] Problem with improper multi-line string literals
In-Reply-To: <CAOZdJXXcSEc0XkX-k=omA_yf4_SZFMYXmZwVXGcsjVRf+jhrDg@mail.gmail.com>
References: <CAOZdJXWJLLZdttCJmZVbZU9EEjxxHGdvnRCmT+3=8O=Cv4yx-w@mail.gmail.com>
 <alpine.DEB.2.21.1810122336171.2383@hadrien>
 <CAOZdJXWzDQay=sRwri7N_Hanzee1Qkwqg-ezLiY3_JToCp9kog@mail.gmail.com>
 <CAOZdJXWS0ABNYmz0WyDvVnxonGGELu6Qedi4nMfHrNHOsVwJ-Q@mail.gmail.com>
 <CAOZdJXXcSEc0XkX-k=omA_yf4_SZFMYXmZwVXGcsjVRf+jhrDg@mail.gmail.com>
Message-ID: <CAOZdJXUs=A=Wrh_bb1jDCtRr123BVH422ozVZ-z1W8PmNNCd0g@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Fri, Oct 12, 2018 at 6:08 PM Timur Tabi <timur@kernel.org> wrote:

> -        DBG_PRINTF((DBG_MODULE_OS, DBG_LEVEL_ERRORS,
> -                    "NVRM: %s: this is a test \
> -                    of multiline " NvP64_fmt " strings %p\n",
> -                    __FUNCTION__,
> -                    p1,
> -                    p2));
> +        NV_PRINTF(LEVEL_ERROR,
> +                  "this is a test of multiline " NvP64_fmt " strings %p\n",
> +                  p1, p2);
>
>
> -        NV_PRINTF(LEVEL_INFO, "%s\n", __FUNCTION__);
> +        NV_PRINTF(LEVEL_INFO, "\n");
>
> That second diff should not be there.
>
> Looking at the output of --debug, I see it go through all the rules
> and tell me what dependencies are satisfied, but it only does it once.
> I would expect Coccinelle to re-evaluate all the rules for every line
> of code it sees.  My script used to do that, so I broke it somehow.

The weird thing is that if I remove the DBG_PRINTF(()) line in test.c,
then the NV_PRINTF() line is *not* modified.  It's as if Coccinelle
doesn't reset the dependencies when it evaluates the NV_PRINTF() line.
