From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Wed, 06 May 2015 09:15:56 +0200
Subject: [Cocci] [PATCH RFC] Coccinelle: Check for return not matching
 function signature
In-Reply-To: <1430820761-28122-1-git-send-email-hofrat@osadl.org>
References: <1430820761-28122-1-git-send-email-hofrat@osadl.org>
Message-ID: <5549BFAC.2010609@users.sourceforge.net>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +virtual context
> +virtual org
> +virtual report

Where do you want to reuse these variables in your SmPL scripts?


> + at match@
> +identifier f,ret;
> +position p;
> +type T1,T2;
> +@@
> +
> +T1 f(...) {
> + T2 ret;

Will it be more helpful to mark only such variable declarations
where the specified data type should be reconsidered
by a minus character or an asterisk (instead of the following
return statement)?

> +<+...
> +* return at p ret
> +;
> +...+>
> +}


Regards,
Markus
