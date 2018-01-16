From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 16 Jan 2018 23:34:14 +0900
Subject: [Cocci] [PATCH] Coccinelle: ifnullfree: Trim the warning
 reported in report mode
In-Reply-To: <1515859095-31824-1-git-send-email-himanshujha199640@gmail.com>
References: <1515859095-31824-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <CAK7LNATQ_7LUkoDwaX73GZF1iMwkCnBq3J5Q8otzMGGLcCZ2jw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2018-01-14 0:58 GMT+09:00 Himanshu Jha <himanshujha199640@gmail.com>:
> Remove the unncessary part of the warning reported, in the report
> mode, so that a single warning produced does not exceed more than line
> and hence improve readability of the warnings produced in the subsequent
> reports to a file.
>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---

Applied to linux-kbuild/misc. Thanks!

-- 
Best Regards
Masahiro Yamada
