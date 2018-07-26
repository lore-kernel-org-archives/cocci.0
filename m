From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 26 Jul 2018 20:57:58 +0200 (CEST)
Subject: [Cocci] Variable number of macro parameters?
In-Reply-To: <CAOZdJXWJZxjd7-yOCAvcb7=f+2==arPc4VDQjZh=6BQpZqVZpg@mail.gmail.com>
References: <CAOZdJXWJZxjd7-yOCAvcb7=f+2==arPc4VDQjZh=6BQpZqVZpg@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1807262057300.2308@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Thu, 26 Jul 2018, Timur Tabi wrote:

> I'm new to coccinelle and having trouble understanding the syntax.  I
> new to replace calls to one macro with another macro.  So calls that
> look like this:
>
> DBG_PRINTF((x, ...))
>
> should be replaced with
>
> NV_PRINTF(...)
>
> Where ... is any number of variable-separated parameters.  M1 and M2
> are front-ends for printf.  M1 has double parentheses and M2 has only
> one pair.
>
> I came up with this, but it doesn't work because it thinks that 'y' is
> the last parameter only.
>
> @rule1@
> expression x, y;
> @@
> -DBG_PRINTF((x, y));
> +NV_PRINTF(y);

Try expression list y;

julia
