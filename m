From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Thu, 16 Nov 2017 09:52:00 +0900
Subject: [Cocci] [PATCH] kbuild: move coccicheck help in
 scripts/Makefile.help to top Makefile
In-Reply-To: <1510652841-6779-1-git-send-email-yamada.masahiro@socionext.com>
References: <1510652841-6779-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <CAK7LNAQp41EVrMqWkyXK0twjDDGoQ787euHrt2pW7Kh3EUNK=w@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2017-11-14 18:47 GMT+09:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> I do not think it is helpful to have a separate file just for the
> coccicheck help message.  Merge scripts/Makefile.help into the
> top-level Makefile.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>

Applied to linux-kbuild/kbuild.

-- 
Best Regards
Masahiro Yamada
