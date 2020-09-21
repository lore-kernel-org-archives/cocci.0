Return-Path: <SRS0=VzTg=C6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C260C43465
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 17:15:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7AD3720735
	for <cocci@archiver.kernel.org>; Mon, 21 Sep 2020 17:15:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7AD3720735
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LHFTP5024581;
	Mon, 21 Sep 2020 19:15:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 25C06778D;
	Mon, 21 Sep 2020 19:15:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CA0A65F8F
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 19:15:27 +0200 (CEST)
Received: from mail-ej1-f65.google.com (mail-ej1-f65.google.com
 [209.85.218.65])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 08LHFRKx009160
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 19:15:27 +0200 (CEST)
Received: by mail-ej1-f65.google.com with SMTP id p9so18826314ejf.6
 for <cocci@systeme.lip6.fr>; Mon, 21 Sep 2020 10:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:subject:to:cc:references:from
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=rDEk8+qtgaTIgJcXNOfNBGVxcO9yDbgx91NGKXOIH1I=;
 b=gaxIuTQZpZ5Yjphr2cuhkfZjrirQV5X8muqiBrqNPK0rRlPYQPt1GS1evD25g5Dh39
 N90QfmSztwAKdRBCQxGuGWnET10UP43zYrcZBBGLrfWILwWYR3O6kcORFl6moT8xhU9y
 PO5TQWS8UQ5ieOqfHW6hLxP51es3Yxab1FOfxsOUuWaa9bnx/Wx4gkLJwOTiukBfSEuV
 K5TH8YcSo8ZYTgpXXYpW2lfrZVFazrda8YmTh62rj2ctmhG2qpNdLPo7s2aLB6bN/a+Y
 LdW8JD7wIhSYZOy4QIagM1xhnyzCgwRPnX6M9e6PemHn0atCYfJHkIK/NdlFrRp+Pznz
 52OA==
X-Gm-Message-State: AOAM531fbptDeXe2iS5qxA5meBHtAK641gcHmDjwGlNofMUYQ1Sj5qjt
 yGgtqi3uTTeO4kHQMWgJnfQ=
X-Google-Smtp-Source: ABdhPJwhexHNdqaetEprhV4BK2N5GD3vYButvSSBXuXUVq/Woaw13Uqu/Pe4huWmk7vTlYFZiv7neA==
X-Received: by 2002:a17:906:914b:: with SMTP id
 y11mr473315ejw.145.1600708526986; 
 Mon, 21 Sep 2020 10:15:26 -0700 (PDT)
Received: from [10.10.2.174] (winnie.ispras.ru. [83.149.199.91])
 by smtp.gmail.com with ESMTPSA id n26sm9213862ejz.89.2020.09.21.10.15.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2020 10:15:26 -0700 (PDT)
To: Julia Lawall <julia.lawall@inria.fr>
References: <20200605204237.85055-1-efremov@linux.com>
 <20200803183438.34685-1-efremov@linux.com>
From: Denis Efremov <efremov@linux.com>
Message-ID: <d6d3d1de-0394-64ae-bd66-2804e256fa8a@linux.com>
Date: Mon, 21 Sep 2020 20:15:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200803183438.34685-1-efremov@linux.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 19:15:29 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 21 Sep 2020 19:15:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH v7] coccinelle: api: add kfree_mismatch script
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

On 8/3/20 9:34 PM, Denis Efremov wrote:
> Check that alloc and free types of functions match each other.

Julia, I've just send the patches to fix all the warnings emitted by the script.

[1] https://lore.kernel.org/patchwork/patch/1309731/
[2] https://lore.kernel.org/patchwork/patch/1309273/
[3] https://lore.kernel.org/patchwork/patch/1309275/

Other inconsistencies and bugs detected by this script:

1e814d630fd1 drm/amd/display: Use kfree() to free rgb_user in calculate_user_regamma_ramp()
842540075974 drm/amd/display: Use kvfree() to free coeff in build_regamma()
f5e383ac8b58 iommu/pamu: Use kzfree() in fsl_pamu_probe()
360000b26e37 net/mlx5: Use kfree(ft->g) in arfs_create_groups()
114427b8927a drm/panfrost: Use kvfree() to free bo->sgts
742532d11d83 f2fs: use kfree() instead of kvfree() to free superblock data
47a357de2b6b net/mlx5: DR, Fix freeing in dr_create_rc_qp()
a8c73c1a614f io_uring: use kvfree() in io_sqe_buffer_register()
7f89cc07d22a cxgb4: Use kfree() instead kvfree() where appropriate
bb2359f4dbe9 bpf: Change kvfree to kfree in generic_map_lookup_batch()


> Changes in v2:
>  - Lines are limited to 80 characters where possible
>  - Confidence changed from High to Medium because of 
>    fs/btrfs/send.c:1119 false-positive
>  - __vmalloc_area_node() explicitly excluded from analysis
>    instead of !(file in "mm/vmalloc.c") condition
> Changes in v3:
>  - prints style in org && report modes changed for python2
> Changes in v4:
>  - missing msg argument to print_todo fixed
> Changes in v5:
>  - fix position p in kfree rule
>  - move @kok and @v positions in choice rule after the arguments
>  - remove kvmalloc suggestions
> Changes in v6:
>  - more asterisks added in context mode
>  - second @kok added to the choice rule
> Changes in v7:
>  - file renamed to kfree_mismatch.cocci
>  - python function relevant() removed
>  - additional rule for filtering free positions added
>  - btrfs false-positive fixed
>  - confidence level changed to high
>  - kvfree_switch rule added
>  - names for position variables changed to @a (alloc) and @f (free)

Is there something I can improve in this cocci script to be accepted?

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
