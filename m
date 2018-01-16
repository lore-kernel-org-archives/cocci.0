From: yamada.masahiro@socionext.com (Masahiro Yamada)
Date: Tue, 16 Jan 2018 23:33:48 +0900
Subject: [Cocci] [PATCH] Coccinelle: alloc_cast: Add more memory
 allocating functions to the list
In-Reply-To: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
References: <1515858990-31699-1-git-send-email-himanshujha199640@gmail.com>
Message-ID: <CAK7LNAQw+sMpH5eRmw06NmhYwBKRZjVUd-+5+TQceniM=gx+qw@mail.gmail.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

2018-01-14 0:56 GMT+09:00 Himanshu Jha <himanshujha199640@gmail.com>:
> Add more memory allocating functions that are frequently used in the kernel
> code to the existing list and remove the useless casts where it is
> unnecessary.
>
> But preserve those casts having __attribute__ such as __force, __iomem,
> etc which are used by Sparse in the static analysis of the code.
>
> Also remove two blank lines at EOF.
>
> Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
> ---
>  scripts/coccinelle/api/alloc/alloc_cast.cocci | 92 +++++++++++++++++++++------
>  1 file changed, 71 insertions(+), 21 deletions(-)


Applied to linux-kbuild/misc. Thanks!


-- 
Best Regards
Masahiro Yamada
