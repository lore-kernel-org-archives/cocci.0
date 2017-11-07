From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 7 Nov 2017 09:18:31 +0900
Subject: [Cocci] [PATCH v2 01/31] coccinelle: Improve setup_timer.cocci
	matching
In-Reply-To: <alpine.DEB.2.20.1709232235500.5987@hadrien>
References: <1505950075-50223-1-git-send-email-keescook@chromium.org>
 <1505950075-50223-2-git-send-email-keescook@chromium.org>
 <alpine.DEB.2.20.1709232235500.5987@hadrien>
Message-ID: <CAK7LNARxWAnuMQ_G_AK1=DWKUTw6qkh8QSqyqDwFrkzjEJQNNQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2017-09-24 5:43 GMT+09:00 Julia Lawall <julia.lawall@lip6.fr>:
>
>
> On Wed, 20 Sep 2017, Kees Cook wrote:
>
>> This improves the patch mode of setup_timer.cocci. Several patterns
>> were missing:
>>  - assignments-before-init_timer() cases
>>  - limit the .data case removal to the specific struct timer_list instance
>>  - handling calls by dereference (timer->field vs timer.field)
>>
>> Cc: Julia Lawall <Julia.Lawall@lip6.fr>
>> Cc: Gilles Muller <Gilles.Muller@lip6.fr>
>> Cc: Nicolas Palix <nicolas.palix@imag.fr>
>> Cc: Michal Marek <mmarek@suse.com>
>> Cc: cocci at systeme.lip6.fr
>> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
>
> Note that I proposed some changes on this rule as well, on August 23
> (https://systeme.lip6.fr/pipermail/cocci/2017-August/004386.html).  My
> changes are still orthogonal to the ones proposed here.
>
> Actually, my changes are in the part about matching, and this patch on
> covers the -D patch case (transformation).  The matching rules should be
> extended in the same way that the patch rules are extended below, but it
> would be better to apply my patch first.
>
> julia
>

Applied to linux-kbuild/misc


-- 
Best Regards
Masahiro Yamada
