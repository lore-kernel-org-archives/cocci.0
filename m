From: mmarek@suse.com (Michal Marek)
Date: Tue, 26 Jul 2016 22:50:05 +0200
Subject: [Cocci] [PATCH] Coccinelle: Script to replace allocate and
 memcpy with zalloc functions
In-Reply-To: <20160723210034.GA19346@amitoj-Inspiron-3542>
References: <20160723210034.GA19346@amitoj-Inspiron-3542>
Message-ID: <5797CCFD.7020707@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

Dne 23.7.2016 v 23:00 Amitoj Kaur Chawla napsal(a):
> This script finds instances of allocate and memcpy which can be
> replaced with a direct call to zalloc equivalent of a function.
> 
> Signed-off-by: Amitoj Kaur Chawla <amitoj1606@gmail.com>
> ---
>  scripts/coccinelle/api/zalloc.cocci | 556 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 556 insertions(+)
>  create mode 100644 scripts/coccinelle/api/zalloc.cocci
> 
> diff --git a/scripts/coccinelle/api/zalloc.cocci b/scripts/coccinelle/api/zalloc.cocci
> new file mode 100644
> index 0000000..4f94e43
> --- /dev/null
> +++ b/scripts/coccinelle/api/zalloc.cocci
> @@ -0,0 +1,556 @@
> +/// Prefer zalloc functions instead of using allocate and memcpy.

s/memcpy/memset/ ? The actual spatch names the correct function.

Michal
