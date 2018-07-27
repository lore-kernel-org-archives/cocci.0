From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 27 Jul 2018 18:46:16 +0200 (CEST)
Subject: [Cocci] Search/replace inside string constants?
In-Reply-To: <CAOZdJXV4rb-Snt95ZcLJG1v-qV_O+RKjC=X0ACZghmDK=WXGnA@mail.gmail.com>
References: <CAOZdJXUV2CS=V8K3WMmWXZf5cE9Jrgfwv2e-R0+PJGrzj3tr1Q@mail.gmail.com>
 <alpine.DEB.2.20.1807270034400.2489@hadrien>
 <CAOZdJXWgmXbbTjOJL2osCLE_sy7kdb-_fnrPx7QnrSuZCnaQ2A@mail.gmail.com>
 <alpine.DEB.2.20.1807270051320.2489@hadrien>
 <CAOZdJXV4rb-Snt95ZcLJG1v-qV_O+RKjC=X0ACZghmDK=WXGnA@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807271845380.12787@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Fri, 27 Jul 2018, Timur Tabi wrote:

> On Thu, Jul 26, 2018 at 5:54 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> > @script:python s@
> > c << r.c;
> > c2;
> > @@
> > coccinelle.c2 = "desired change in c with extra double quotes on the outside"
>
> Ok, I almost have it working.  It seems to trigger some of the time.
>
> @script:python s@
> c << r.c;
> c2;
> @@
> if c.startswith('"NVRM: '):
>     coccinelle.c2 = '"' + c[7:];
> else:
>     coccinelle.c2 = c;
>
> So this works:
>
> -        DBG_PRINTF((DBG_MODULE_OS, DBG_LEVEL_ERRORS,
> -            "NVRM: failed to blacklist GPU: 0x%x\n", rmStatus));
> +        NV_PRINTF(LEVEL_ERROR, "failed to blacklist GPU: 0x%x\n",
> +                  rmStatus);
>
> But this didn't:
>
> -        DBG_PRINTF((DBG_MODULE_OS, DBG_LEVEL_ERRORS,
> -            "NVRM: fifoGetUserdBar1MapInfo failed, bailing out of
> RmInitAdapter\n"));
> +        NV_PRINTF(LEVEL_ERROR,
> +                  "NVRM: fifoGetUserdBar1MapInfo failed, bailing out
> of RmInitAdapter\n");

Do you know what the problem is?  If not, please send the complete
semantic patch and an appropriate .c file so that I can test it.

thanks,
julia
