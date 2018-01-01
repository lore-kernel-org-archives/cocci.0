From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Mon, 1 Jan 2018 18:19:32 +0900
Subject: [Cocci] [RESEND PATCH 1/1] Coccinelle: array_size: report even
 if include is missing
In-Reply-To: <20171229181423.23263-1-jeremy.lefaure@lse.epita.fr>
References: <20171229181423.23263-1-jeremy.lefaure@lse.epita.fr>
Message-ID: <CAK7LNAR6jAEgiGEQd+wuZng-MhXgbhuALuRTQpAGoMEP-bGxJQ@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2017-12-30 3:14 GMT+09:00 J?r?my Lefaure <jeremy.lefaure@lse.epita.fr>:
> Rule r does not depend on rule i (which is the include of
> linux/kernel.h) so the output should not depend on i in
> org and report mode.
>
> Signed-off-by: J?r?my Lefaure <jeremy.lefaure@lse.epita.fr>
> Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> ---


Applied to linux-kbuild/misc.  Thanks!



-- 
Best Regards
Masahiro Yamada
