Return-Path: <SRS0=Wces=HR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3639C433DB
	for <cocci@archiver.kernel.org>; Mon, 15 Feb 2021 11:24:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EEB601FC
	for <cocci@archiver.kernel.org>; Mon, 15 Feb 2021 11:24:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EEB601FC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11FBOBLQ016844;
	Mon, 15 Feb 2021 12:24:11 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id A496577C0;
	Mon, 15 Feb 2021 12:24:11 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6D49C3B26
 for <cocci@systeme.lip6.fr>; Mon, 15 Feb 2021 12:24:09 +0100 (CET)
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com
 [209.85.167.54])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 11FBO9H4024130
 for <cocci@systeme.lip6.fr>; Mon, 15 Feb 2021 12:24:09 +0100 (CET)
Received: by mail-lf1-f54.google.com with SMTP id w36so9590782lfu.4
 for <cocci@systeme.lip6.fr>; Mon, 15 Feb 2021 03:24:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=BV1QrJft/g6huSE2rysx6WNfZbad17Og1XC/zHGrBv0=;
 b=TRtrXYQ7R4liSCVUIV525+1TrMeBI/KQNTz9tKQcKBco6RNwcCnRp4WlChWOQpMW1U
 5KN5ONsj3QB/Gojp1QQsgRjA3h5JiAo1auetHV0jvpGX4pBm/p48OkcZ3jLb4u265dc/
 DT3lUKe9b3CCs8onwye9KHqZ29k3Od3xz943NPxHlzcxrr2FUhRYfXWQt2gxojyJye0F
 rSIxZzs+ESwAnVuAA5UyRty27xsmgkBQnklYFE9UOR1nquinkxLz/LNfayqaWDsDT8Y+
 dUthGLbhVpUMP0XnNmiujqX+3UtKjNHsvRWC60jtQ6vncJOxUq1GeNjcf8DqUHKdu8Uq
 cRgw==
X-Gm-Message-State: AOAM533t/PsPNnupyfoPXKUAkASkWYt4a/r9D0K96R0rnS8sb0KDxI6J
 xtXMsDlUgdFx+jLPyTlVEIpcnTHQSbaSSA==
X-Google-Smtp-Source: ABdhPJwaPbqxEkrGykXUDbl/jZe24m62MABtDsWOGo0HrCmKK05kvX3g08FUQtaM17lZfiIAP3ew7g==
X-Received: by 2002:ac2:5c42:: with SMTP id s2mr8012594lfp.216.1613388248266; 
 Mon, 15 Feb 2021 03:24:08 -0800 (PST)
Received: from [10.68.32.147] (broadband-188-32-236-56.ip.moscow.rt.ru.
 [188.32.236.56])
 by smtp.gmail.com with ESMTPSA id v11sm2746249lfa.304.2021.02.15.03.24.07
 for <cocci@systeme.lip6.fr>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Feb 2021 03:24:07 -0800 (PST)
To: cocci@systeme.lip6.fr
From: Denis Efremov <efremov@linux.com>
Message-ID: <f3aefcce-4ba1-f49a-c47a-fb6e7a164a19@linux.com>
Date: Mon, 15 Feb 2021 14:24:12 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 15 Feb 2021 12:24:12 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 15 Feb 2021 12:24:09 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Problem with partial patch generation
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

I wrote a simple rule (swap.cocci):

virtual patch

@depends on patch@
identifier tmp;
expression a, b;
type T;
@@

(
- T tmp;
|
- T tmp = 0;
|
- T *tmp = NULL;
)
... when != tmp
- tmp = a;
- a = b;
- b = tmp;
+ swap(a, b);
... when != tmp

I would expect it to remove a local variable only if there is a match
with swap template.

However, it generates "partial" patch on 5.11 linux code:
$ spatch --version
spatch version 1.0.8-00201-g267f9cf8cc82 compiled with OCaml version 4.11.1
$ spatch -D patch --sp-file swap.cocci mm/filemap.c
--- mm/filemap.c
+++ /tmp/cocci-output-445786-88aa66-filemap.c
@@ -2348,7 +2348,7 @@ static int generic_file_buffered_read_ge
        struct file_ra_state *ra = &filp->f_ra;
        pgoff_t index = iocb->ki_pos >> PAGE_SHIFT;
        pgoff_t last_index = (iocb->ki_pos + iter->count + PAGE_SIZE-1) >> PAGE_SHIFT;
-       int i, j, nr_got, err = 0;
+       int i, nr_got, err = 0;
 
        nr = min_t(unsigned long, last_index - index, nr);
 find_page:

How can I improve the rule?

Thanks,
Denis
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
