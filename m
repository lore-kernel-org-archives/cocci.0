From: julia.lawall@lip6.fr (Julia Lawall)
Date: Sun, 29 Apr 2018 15:29:11 +0200 (CEST)
Subject: [Cocci] a small nuisance report
In-Reply-To: <kkwowq17f3.fsf@bora.foobar.de>
References: <kkwowq17f3.fsf@bora.foobar.de>
Message-ID: <alpine.DEB.2.20.1804291529000.3679@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Sun, 29 Apr 2018, Robert Larice wrote:

> Hello,
>
>   attached is a small example which
>     injects a statement and a comment.
>
>   It works well, but does'nt do exactly as wanted.
>
>   I get :
>
> +    j /* comments are overrated */
> +    -= 3;
>
>   The comment popped up within the expression instead
>     of in front of it.
>   no bug, but uggly.

Indeed, it should not be there.

julia

>
> Regards,
>   Robert
>
>
