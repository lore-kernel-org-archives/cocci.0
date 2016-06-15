From: mmarek@suse.com (Michal Marek)
Date: Wed, 15 Jun 2016 09:51:31 +0200
Subject: [Cocci] [PATCH 3/4] coccicheck: enable use of the kernel's
	python library
In-Reply-To: <1465942217-14452-4-git-send-email-mcgrof@kernel.org>
References: <1465942217-14452-1-git-send-email-mcgrof@kernel.org>
 <1465942217-14452-4-git-send-email-mcgrof@kernel.org>
Message-ID: <57610903.9040706@suse.com>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 2016-06-15 00:10, Luis R. Rodriguez wrote:
> Signed-off-by: Luis R. Rodriguez <mcgrof@kernel.org>
> ---
>  scripts/coccicheck | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/coccicheck b/scripts/coccicheck
> index ba7301ab0a3d..a4d91d649ad9 100755
> --- a/scripts/coccicheck
> +++ b/scripts/coccicheck
> @@ -12,6 +12,8 @@
>  
>  DIR=$(dirname $(readlink -f $0))
>  DIR="${DIR}/../"
> +export PYTHONPATH=${DIR}/scripts/

The first assignment to DIR already sets the desired path.

Michal
