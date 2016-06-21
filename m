From: julia.lawall@lip6.fr (Julia Lawall)
Date: Tue, 21 Jun 2016 22:29:53 +0200 (CEST)
Subject: [Cocci] [PATCH v3 5/8] scripts: add Linux .cocciconfig for
	coccinelle
In-Reply-To: <1466536893-23355-6-git-send-email-mcgrof@kernel.org>
References: <1466536893-23355-1-git-send-email-mcgrof@kernel.org>
 <1466536893-23355-6-git-send-email-mcgrof@kernel.org>
Message-ID: <alpine.DEB.2.02.1606212227200.2040@localhost6.localdomain6>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On Tue, 21 Jun 2016, Luis R. Rodriguez wrote:

> Help Coccinelle when used against Linux with a set of sensible defaults
> options for Linux. This hints to coccinelle git can be used for 'git grep'
> queries over coccigrep. A timeout of 200 seconds should suffice for now.
> 
> If you use idutils you can override for 'make coccicheck' by using the
> SPFLAGS option as follows:
> 
> First build the index, for example:
> mkid -s

Coccinelle provides a script for this: scripts/idutils_index.sh.  This 
script contains:

mkid -i C --output .id-utils.index

Then the Coccinelle flag --use-idutils will find the index, without having 
to specify the name.  Coccinelle searches for the index in the directory 
on which it is working, so it is not necessary to specify an absolute 
path.

julia

> Pick the cocci file you wnat to work with:
> export COCCI=scripts/coccinelle/misc/irqf_oneshot.cocci
> 
> Then run coccicheck:
> $ make coccicheck V=1 MODE=report SPFLAGS="--use-idutils ID"
> 
> Coccinelle supports reading .cocciconfig from different directories,
> the later one overriding the previous reads in the following order:
> 
>  o Your current user's home directory is processed first
>  o Your directory from which spatch is called is processed next
>  o The directory provided with the --dir option is processed last, if used
> 
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  .cocciconfig | 3 +++
>  .gitignore   | 1 +
>  2 files changed, 4 insertions(+)
>  create mode 100644 .cocciconfig
> 
> diff --git a/.cocciconfig b/.cocciconfig
> new file mode 100644
> index 000000000000..43967c6b2015
> --- /dev/null
> +++ b/.cocciconfig
> @@ -0,0 +1,3 @@
> +[spatch]
> +	options = --timeout 200
> +	options = --use-gitgrep
> diff --git a/.gitignore b/.gitignore
> index 2be25f771bd8..c2ed4ecb0acd 100644
> --- a/.gitignore
> +++ b/.gitignore
> @@ -67,6 +67,7 @@ Module.symvers
>  #
>  !.gitignore
>  !.mailmap
> +!.cocciconfig
>  
>  #
>  # Generated include files
> -- 
> 2.8.2
> 
> 
