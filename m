Return-Path: <SRS0=qIOj=GO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65DE7C433E0
	for <cocci@archiver.kernel.org>; Mon, 11 Jan 2021 20:06:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E64422CB1
	for <cocci@archiver.kernel.org>; Mon, 11 Jan 2021 20:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E64422CB1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10BK6HK3029870;
	Mon, 11 Jan 2021 21:06:17 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4419977B8;
	Mon, 11 Jan 2021 21:06:17 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7B7AC74B6
 for <cocci@systeme.lip6.fr>; Mon, 11 Jan 2021 21:06:15 +0100 (CET)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com
 [209.85.208.170])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10BK6FPf021580
 for <cocci@systeme.lip6.fr>; Mon, 11 Jan 2021 21:06:15 +0100 (CET)
Received: by mail-lj1-f170.google.com with SMTP id f17so233809ljg.12
 for <cocci@systeme.lip6.fr>; Mon, 11 Jan 2021 12:06:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=tEqCbKvyInYudB1ntu8rKmkiwI+IpFsdCWrD+LJEiKI=;
 b=ZU8Zzgo/V6omHAtGGTvnQzRmYvDINkY9ZtctO94DJxz9qZbpX4kHwG2ekNh1F7g5QC
 P/0RJqcwLlE1Z94h7zrlpygrNWJqHU/4Qa5VRtBookL2Ts2Y4zqO4KeXpJAg+ZnVaAQL
 +D7fMwmw6B/XvMWvMk3yIiNviTCpGiI40Up1VW60fA7AJ7cbMHIH2Cwk96u1XQ/GzU/Q
 4Vwze5uC0SUHqaVdbG4UxZYRa7GgA883r3hHvUQgxkYXH9jiNDQ5GCZpK/6UxUXQEsUS
 WB3cnbgzrpUZYKMa4X/HfibqDbGiIKym+Ci0uEQ3P88HfA61W5SKrkWo9F7DRljLqaom
 aIsw==
X-Gm-Message-State: AOAM533gMfJbma2jKiRWatGQMbdjViN9ZmBCzuqvPFqwtCSctA1psJQo
 E4P7DM2YvU3pVkYynizpQlv331RfZjOo4Q==
X-Google-Smtp-Source: ABdhPJxccL8USHFdMSNpD1++++vHlr9PT/srapqkitlnDmEJdb0oD4oG2lH3tmPKkwHX6K0yoLCXuA==
X-Received: by 2002:a2e:50c:: with SMTP id 12mr499448ljf.226.1610395574231;
 Mon, 11 Jan 2021 12:06:14 -0800 (PST)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id r8sm84683ljp.12.2021.01.11.12.06.13
 for <cocci@systeme.lip6.fr>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Jan 2021 12:06:13 -0800 (PST)
To: Coccinelle <cocci@systeme.lip6.fr>
From: Denis Efremov <efremov@linux.com>
Message-ID: <854fdad7-cf2d-49d8-571c-1ac64fa90fb6@linux.com>
Date: Mon, 11 Jan 2021 23:06:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 11 Jan 2021 21:06:17 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 11 Jan 2021 21:06:15 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] How to match function-like macro calls,
	e.g. RTA_ALIGN(rta->rta_len)?
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

Hi,

Let's suppose I want to match otx_cpt_aead_cbc_aes_sha_setkey() function from
drivers/crypto/marvell/octeontx/otx_cptvf_algs.c file (linux kernel).

My pattern:
@exists@
identifier rta, param, key, keylen;
position p;
@@

otx_cpt_aead_cbc_aes_sha_setkey(...,
	unsigned char *key, unsigned int keylen)
{
	...
*	if (RTA_PAYLOAD(rta) < sizeof(*param))@p
		goto badkey;
	...
*	key += RTA_ALIGN(rta->rta_len);
*	keylen -= RTA_ALIGN(rta->rta_len);
	...
}

$ spatch --no-includes --include-headers --cocci-file test.cocci drivers/crypto/marvell/octeontx/otx_cptvf_algs.c
init_defs_builtins: /usr/lib64/coccinelle/standard.h
minus: parse error: 
  File "test.cocci", line 13, column 9, charpos = 219
  around = 'RTA_ALIGN',
  whole content = *     key += RTA_ALIGN(rta->rta_len);


What can I do to match RTA_ALIGN(...) lines?

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
