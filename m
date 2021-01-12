Return-Path: <SRS0=eIV6=GP=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C913C433DB
	for <cocci@archiver.kernel.org>; Tue, 12 Jan 2021 15:03:56 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A239E23131
	for <cocci@archiver.kernel.org>; Tue, 12 Jan 2021 15:03:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A239E23131
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10CF3RjZ013947;
	Tue, 12 Jan 2021 16:03:27 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6186277B8;
	Tue, 12 Jan 2021 16:03:27 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 045C937BB
 for <cocci@systeme.lip6.fr>; Tue, 12 Jan 2021 16:03:25 +0100 (CET)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com
 [209.85.167.52])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 10CF3OKY019090
 for <cocci@systeme.lip6.fr>; Tue, 12 Jan 2021 16:03:24 +0100 (CET)
Received: by mail-lf1-f52.google.com with SMTP id x20so3772233lfe.12
 for <cocci@systeme.lip6.fr>; Tue, 12 Jan 2021 07:03:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=sV7YmieVsc7v7bJBGuOVBo2wwFqgkTJG2k9OaAAbWOI=;
 b=a0Wvv9UwmtXYTQIffoMEc/A6HHcFr9gPwA7cAF1c7bwY+kz5YCOxjp82+7r58SVGj+
 X7OK25uKXCVmQElQjIDfARqeMj4v82HzzSHwB5luwRbQjMQRityu4v9ULJzb19R3EZOZ
 egv7Noe6y3/+juq7dmAjjAzGLoUtBp2q90AxSk5T+//0Y08+bmPJdreD9xJ4tErc7Djq
 TUgiHNFWMZUy9tsvvYA0nv/bIrpUjK5s76KUi/cSjdHw92RAsEbdC87R5U/+GWdlE4S7
 CZwqW8EHrdS5YeOe0NujPe5ujeoaAmF7ji/sT2FkBf7TIeiYsdaQpCsEiH6Mbb1KVU8o
 KCxw==
X-Gm-Message-State: AOAM530bAAYIm02RGdzRiPQyyXiSwe38fH+FBIfuVsSHmhdVo8bpTQvp
 T9dere3tadoNlW9Q1OEYkeXffS6ttH0Dqw==
X-Google-Smtp-Source: ABdhPJyR9amXEZdyqx+px0fYzde7Ni2o0VU5Vr7nVKdv5QihWLIQ1IJg6+P9C7HzREOUMyiLtmGkQw==
X-Received: by 2002:ac2:51af:: with SMTP id f15mr2477645lfk.592.1610463803969; 
 Tue, 12 Jan 2021 07:03:23 -0800 (PST)
Received: from [10.68.32.192] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id f7sm84816ljk.4.2021.01.12.07.03.23
 for <cocci@systeme.lip6.fr>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Jan 2021 07:03:23 -0800 (PST)
To: Coccinelle <cocci@systeme.lip6.fr>
From: Denis Efremov <efremov@linux.com>
Message-ID: <9bd6a75e-c595-a623-de09-04d261263167@linux.com>
Date: Tue, 12 Jan 2021 18:03:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 12 Jan 2021 16:03:27 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 12 Jan 2021 16:03:24 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] How to match switch cases and their absence with coccinelle?
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

Let's suppose I have this pattern:
@fix exists@
position p;
@@

binder_release_work(...)
{
	...
	switch (...) {
*		case BINDER_WORK_NODE: ... break;@p
	}
	...
}

and I want to match binder_release_work() function in drivers/android/binder.c
file (linux kernel, master)

Seems like the rule is not enough, it gives nothing:
$ spatch --cocci-file binder.cocci drivers/android/binder.c
init_defs_builtins: /usr/lib64/coccinelle/standard.h
HANDLING: drivers/android/binder.c

1) What can I do to reliable check that there is a special case in a switch?
2) Is it possible to check that there is no case handling with something like:
	switch (...) {
		... when != case BINDER_WORK_NODE: ... break;
	}

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
