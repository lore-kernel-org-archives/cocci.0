From: julia.lawall@lip6.fr (Julia Lawall)
Date: Fri, 27 Jul 2018 00:54:28 +0200 (CEST)
Subject: [Cocci] Search/replace inside string constants?
In-Reply-To: <CAOZdJXWgmXbbTjOJL2osCLE_sy7kdb-_fnrPx7QnrSuZCnaQ2A@mail.gmail.com>
References: <CAOZdJXUV2CS=V8K3WMmWXZf5cE9Jrgfwv2e-R0+PJGrzj3tr1Q@mail.gmail.com>
 <alpine.DEB.2.20.1807270034400.2489@hadrien>
 <CAOZdJXWgmXbbTjOJL2osCLE_sy7kdb-_fnrPx7QnrSuZCnaQ2A@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807270051320.2489@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Jul 2018, Timur Tabi wrote:

> On Thu, Jul 26, 2018 at 5:36 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> >
> > The easiest thing would be to use python.  You can look at
> > demos/pythontococci.cocci for an example.  If you send a complete change
> > that you would like to make, I can write an example rule.
>
> My goal is to replace usage of a deprecated macro with a new one, but
> some of the parameters has changed.
>
> So
>
> DBG_PRINTF((DBG_MODULE_OS, DBG_LEVEL_ERRORS, "NVRM: error status:
> 0x%x\n", status));
>
> becomes
>
> NV_PRINTF(LEVEL_ERROR, "failed to blacklist GPU: 0x%x\n", status);
>
> So I think I've got everything except the removal of "NVRM: " from the
> beginning of any strings where the macro has been changed.

@r@
constant char[] c;
expression list[n] es;
@@

foo(es,c,...)

@script:python s@
c << r.c;
c2;
@@
coccinelle.c2 = "desired change in c with extra double quotes on the outside"

@@
expression list[r.n] r.es;
constant char[] r.c;
identifier s.c2;
@@

foo(es,
- c,
+ c2,
  ...)

julia
