Return-Path: <SRS0=eQR0=CU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25AA4C2BC11
	for <cocci@archiver.kernel.org>; Fri, 11 Sep 2020 16:09:10 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4999F206CA
	for <cocci@archiver.kernel.org>; Fri, 11 Sep 2020 16:09:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4999F206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08BG8g07003069;
	Fri, 11 Sep 2020 18:08:42 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 1DCF4778C;
	Fri, 11 Sep 2020 18:08:42 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0B5605F8F
 for <cocci@systeme.lip6.fr>; Fri, 11 Sep 2020 18:08:41 +0200 (CEST)
Received: from mail-lj1-f195.google.com (mail-lj1-f195.google.com
 [209.85.208.195])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08BG8cSQ008200
 for <cocci@systeme.lip6.fr>; Fri, 11 Sep 2020 18:08:38 +0200 (CEST)
Received: by mail-lj1-f195.google.com with SMTP id a22so12845477ljp.13
 for <cocci@systeme.lip6.fr>; Fri, 11 Sep 2020 09:08:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=AYPCMVE5+4lz80oAd0FTlLTpG9wKp/CHym7+dOireu0=;
 b=M3WB6+bI7rxf6C5A8FvjZ700mson/g/coLUq+A0233GW+AjX6/4w3ZzZMluniIt0Ds
 DK/NNN6qk6H7DSHObQhZ8EGWCE+PrxoK4LKi12P6AuTzEispaKRRBnh2bMqm7u9YAUGt
 rU4JTysgzzN+vjKEfxq9cAme/qSKDNwT7MwxXTvhiGnmdIKv3rBty/6DnO7eAOxbVP9E
 aG0WakA/DhzQYAFhYeAtMsEWmAL2qcDjKpor6YsVVP/ZioRM5P3HoU6EgE5blcLG3jZL
 v5EFZxnrj2hA/fnbTSq37Oei4c3U3LMWDWRMEcWSTFFg4edYD5pcYxE5NPsaJ4mHZnFZ
 MhZw==
X-Gm-Message-State: AOAM5329G5ZE/2hLjQ8Wv8XELpbbs3E/vmlFrPB4GlPogP9D8zgQyp2k
 IQ+wJ4iEl5Ey8jpFH/7wlUk=
X-Google-Smtp-Source: ABdhPJy9TUKQieQHb3KpOZIiSnfsSORdGPxXVixEzQALJjV9d59ZvAUS/Xt/e2U8gXNjtXFoQdT/8Q==
X-Received: by 2002:a2e:9d8a:: with SMTP id c10mr1154536ljj.83.1599840518400; 
 Fri, 11 Sep 2020 09:08:38 -0700 (PDT)
Received: from [10.68.32.147] (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.gmail.com with ESMTPSA id t1sm576862ljt.21.2020.09.11.09.08.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 09:08:37 -0700 (PDT)
To: Alex Dewar <alex.dewar90@gmail.com>, Julia Lawall <Julia.Lawall@lip6.fr>
References: <20200911134956.60910-1-alex.dewar90@gmail.com>
From: Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Message-ID: <1486f777-23d9-19c4-d26d-bba1d8704660@linux.com>
Date: Fri, 11 Sep 2020 19:08:37 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200911134956.60910-1-alex.dewar90@gmail.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 11 Sep 2020 18:08:42 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 11 Sep 2020 18:08:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: kzfree.cocci: Deprecate use of kzfree
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
Reply-To: efremov@linux.com
List-Id: <cocci.systeme.lip6.fr>
List-Unsubscribe: <https://systeme.lip6.fr/mailman/options/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=unsubscribe>
List-Archive: <https://systeme.lip6.fr/pipermail/cocci>
List-Post: <mailto:cocci@systeme.lip6.fr>
List-Help: <mailto:cocci-request@systeme.lip6.fr?subject=help>
List-Subscribe: <https://systeme.lip6.fr/mailman/listinfo/cocci>,
 <mailto:cocci-request@systeme.lip6.fr?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Hi,

same patch
https://lkml.org/lkml/2020/8/11/130

Julia, I've send all the patches to fix existing kfree_sensitive/kvfree_sensitive reports.

https://lkml.org/lkml/2020/8/27/168
https://lkml.org/lkml/2020/8/27/93

Thanks,
Denis

On 9/11/20 4:49 PM, Alex Dewar wrote:
> kzfree() is effectively deprecated as of commit 453431a54934 ("mm,
> treewide: rename kzfree() to kfree_sensitive()"). It is currently just a
> legacy alias for kfree_sensitive(), which achieves the same thing.
> 
> Update kzfree.cocci accordingly:
> 1) Replace instances of kzfree with kfree_sensitive
> 2) Merge different rules for memset/memset_explicit as kzfree and
>    kfree_sensitive are now equivalent
> 3) Rename script to kfree_sensitive.cocci
> 
> In addition:
> 4) Move the script to the free/ subfolder, where it would seem to fit
>    better
> 
> Signed-off-by: Alex Dewar <alex.dewar90@gmail.com>
> ---
>  .../kfree_sensitive.cocci}                    | 38 +++++--------------
>  1 file changed, 10 insertions(+), 28 deletions(-)
>  rename scripts/coccinelle/{api/kzfree.cocci => free/kfree_sensitive.cocci} (59%)
> 
> diff --git a/scripts/coccinelle/api/kzfree.cocci b/scripts/coccinelle/free/kfree_sensitive.cocci
> similarity index 59%
> rename from scripts/coccinelle/api/kzfree.cocci
> rename to scripts/coccinelle/free/kfree_sensitive.cocci
> index 33625bd7cec9..a87f93f2ed5c 100644
> --- a/scripts/coccinelle/api/kzfree.cocci
> +++ b/scripts/coccinelle/free/kfree_sensitive.cocci
> @@ -1,13 +1,13 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  ///
> -/// Use kzfree, kvfree_sensitive rather than memset or
> -/// memzero_explicit followed by kfree
> +/// Use k{,v}free_sensitive rather than memset or memzero_explicit followed by
> +/// k{,v}free
>  ///
>  // Confidence: High
>  // Copyright: (C) 2020 Denis Efremov ISPRAS
>  // Options: --no-includes --include-headers
>  //
> -// Keywords: kzfree, kvfree_sensitive
> +// Keywords: kfree_sensitive, kvfree_sensitive
>  //
>  
>  virtual context
> @@ -18,7 +18,7 @@ virtual report
>  @initialize:python@
>  @@
>  # kmalloc_oob_in_memset uses memset to explicitly trigger out-of-bounds access
> -filter = frozenset(['kmalloc_oob_in_memset', 'kzfree', 'kvfree_sensitive'])
> +filter = frozenset(['kmalloc_oob_in_memset', 'kfree_sensitive', 'kvfree_sensitive'])
>  
>  def relevant(p):
>      return not (filter & {el.current_element for el in p})
> @@ -53,34 +53,16 @@ position m != cond.ok;
>  type T;
>  @@
>  
> +(
>  - memzero_explicit@m((T)E, size);
> -  ... when != E
> -      when strict
> -// TODO: uncomment when kfree_sensitive will be merged.
> -// Only this case is commented out because developers
> -// may not like patches like this since kzfree uses memset
> -// internally (not memzero_explicit).
> -//(
> -//- kfree(E)@p;
> -//+ kfree_sensitive(E);
> -//|
> -- \(vfree\|kvfree\)(E)@p;
> -+ kvfree_sensitive(E, size);
> -//)
> -
> -@rp_memset depends on patch@
> -expression E, size;
> -position p : script:python() { relevant(p) };
> -position m != cond.ok;
> -type T;
> -@@
> -
> +|
>  - memset@m((T)E, 0, size);
> +)
>    ... when != E
>        when strict
>  (
>  - kfree(E)@p;
> -+ kzfree(E);
> ++ kfree_sensitive(E);
>  |
>  - \(vfree\|kvfree\)(E)@p;
>  + kvfree_sensitive(E, size);
> @@ -91,11 +73,11 @@ p << r.p;
>  @@
>  
>  coccilib.report.print_report(p[0],
> -  "WARNING: opportunity for kzfree/kvfree_sensitive")
> +  "WARNING: opportunity for k{,v}free_sensitive")
>  
>  @script:python depends on org@
>  p << r.p;
>  @@
>  
>  coccilib.org.print_todo(p[0],
> -  "WARNING: opportunity for kzfree/kvfree_sensitive")
> +  "WARNING: opportunity for k{,v}free_sensitive")
> 
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
