Return-Path: <SRS0=lKqB=5J=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7447AC43331
	for <cocci@archiver.kernel.org>; Tue, 24 Mar 2020 18:21:32 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1267C20714
	for <cocci@archiver.kernel.org>; Tue, 24 Mar 2020 18:21:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iyhktkum"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1267C20714
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=chromium.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02OIL8Jv014015;
	Tue, 24 Mar 2020 19:21:08 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9728477FC;
	Tue, 24 Mar 2020 19:21:08 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9D8453B63
 for <cocci@systeme.lip6.fr>; Tue, 24 Mar 2020 19:20:59 +0100 (CET)
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:642])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02OIKv2b001723
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Tue, 24 Mar 2020 19:20:58 +0100 (CET)
Received: by mail-pl1-x642.google.com with SMTP id m1so7744606pll.6
 for <cocci@systeme.lip6.fr>; Tue, 24 Mar 2020 11:20:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=pT25UnZw8GM7Hd21OQrxHvPDWru16NnMVVxodL4fKVA=;
 b=iyhktkumgD/jnOyy/wrt8dXzir+rVbxsCaX0F1NIU968y/5PKrYcKlaC+EUgsXxoD1
 qRnZuBoGJVEq/iPtymBbiQq/d0t+3o76Vg7pmHHpXjJtM7UuE+MA3iFeocbUrYXAjiQM
 Z6sejDHA46aOnvzsmPK6WvTcsSKcktL/hzcag=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=pT25UnZw8GM7Hd21OQrxHvPDWru16NnMVVxodL4fKVA=;
 b=eOgjpQAdhPloCnH2+N9Q/0yspYWGZvdsAnB7aGQMhF7CZYhkxMleLeCTCmYWnFF0Ym
 X2/22GU+CHcfmNFEsu4+Rl40/6R1jUjVdYMOFSJxQsJw5yzQwNZP/bfoeKBm9DaUQPrJ
 PC23qGLe2ujwy/0l/PcPHW9wirwQaFeNtc4xJrNhiIzRp8dMvEbGMl6jHrCHcX61kCWl
 83MFDIGUjDk06+n02J/gY6X374XtkBN6/tBNhxKP2s0uYEUuEWUtFVwc5V2RLmXuAstO
 5hVfUEZnYiIwjGE9AcUH/R+gYrCCkiTD98+d4MAG/GS3iZ/vpJtElFOrQ+EEdyvr2G5Q
 rqxQ==
X-Gm-Message-State: ANhLgQ1W3u+L+L4ALDsw8XdSY4NHa/Abwy2UcuwNnq1I5RbAY/TzqHHO
 RjOs+BY3Q1UiQs/3DR2wvHtdMg==
X-Google-Smtp-Source: ADFU+vsbUZvpEd+JNrfXu3SDrVaKk1GB6LCcXwZqBJNz0+KcmuSLdw3UClszpGNl3JJHmzGTOgzQXQ==
X-Received: by 2002:a17:90a:3349:: with SMTP id
 m67mr6643283pjb.175.1585074057290; 
 Tue, 24 Mar 2020 11:20:57 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id w31sm15114250pgl.84.2020.03.24.11.20.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2020 11:20:56 -0700 (PDT)
Date: Tue, 24 Mar 2020 11:20:55 -0700
From: Kees Cook <keescook@chromium.org>
To: "Guilherme G. Piccoli" <gpiccoli@canonical.com>
Message-ID: <202003241119.A666E1C694@keescook>
References: <20200323214618.28429-1-gpiccoli@canonical.com>
 <b73a6519-0529-e36f-fac5-e4b638ceb3cf@suse.cz>
 <eee335a2-e673-39bf-ae64-e49c66f74255@canonical.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <eee335a2-e673-39bf-ae64-e49c66f74255@canonical.com>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Mar 2020 19:21:09 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Tue, 24 Mar 2020 19:20:59 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: randy Dunlap <rdunlap@infradead.org>, linux-doc@vger.kernel.org,
        penguin-kernel@I-love.SAKURA.ne.jp, linux-api@vger.kernel.org,
        kernel@gpiccoli.net, linux-kernel@vger.kernel.org,
        cocci@systeme.lip6.fr, linux-fsdevel@vger.kernel.org,
        tglx@linutronix.de, yzaikin@google.com, akpm@linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [Cocci] [PATCH V2] kernel/hung_task.c: Introduce sysctl to
 print all traces when a hung task is detected
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

On Tue, Mar 24, 2020 at 09:45:40AM -0300, Guilherme G. Piccoli wrote:
> Thanks Randy and Vlastimil for the comments. I really liked your
> approach Vlastimil, I agree that we have no reason to not have a generic
> sysctl setting via cmdline mechanism - I'll rework this patch removing
> the kernel parameter (same for other patch I just submitted).

I've been thinking we'll likely want to have a big patch series that
removes all the old "duplicate" boot params and adds some kind of
"alias" mechanism.

Vlastimil, have you happened to keep a list of other "redundant" boot
params you've noticed in the kernel? I bet there are a lot. :)

-- 
Kees Cook
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
