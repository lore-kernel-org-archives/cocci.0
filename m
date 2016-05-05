From: julia.lawall@lip6.fr (Julia Lawall)
Date: Thu, 5 May 2016 08:26:42 +0200 (CEST)
Subject: [Cocci] [RFC 1/2] pycocci: add missing new line
In-Reply-To: <1462426254-22633-2-git-send-email-mcgrof@kernel.org>
References: <1462426254-22633-1-git-send-email-mcgrof@kernel.org>
 <1462426254-22633-2-git-send-email-mcgrof@kernel.org>
Message-ID: <alpine.DEB.2.02.1605050826160.2031@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr


On Wed, 4 May 2016, Luis R. Rodriguez wrote:

> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>

Acked-by: Julia Lawall <julia.lawall@lip6.fr>

> ---
>  tools/pycocci | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tools/pycocci b/tools/pycocci
> index 266957bd90cd..43bb9a4dd412 100755
> --- a/tools/pycocci
> +++ b/tools/pycocci
> @@ -608,7 +608,7 @@ def _main():
>          cmd = [ '--stat', patch_branch_name + ".." + smpl_branch_name ]
>          diff_stat = git_diff(tree=args.target_dir, extra_args = cmd)
>          if len(diff_stat) == 0:
> -            logwrite('\nSmPL patch fully replaces patch series!')
> +            logwrite('\nSmPL patch fully replaces patch series!\n')
>          else:
>              logwrite('\nDifferences found:\n\n')
>              logwrite('Change directory to %s and run:\n\n\tgit diff %s..%s\n\n' % (args.target_dir, patch_branch_name, smpl_branch_name))
> -- 
> 2.7.2
> 
> _______________________________________________
> Cocci mailing list
> Cocci at systeme.lip6.fr
> https://systeme.lip6.fr/mailman/listinfo/cocci
> 
