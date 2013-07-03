From: mmarek@suse.cz (Michal Marek)
Date: Wed, 03 Jul 2013 15:36:52 +0200
Subject: [Cocci] [PATCH 3/3] Coccinelle: Update the options used to the
 new option scheme
In-Reply-To: <1371726656-24928-2-git-send-email-nicolas.palix@imag.fr>
References: <1371726656-24928-1-git-send-email-nicolas.palix@imag.fr>
 <1371726656-24928-2-git-send-email-nicolas.palix@imag.fr>
Message-ID: <51D428F4.6020003@suse.cz>
To: cocci@systeme.lip6.fr
List-Id: cocci@systeme.lip6.fr

On 20.6.2013 13:10, Nicolas Palix wrote:
> spatch has changed its option scheme.
> E.g., --no_show_diff is now --no-show-diff
> 
> This patch updates:
>  - scripts/coccicheck
>  - Semantic patches under scripts/coccinelle/

Will the new syntax work with older spatch versions? I mean, it's
probably fair to require a recent version, but it should be documented IMO.

Also, there was no patch 2/3 in this series, only 1/3 and 3/3.

Thanks,
Michal
