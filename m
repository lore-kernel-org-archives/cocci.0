From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 16 Nov 2017 09:03:49 +0900
Subject: [Cocci] [PATCH v2] coccinelle: orplus: reorganize to improve
	performance
In-Reply-To: <alpine.DEB.2.20.1711130649370.2483@hadrien>
References: <alpine.DEB.2.20.1711130649370.2483@hadrien>
Message-ID: <CAK7LNAQN_ZHM=sOHo263GojEoTha2OuoyobwGAevTG9wUS5JRQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2017-11-13 14:53 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
> Adding two #define constants is less common than performing & and |
> operations on them, so put the addition first to reduce the set of cases
> that have to be considered in detail.  At the same time, add & and |
> patterns for both arguments of +, to account for commutativity and obtain
> more results.
>
> Running time is divided by 3 when applying this to the whole kernel on my
> laptop with an Intel i5-6200U CPU.
>
> Signed-off-by: Julia Lawall <julia.lawall@lip6.fr>
>
> ---
>
> v2: added SOB and fixed typos in the commit message


Applied to linux-kbuild/misc.  Thanks!



-- 
Best Regards
Masahiro Yamada
