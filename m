From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Tue, 31 Mar 2015 15:15:25 +0200
Subject: [Cocci] Patching nested if's?
In-Reply-To: <CABE47THmL74Gy62cmGE+=V5bF6gqUP4qUPkKLxijcSbbrW4smQ@mail.gmail.com>
References: <CABE47THmL74Gy62cmGE+=V5bF6gqUP4qUPkKLxijcSbbrW4smQ@mail.gmail.com>
Message-ID: <551A9DED.3050604@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> I've been able so far to replace the if (t <MAXR) but this
> also replaces lines with it (expresion < constant) elsewhere.

Would you like to consider any additional SmPL constraints?


> Which is why I'd like to constrain the pacth to this 3 nested
> ifs pattern.

Do you really want to deal only with a specific nesting level?


>        if (
> -       t < M
> +          myfunc()

How do you think about to add also " == 0" here?


>           )
>           {
>       ...
>       } else {
>       ...
>       }

Would you like to replace these ellipsis by metavariables
of the type "statement"?

Regards,
Markus
