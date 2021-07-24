Return-Path: <SRS0=JtHN=MQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B126AC4338F
	for <cocci@archiver.kernel.org>; Sat, 24 Jul 2021 14:59:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E96C8608FE
	for <cocci@archiver.kernel.org>; Sat, 24 Jul 2021 14:59:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E96C8608FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 16OExrbD027387;
	Sat, 24 Jul 2021 16:59:53 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2575541F4;
	Sat, 24 Jul 2021 16:59:53 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ADDFD3FE7
 for <cocci@systeme.lip6.fr>; Sat, 24 Jul 2021 16:59:50 +0200 (CEST)
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:332])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 16OExouq005644
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sat, 24 Jul 2021 16:59:50 +0200 (CEST)
Received: by mail-wm1-x332.google.com with SMTP id
 a80-20020a1c98530000b0290245467f26a4so3430397wme.0
 for <cocci@systeme.lip6.fr>; Sat, 24 Jul 2021 07:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=content-transfer-encoding:mime-version:subject:from:in-reply-to
 :date:cc:message-id:references:to;
 bh=6+sye8FdLnT9QwhK5viJd2Xv18gnw+vRYwICI9pzxj0=;
 b=Ik6UO+NWdyDKh4P+8myMye1wv9TyuHxuQQs350f9na0VASLRFehVCsr3adGn4k6c3U
 Va/Qj6CZF+tejfJ7K3v7eCPHugy1kn+LhRBi+80A8n4qUflYvXX7MyQLe+IQKIb5ZT4L
 F9F8x23/8TwibDwpk5GTh8Q+IjEJk/3jCdaXxoPgFLHMXmTb/HJ0vzTsmtXctHuHLa53
 vtAPNroSsirzWRgdvEJtIji+2iQwDS5KQPYZ/Bmvt8S52TMmOpdekPknRR2psZbkUjdj
 awQRFWnpQvZSQFGujrmEZJ00ByKQhQb7WCuLX5jgYqjDg6flb3EIeyB01vIunOkI2m26
 11lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:mime-version:subject
 :from:in-reply-to:date:cc:message-id:references:to;
 bh=6+sye8FdLnT9QwhK5viJd2Xv18gnw+vRYwICI9pzxj0=;
 b=M1DKEKvAVt8TukPDuWyYO/P1nPI7n2XhEHL31dkgUacpgGXdj6iOoeKkscwlSeEjU0
 MGdTLpBnUXYuP3FFKfeJ6yGW72imFhU5qmMr2o+MnfLwgjw0az6lH/xPhlMzmUYl31XF
 LIfbBFs6JllcEC6cexZcGazlDXVyWJTmAz65rKGHJ135keVASMroahG/GtHv9Y7lSmNA
 6GJ/CqZygBKhIk0j81QiP9hsyJueT/q+lVy8ehRAWWOzss0xiaP7FtPXYgdjyRSxBkks
 Olt04y77Lat0q6tjrUnb7rJQZeUEOW/s5zJIuGh53GuUjor0kStenMvy7Bl0m/aujI74
 7ueg==
X-Gm-Message-State: AOAM531mFmQTimkAdFG+NuA9dE0+fCGG4tIrRe59pivpB6iQ8K9h+t6+
 y6FI0IPZ1gUTzRarzozdB/3EzbGqleg=
X-Google-Smtp-Source: ABdhPJwmKTU6JQP7tRjK7Y2aS9gZDOOuRzkc4D6UsQ7cm4JrXCvLR0eoZcVlD2CD/rsBsoomZF9SYw==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr9313628wmj.120.1627138789935; 
 Sat, 24 Jul 2021 07:59:49 -0700 (PDT)
Received: from smtpclient.apple (93-140-138-124.adsl.net.t-com.hr.
 [93.140.138.124])
 by smtp.gmail.com with ESMTPSA id s4sm34419000wmh.41.2021.07.24.07.59.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 24 Jul 2021 07:59:49 -0700 (PDT)
Mime-Version: 1.0 (1.0)
From: =?utf-8?Q?Andrew_=F0=9F=91=BD_Yourtchenko?= <ayourtch@gmail.com>
In-Reply-To: <alpine.DEB.2.22.394.2107232131030.2938@hadrien>
Date: Sat, 24 Jul 2021 16:59:47 +0200
Message-Id: <9022EAE4-A5E0-4309-9454-ADFE763E511B@gmail.com>
References: <alpine.DEB.2.22.394.2107232131030.2938@hadrien>
To: Julia Lawall <julia.lawall@inria.fr>
X-Mailer: iPhone Mail (18G69)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 24 Jul 2021 16:59:54 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sat, 24 Jul 2021 16:59:50 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] how to make substitutions at the end of the function,
	vs. the end of each block ?
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

Cgo+IE9uIDIzIEp1bCAyMDIxLCBhdCAyMTozNSwgSnVsaWEgTGF3YWxsIDxqdWxpYS5sYXdhbGxA
aW5yaWEuZnI+IHdyb3RlOgo+IAo+IO+7vwo+PiAKPj4gSSBtaXNzZWQgdGhlIGZhY3QgdGhhdCB0
aGUgInJldHVybiBFUlIiIHdlcmUgYWN0dWFsbHkgbm90IHJlcGxhY2VkIG9uCj4+IHRoaXMgZXhh
bXBsZSBhdCBhbGwsCj4gCj4gVGhpcyBpcyBiZWNhdXNlIHRoZXJlIGFyZSBubyBvY2N1cnJlbmNl
cyBvZiByZXR1cm4gRVJSOyBpbiB5b3VyIGNvZGUuCj4gUHJvYmFibHkgeW91IGV4cGVjdGVkIEVS
UiB0byBiZSBhIG1ldGF2YXJpYWJsZSwgYnV0IGl0J3Mgbm90LiAgCgpJIGhhZCBpdCBkZWNsYXJl
ZCBhdCBvbmUgcG9pbnQgZGVjbGFyZWQgYXMg4oCcZXhwcmVzc2lvbiBFUlI74oCdLCBzbyB0b3Rh
bCBQRUJDQUsgaGVyZSwgc29ycnkgZm9yIHRoYXQhIPCfmYgKCgo+IEFjdHVhbGx5LAo+IGZ1bGx5
IGNhcGl0YWxpemluZyB5b3VyIG1ldGF2YXJpYWJsZXMgaXMgbm90IGEgZ29vZCBpZGVhLiAgQ29j
Y2luZWxsZQo+IGV4cGVjdHMgdGhhdCBmdWxseSBjYXBpdGFsaXplZCB0aGluZ3MgYXJlIGNvbnN0
YW50cywgYXMgaW4gI2RlZmluZSBFUlIgLTEsCj4gYW5kIHNvIHdoZW4gdGhleSBhcHBlYXIgYXQg
cmFuZG9tIHBsYWNlcywgaXQgZG9lc24ndCBjb21tZW50IGFib3V0IHRoYXQuCj4gSWYgaXQgaGFk
IGJlZW4gaW4gbG93ZXJjYXNlIGFuZCB1c2VkIGFzIHRoZSBhcmd1bWVudCBvZiBhIHJldHVybiAo
b3IgYXMgYQo+IGZ1bmN0aW9uIGFyZ3VtZW50LCByaWdodC1oYW5kIHNpZGUgb2YgYW4gYXNzaWdu
bWVudCwgZXRjKSwgQ29jY2luZWxsZQo+IHdvdWxkIGhhdmUgcHJpbnRlZCBhIHdhcm5pbmcgd29u
ZGVyaW5nIGlmIHlvdSBleHBlY3RlZCBpdCB0byBiZSBhCj4gbWV0YXZhcmlhYmxlLgoKT2gsIHRo
YW5rcyBhIGxvdCBmb3IgdGhlIHRpcCEgCgo+IAo+IElmIEVSUiBpcyBkZWNsYXJlZCBhcyBhbiBl
eHByZXNzaW9uIG1ldGF2YXJpYWJsZSwgdGhlbiBsb3RzIG9mIHJldHVybnMgYXJlCj4gcmVwbGFj
ZWQuCgpFeGNlbGxlbnQsIHRoYW5rcyBhIGxvdCBmb3IgdGhlIGVkdWNhdGlvbiAhIDopCgrigJRh
Cgo+IAo+IGp1bGlhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0
ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
