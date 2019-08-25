Return-Path: <SRS0=RP4p=WV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,PLING_QUERY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11809C3A5A1
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 21:19:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8668A20679
	for <cocci@archiver.kernel.org>; Sun, 25 Aug 2019 21:19:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8668A20679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PLJdMb027252;
	Sun, 25 Aug 2019 23:19:39 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0429876C5;
	Sun, 25 Aug 2019 23:19:39 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 74A757694
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 23:19:36 +0200 (CEST)
Received: from mail-lj1-f196.google.com (mail-lj1-f196.google.com
 [209.85.208.196])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7PLJaFl021322
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 23:19:36 +0200 (CEST)
Received: by mail-lj1-f196.google.com with SMTP id m24so13232011ljg.8
 for <cocci@systeme.lip6.fr>; Sun, 25 Aug 2019 14:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:cc:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XAGbIDdFga1X2HlsM3DdDuO+5VUileKxN3AsXn36/xY=;
 b=ebnBd/ueqxtuimj4DNWsRh+oMQkXBSOeGWPsomWGqXR/usIwP41GDKpVmOhF0IqMFF
 X81Xb2kkfFnhkt5HOoAmQ8vMWDsPE+jfW4/BzDLd35kXqpMdehOXg8eoqpErXeTutery
 izn3ENnds7oxWiTt61EMiLfBpYfVQxt6lSAjf3D+R/fuAWmVF90of9nKbCnVLYb/kYCe
 BCJnat2BHdsruBxiDHhrYY8LN2Uwe+wB3QLOharHJa2iSv5sHK8bh7Pnokz3Hg2N7kbl
 iArpKkvfg1DdYX3Q0dhZGR9lKX7MGQw8+Iwc/yY8e0Z3+OxfAt0UJMuXthB+Q1s/KZ86
 Tkzw==
X-Gm-Message-State: APjAAAU6aPgiEomcKoIDRcMMgd/5wkVyfBeE8+siiU8X4utPbyfPANRJ
 qjvPh8180zc0f0BhZnaYnP8=
X-Google-Smtp-Source: APXvYqy8P4V6TzHzyfGdKLQHZ8Clh8NRX1pSFmfp2r760J2XBalgrBjfT6OhBC7Fdns2DUts2xzEQQ==
X-Received: by 2002:a2e:875a:: with SMTP id q26mr8656162ljj.107.1566767975775; 
 Sun, 25 Aug 2019 14:19:35 -0700 (PDT)
Received: from [10.68.32.192] (broadband-188-32-48-208.ip.moscow.rt.ru.
 [188.32.48.208])
 by smtp.gmail.com with ESMTPSA id f28sm1516386lfp.28.2019.08.25.14.19.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 25 Aug 2019 14:19:35 -0700 (PDT)
From: Denis Efremov <efremov@linux.com>
To: Joe Perches <joe@perches.com>, cocci@systeme.lip6.fr
References: <20190825130536.14683-1-efremov@linux.com>
 <b5bae2981e27d133b61d99b08ee60244bf7aabe3.camel@perches.com>
 <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
Message-ID: <25032fea-bda4-a491-def3-05bb5f569875@linux.com>
Date: Mon, 26 Aug 2019 00:19:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <88f6e48e-1230-9488-a973-397f4e6dfbb5@linux.com>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 23:19:39 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 25 Aug 2019 23:19:36 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] scripts: coccinelle: check for !(un)?likely
	usage
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
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

> I think it's incorrect to say so in general. For example, on x86/64:
> 
> $ make mrproper
> $ make allyesconfig
> $ make && mv vmlinux vmlinux-000
> $ make coccicheck MODE=patch COCCI=scripts/coccinelle/misc/unlikely.cocci | patch -p1
> $ make 
> $ ./scripts/bloat-o-meter ./vmlinux-000 ./vmlinux
> add/remove: 0/0 grow/shrink: 3/4 up/down: 41/-35 (6)
> Function                                     old     new   delta
> dpaa2_io_service_rearm                       357     382     +25
> intel_pmu_hw_config                         1277    1285      +8
> get_sigframe.isra.constprop                 1657    1665      +8
> csum_partial_copy_from_user                  605     603      -2
> wait_consider_task                          3807    3797     -10
> __acct_update_integrals                      384     373     -11
> pipe_to_sendpage                             459     447     -12
> Total: Before=312759461, After=312759467, chg +0.00%
> 
> It definitely influence the way the compiler optimizes the code.  

Small addition:

Results with allyesconfig and KCOV, KASAN, KUBSAN, FTRACE, TRACE_BRANCH_PROFILING,
PROFILE_ALL_BRANCHES disabled:
./scripts/bloat-o-meter ./vmlinux-000 ./vmlinux
add/remove: 0/0 grow/shrink: 2/3 up/down: 22/-22 (0)
Function                                     old     new   delta
i40e_xmit_xdp_ring                           457     477     +20
__acct_update_integrals                      127     129      +2
csum_partial_copy_from_user                  208     207      -1
dpaa2_io_service_rearm                       180     177      -3
wait_consider_task                          1338    1320     -18

For defconfig:
./scripts/bloat-o-meter ./vmlinux-000 ./vmlinux 
add/remove: 0/0 grow/shrink: 3/1 up/down: 16/-5 (11)
Function                                     old     new   delta
do_signal                                   1513    1521      +8
wait_consider_task                          2151    2157      +6
__acct_update_integrals                      127     129      +2
csum_partial_copy_from_user                  223     218      -5

Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
