Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D718C76195
	for <cocci@archiver.kernel.org>; Fri, 24 Mar 2023 17:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+eiBbPs2SGpkrGMAzRmJfw7VfJ2mVEesg1+9LMIwCTE=;
  b=tGjZKHRnqy5072kz497AsCrjQPp3Frcnl47AcTdPjoDwGJeVD1vDrdno
   C5KF0kUToUY+B1M4F60Ya2hyHxPycBhezuQ8Xafb2V6ZT2lSBS0AzApMw
   qv7y1ujpBuTV6fioMzWdx4OfzQKZYD8iXXmUJ0Bt9vpwZuMVmmePajcSC
   U=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@suse.cz
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="98993709"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 24 Mar 2023 18:30:08 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0D460E0D49; Fri, 24 Mar 2023 18:30:07 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BC908E0D40
	for <cocci@sympa.inria.fr>; Fri, 24 Mar 2023 18:30:04 +0100 (CET)
IronPort-SDR: 641dde1c_2gWwG8uR0LfP5/kYA1i83AC++qm1WPz3gMpZDuAPRCC4hkU
 F5d1V39etlcn+P0w/mMoPMJNWyv3zY9aOPwUP1A==
X-IPAS-Result: =?us-ascii?q?A0HaAADs3B1kmBzch8NaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?U+CLnVVMAQLRoRTkQEuA4Qvk02EAoNUDwEDAQ07CQQBAQMBA4ILgnMChToCH?=
 =?us-ascii?q?QcBBDQTAQIEAQEBAQMCAwEBAQEBAQMBAQUBAQECAQECBAQBAQIQAQEBAQEBA?=
 =?us-ascii?q?QEVCRkFEA4FIoVoDYI3KQF1gQcBAQEBAQEBAQEBAQEBAQEBAQEBARYCDVJ3A?=
 =?us-ascii?q?QEBAQIBIwQLAQ0BATcBBAsJAhQEAgImAgJXBgEMBgIBAYJ6AYI5IwcMlViaT?=
 =?us-ascii?q?ho1en8zgQGCCAEBBoFAAZtsHYFeAwaBFC2NBYM2eicbgUlEgRUnDIJ3PoRZg?=
 =?us-ascii?q?0OCZ4Iqh1aHF4gtCoE0dYEgDoE9gQQCCQIRa4ESCGuBfUECDWQLDm+BSwJkT?=
 =?us-ascii?q?G0rJQQOAxkrHUACAQs7Oj81BgMLIQZYawIJIxETBQMLFSpHBAg5Bho0EQIID?=
 =?us-ascii?q?xIPBiZDDkI3NBMGXAEpCw4RA1CBRwQvgVwGASYkmmsBAQEBglUSAVI7LCAmD?=
 =?us-ascii?q?ieBT5JYkkCKFpQshASEOoc3lQAGDwQulwgOkikuhy2QDyCLQ4FvmkiBeiOBX?=
 =?us-ascii?q?DMaCDCDIk8DGQ+OIBmEAYRsimZDMQI5AgcBCgEBAwmLQwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:QRRCFa3yb4I1rITip/bD5bd1kn2cJEfYwER7XKvMYLTBsI5bp2MFm
 DMXWGiOa6mLZjfweth+Pt/l/B8F6J6ExtNgHQdo3Hw8FHgiRejtVY3IdB+oV8+xBpSeFxw/t
 512hv3odp1coqr0/0/1WlTZhSAgk/vOHNIQMcacUghpXwhoVSw9vhxqnu89k+ZAjMOwa++3k
 YqaT/b3ZRn0i1aYDkpOs/jY8Eg14Kyo0N8llgVWic5j7Ae2e0Y9V8p3yZGZdxPQXoRSF+imc
 OfPpJnRErTxon/Bovv8+lrKWhViroz6ZWBiuVIKM0SWuSWukwRpukoN2FXwXm8M49mBt4gZJ
 NygLvVcQy9xVkHHsLx1vxW1j0iSlECJkVPKCSHXjCCd86HJWzjc4sxBMEMNBs4J3r1JHmhw6
 P8Edy9YO3hvh8ruqF66YvJpmtxmK9T3ZcUEp2ptiz3UZRokacmSHuOTvoIehm1owJoedRrdT
 5JxhT5Hch7JaR5GEkwKE594l/XAanzXLmQB+AjO+fFfD277l1BugIb8DNbuetmNGsBtmHm7/
 VOfxjGsav0dHIfDl2rbqC/EavX0tSj8U4kTPKap8+ZjxlyV3G0aThMMPWZXutGij1KmHtVCN
 xVS4Tc1oO4++SRHU+URQTX7kF+9kSIeYOETAslh1h6E9LfX/1mGUz1soiF6VPQqs8o/RDoP3
 1CPns/0CTEHjIB5WU5x5Z/J9GnjaHN9wXsqNHNVFFNtD8zL+tlr5i8jWOqPB4aZo7XI9dzY2
 DWWtG05mqlKy9UWzKj98V2vb9OQSnrhEFZdCub/BDnNAuZFiGiNO9TABb/zsa4oEWphZgPd1
 EXoYuDHhAz0MbmDlTaWXMIGF6yz6vCOPVX02AAwTsRwqW7woif8JOi8BQ2Swm81Y67onhe1M
 SfuVf55vccJYBNGk4cnC25ONyja5fO8S4S7DK28gitmeYVqeUec+y9yekeK0ij2l0wxjaA4P
 4zTfsu2CH8cGOxoyTC2L9rxIpd1rh3SMVj7HMihpzz+iOL2TCfMGd8tbQXSBshksvLsiFuOq
 b53aZDVoyizpcWjOEE7B6ZJcwBTRZX6bLirw/FqmhmrflU5RTB5VqaLqV7jEqQ895loei7z1
 inVcidlJJDX3BUr8C3aNi4xW6ClRptls3MwMAolOFviiTBpYp+i4O1bP9E7dKUuvr4rh/Nlb
 eg3S+PZCNR2SxPD52s8a7v5p9dcbxiFv1+FEBekRzkdRKReYTL11OXqRSbR0RUfLzGWsJI+q
 oKw1wmATpskQR9jPfnsa/mu7g2Qu14BlMJbQ0GTHIF2Qxj+/LhMLwj0tPsWIt4NGzrH1DC1x
 wabOjZGhOjv8qse0sjFurCAlKitS9BBJ0t9G3XXyZ2UJBvq1DOv7qEYWdnZYA2Hcn3//ZuTQ
 Nl8ztb+AaUhp0lLuY8tKIRb5/syyPW3roAL0zk+OmvAammqLbZSInOm+81rnY8Vz597vTqGY
 G6+yuN4C56oZvy8SEUwITA7ZNutzfsXwznezcokKXXAuRNYwuC1blVwDTKt1gptdKB4IaE08
 9cH4cQ20TGyujAuE9SBjx1XyViyE2w9Y/0Zka8eUaDWiVsN61BdYJbjJDf8z7ORZv5tbEQ7A
 D+mq5DTprZbx0GZTWgBLiXP0Ot8nrULgghBl3UZFmSKm/3Ep/455wJQ+jIJVTZozg1L/uZwG
 2pzPX1OOqSF+gl3iPh5X2yDHx9LADub8BfTz2QluXL4TU7ycEDwN0w4ZPiw+X4G/1JmfjR0+
 K+SzEDnW23IeODzxi4DZl53mcf8TNBe9hzwp+7/Jp6rR6IFWDvChrOiQUEqqBG9WMM4uxDhl
 NlQpe11bfX2CD4Ur6gFELKl7LU3Si7VAExZQPpkwrEFInGERhG2xgq1Ch6QfuFjGqX01HGWW
 u1UCOBBbRCc7Bq1jys6APcMKoBknfRy69slfKjqFFE8sLCej2RItrSJ/XLDmV5wRNRKuuQ+I
 7P3aDitPDGxh3xVummVt+hCGDOyTuclbT3G/tKe0bs2TsoYkedOdUoS7OOFj0+NOlE6wyPO7
 RLxWaDG6sdDl6JuptLIOYdeDVyWLdjTary5wDqruY4TUeKVYNb8jCJLmFzJJA8MAKAwXe5wn
 rGzsNLa+kPJkbI1cmLBkam6CKh7ypSubdVTL/7IAiFWrQmaVO/oxikzyWSyBJhKsdFav8eZH
 lryLIP6cNMOQN5SyUFEcyUUQV5XF63zabymvi+n6eiFDh8GywHcMde77jnTYHpGcjMTcYjLY
 uMuVy1COvgDxGiNOPMFOx2iK4R9PEemXrY6LpvqqCKVSGWl6r9HVn0OijJ4gQwnyFHdeCo53
 X4BbgPjbxn0s7OgIBRxrdlpphNOZJpiqbBYQ6/ekuKaTxihEXULa+8PWXnD5le4jQSqvKzFi
 PrxgKfOxMkzsfmosfkx3Tg7YjqiOw==
IronPort-HdrOrdr: A9a23:ccuAbakNSoD5dQQ9iN+Y+0f6MJnpDfIT3DAbv31ZSRFFG/FwWf
 re+8jzpiWE7Qr5P0tQ4+xoWZPwOk80kKQejLX5Uo3CYOCLghrQEGgm1/qb/9SCIU3DH4xmu5
 uIGpIWYLadYmSSz/yKhjVQeOxQouVvnprY4ds2g00dLj1XVw==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="51182343"
X-MGA-submission: =?us-ascii?q?MDHz35fpsYXcoPk76Gfcvfhmu7t6Gerk2V0jez?=
 =?us-ascii?q?i4bAyIKwzQzay2/0RWeVT7zjspRkZunLS6m34rNpQF7RiWc69MUJ2snf?=
 =?us-ascii?q?Xy3HNBoskQoG9rnp97+ItR8/Dbn2MRu+8EN7+2elotuuB1a86w6HiA3b?=
 =?us-ascii?q?7Tdnx/kC1pVam7Ub0RDsxggg=3D=3D?=
Received: from smtp-out1.suse.de ([195.135.220.28])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Mar 2023 18:30:04 +0100
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 3C84B33B63;
	Fri, 24 Mar 2023 17:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1679679003; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eiBbPs2SGpkrGMAzRmJfw7VfJ2mVEesg1+9LMIwCTE=;
	b=O46wtOse/KmGUQx3zAOgmnpK5rrOILvob0lQT3LYNVP7LUFw5YuoY//8OHIp6KT0MNxCHo
	MYZwqgBqXt6vRaC6aEhRCHHQiHaZza4Y/0Kuf9ukEoN5OYPwHVFcTlGU2ggU02D0FPqGB9
	3gLQ6K+0fi+cQMMx4ZZwx0oQ4qFbSO4=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1679679003;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eiBbPs2SGpkrGMAzRmJfw7VfJ2mVEesg1+9LMIwCTE=;
	b=kZxNL7ERELRnFYwUZ1ebrmvqaNDYDiayXb27qqSoFZGsuJnXQvUdyMeOAvHr1aae7uMsCB
	guhevfdq+HG2fzAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
	(No client certificate requested)
	by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 171F5138ED;
	Fri, 24 Mar 2023 17:30:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
	by imap2.suse-dmz.suse.de with ESMTPSA
	id BiLnBBveHWQ8LQAAMHmgww
	(envelope-from <vbabka@suse.cz>); Fri, 24 Mar 2023 17:30:03 +0000
Message-ID: <22a1ec75-155a-2392-ce39-4bca3fc081eb@suse.cz>
Date: Fri, 24 Mar 2023 18:30:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
To: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
 linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 Kosaki Motohiro <kosaki.motohiro@jp.fujitsu.com>,
 Mel Gorman <mgorman@suse.de>
Cc: cocci@inria.fr, LKML <linux-kernel@vger.kernel.org>
References: <f9303bdc-b1a7-be5e-56c6-dfa8232b8b55@web.de>
 <6e9ca062-939b-af96-c8ff-56ad485d6e79@web.de>
From: Vlastimil Babka <vbabka@suse.cz>
In-Reply-To: <6e9ca062-939b-af96-c8ff-56ad485d6e79@web.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] [PATCH] mm/mempolicy: Fix exception handling in
 shared_policy_replace()
Reply-To: Vlastimil Babka <vbabka@suse.cz>
X-Loop: cocci@inria.fr
X-Sequence: 919
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-03/22a1ec75-155a-2392-ce39-4bca3fc081eb%40suse.cz>

Your patch doesn't apply, seems like it uses spaces instead of tabs. Also I
can't use 'b4' to download it as there are multiple different patches using
the same message-id:

https://lore.kernel.org/all/6e9ca062-939b-af96-c8ff-56ad485d6e79@web.de/

Re: subject, I don't see a bug that this would fix. You could say it's
"cleanup" and this function could use one, but for a cleanup it's not
improving the situation much.

On 3/23/23 18:30, Markus Elfring wrote:
> Date: Thu, 23 Mar 2023 18:18:59 +0100
> 
> The label “err_out” was used to jump to another pointer check despite of
> the detail in the implementation of the function “shared_policy_replace”
> that it was determined already that a corresponding variable contained a
> null pointer because of a failed call of the function “kmem_cache_alloc”.
> 
> 1. Use more appropriate labels instead.
> 
> 2. The implementation of the function “mpol_put” contains a pointer check
>    for its single input parameter.
>    Thus delete a redundant check in the caller.
> 
> 
> This issue was detected by using the Coccinelle software.
> 
> Fixes: 42288fe366c4f1ce7522bc9f27d0bc2a81c55264 ("mm: mempolicy: Convert shared_policy mutex to spinlock")

Again this is not a fix.

> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>  mm/mempolicy.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/mempolicy.c b/mm/mempolicy.c
> index a256a241fd1d..fb0485688dcb 100644
> --- a/mm/mempolicy.c
> +++ b/mm/mempolicy.c
> @@ -2736,13 +2736,12 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
>          sp_insert(sp, new);
>      write_unlock(&sp->lock);
>      ret = 0;
> +put_mpol:
> +    mpol_put(mpol_new);
>  
> -err_out:
> -    if (mpol_new)
> -        mpol_put(mpol_new);
>      if (n_new)
>          kmem_cache_free(sn_cache, n_new);
> -
> +exit:
>      return ret;
>  
>  alloc_new:
> @@ -2750,10 +2749,10 @@ static int shared_policy_replace(struct shared_policy *sp, unsigned long start,
>      ret = -ENOMEM;
>      n_new = kmem_cache_alloc(sn_cache, GFP_KERNEL);
>      if (!n_new)
> -        goto err_out;
> +        goto exit;

Just "return ret" and no need for exit label?

>      mpol_new = kmem_cache_alloc(policy_cache, GFP_KERNEL);
>      if (!mpol_new)
> -        goto err_out;
> +        goto put_mpol;

We are doing this because mpol_new == NULL, so we know there's no reason to
do mpol_put(), we could jump to the freeing of n_new.

>      atomic_set(&mpol_new->refcnt, 1);
>      goto restart;
>  }
> --
> 2.40.0
> 
> 
> 

