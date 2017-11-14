From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 14 Nov 2017 10:49:12 +0100 (CET)
Subject: [Cocci] [PATCH v3] coccinelle: fix parallel build with
 CHECK=scripts/coccicheck
In-Reply-To: <1510650290-3363-1-git-send-email-yamada.masahiro@socionext.com>
References: <1510650290-3363-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <alpine.DEB.2.20.1711141047350.2874@hadrien>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

> +
> +    # If -j option is given to Make, scripts/coccicheck runs in parallel.
> +    # If coccinelle also runs in parallel, it fails because multiple processes
> +    # try to get access to the same subdirectory that stores stdout/stderr.
> +    # No need to parallelize coccinelle in this case - this mode takes only
> +    # one file input.
> +    NPROC=1

Since I am also changing Coccinelle to avoid the problem, maybe it would
be better to just remove the explanation sentence (If coccinelle also runs
in parallel,...).

julia
