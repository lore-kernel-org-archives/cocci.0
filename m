From: julia.lawall@lip6.fr (Julia Lawall)
Date: Mon, 1 Jan 2018 10:36:14 +0100 (CET)
Subject: [Cocci] [RESEND PATCH 1/1] Coccinelle: array_size: report even
 if include is missing
In-Reply-To: <CAK7LNAR6jAEgiGEQd+wuZng-MhXgbhuALuRTQpAGoMEP-bGxJQ@mail.gmail.com>
References: <20171229181423.23263-1-jeremy.lefaure@lse.epita.fr>
 <CAK7LNAR6jAEgiGEQd+wuZng-MhXgbhuALuRTQpAGoMEP-bGxJQ@mail.gmail.com>
Message-ID: <alpine.DEB.2.20.1801011036010.2700@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr



On Mon, 1 Jan 2018, Masahiro Yamada wrote:

> 2017-12-30 3:14 GMT+09:00 J?r?my Lefaure <jeremy.lefaure@lse.epita.fr>:
> > Rule r does not depend on rule i (which is the include of
> > linux/kernel.h) so the output should not depend on i in
> > org and report mode.
> >
> > Signed-off-by: J?r?my Lefaure <jeremy.lefaure@lse.epita.fr>
> > Acked-by: Julia Lawall <julia.lawall@lip6.fr>
> > ---
>
>
> Applied to linux-kbuild/misc.  Thanks!

Thanks, and happy new year!

julia
