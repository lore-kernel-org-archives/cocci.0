From: timur@kernel.org (Timur Tabi)
Date: Thu, 26 Jul 2018 14:43:53 -0500
Subject: [Cocci] Variable number of macro parameters?
In-Reply-To: <alpine.DEB.2.20.1807262138050.2308@hadrien>
References: <CAOZdJXWJZxjd7-yOCAvcb7=f+2==arPc4VDQjZh=6BQpZqVZpg@mail.gmail.com>
 <alpine.DEB.2.20.1807262057300.2308@hadrien>
 <8910efc5-eaf2-93d6-a148-c7b06f336dcd@tabi.org>
 <alpine.DEB.2.20.1807262138050.2308@hadrien>
Message-ID: <CAOZdJXVzxhwyP5LycuFC1waDXXBdn0YWvZ4sDjvUi9Y=y2E0xA@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Thu, Jul 26, 2018 at 2:38 PM, Julia Lawall <julia.lawall@lip6.fr> wrote:
> OK, I don't think that the notion of double parentheses is fully
> supported.  It works with the following:
>
> @@
> @@
> DBG_PRINTF(
> -(
>   ...
> - )
>  );
>
>
> @rule1@
> expression x;
> expression list y;
> @@
> -DBG_PRINTF(x, y);
> +NV_PRINTF(y);

This works, thanks.
