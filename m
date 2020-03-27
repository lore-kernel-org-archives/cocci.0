Return-Path: <SRS0=pejK=5M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD3BEC43331
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 15:43:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2180020658
	for <cocci@archiver.kernel.org>; Fri, 27 Mar 2020 15:43:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="sR5Nr5S8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2180020658
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02RFh1LU007138;
	Fri, 27 Mar 2020 16:43:01 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CB4917812;
	Fri, 27 Mar 2020 16:43:01 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1416E780C
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 16:43:00 +0100 (CET)
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:336])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02RFgxQ3009306
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 16:42:59 +0100 (CET)
Received: by mail-wm1-x336.google.com with SMTP id z18so11892224wmk.2
 for <cocci@systeme.lip6.fr>; Fri, 27 Mar 2020 08:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=QUUg73tAhWpjFqOqmLpmUJmMDtjqvPPeViK2rXPM2B0=;
 b=sR5Nr5S8wdbIItMu6zYUjhBKihLLuwZiFha+YNXNxbJJJgSTZYyymYq/CeZH70VG6K
 AG2hAFW5dBgl56wonI1S9gxwVSFUieOeZUKgFaTzelN4M+dPfD7ghSk92IPLdcbPOdua
 JEib9QIMXjZFNllwIRvcDFbIQeLQZhbGn5adUa0FSKevuTRr10VqmXaTouaS3k74rov4
 bw02Pxp49Zj97aEi4m2gVzUv+3+B6HX3WhuTr2ACS2mjWitY9UwTHl2GDh3Rgh8JLaJ8
 lVS7bSbyZUCk/tWtpyiBTXVq+pFwY626PzlTKQyUi36UZQKbVb4Nu7hdXI3mrEpzipqN
 nJ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=QUUg73tAhWpjFqOqmLpmUJmMDtjqvPPeViK2rXPM2B0=;
 b=QM/9OEQjgcjJfGb6+UE4b9mPPGB/7qdRm7YYDrFRJ3YgrmdGpyRAuQc1izQjBoQGtL
 hzca0+Spx7AuPTMAkOQ3hPBH6AHRQRJ8eQXYmJKFn9TuQRNzVhiDMCv0HpZ0E/c+uhAv
 jh0fHZVk7YYeRCUT/SKXMj5TX+54jNwsa6JuVbzT5KDP4Einbaywvdjca8dAPK65CY2Z
 GEwUax+PaGz47Yhm75RV0HAZmDvV8eG1Zz/NLlLWEaEMbW+tS0V/KhXAsEcWuWLdds6J
 rbDqv9tqvGvC1fRtb4xGGbgRGlgJ1rfrTFOSPqjrwdTRcHT6xVQVk8EqAyPPYU+XOw4V
 damw==
X-Gm-Message-State: ANhLgQ3/mrBmrEyAE0IASAfs+pzqvMAytsWgwrSGg1pEBHS/K88jQ7F/
 nCImDYBhChpXJ74Egi8HkyDhHidZcjk=
X-Google-Smtp-Source: ADFU+vuktFw4WJrWFavIKdgwRl96WZSfkb24e+e7BVumEeACxqiX9mY+B7FPaqQxErY99tomQELVrQ==
X-Received: by 2002:a1c:6385:: with SMTP id x127mr5785277wmb.141.1585323778973; 
 Fri, 27 Mar 2020 08:42:58 -0700 (PDT)
Received: from localhost.localdomain (80-110-214-17.static.upcbusiness.at.
 [80.110.214.17])
 by smtp.gmail.com with ESMTPSA id m11sm8705605wmf.9.2020.03.27.08.42.58
 for <cocci@systeme.lip6.fr>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Mar 2020 08:42:58 -0700 (PDT)
To: Coccinelle <cocci@systeme.lip6.fr>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <b86347f3-69d3-0801-c91f-87c3424e71dc@linbit.com>
Date: Fri, 27 Mar 2020 16:42:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 27 Mar 2020 16:43:02 +0100 (CET)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 27 Mar 2020 16:42:59 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Matching against a declarer macro
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

SGkgYWdhaW4sCgpJJ20gaGF2aW5nIGEgbGl0dGxlIHRyb3VibGUgbWF0Y2hpbmcgYWdhaW5zdCB0
aGlzIGxpbmUgb2YgY29kZToKClJCX0RFQ0xBUkVfQ0FMTEJBQ0tTX01BWChzdGF0aWMsIGF1Z21l
bnRfY2FsbGJhY2tzLCBzdHJ1Y3QgCmRyYmRfaW50ZXJ2YWwsIHJiLCBzZWN0b3JfdCwgZW5kLCBO
T0RFX0VORCk7CgpUaGlzIGlzIGVzcGVjaWFsbHkgdHJpY2t5IGJlY2F1c2UgaXQgY29udGFpbnMg
YSBsb3Qgb2YgbWFjcm8gbWFnaWMuCkkgdGhpbmsgdGhlIGJpZ2dlc3QgcHJvYmxlbSBpcyB0aGUg
Zmlyc3QgYXJndW1lbnQsIHdoaWNoIGlzIHRoZSBrZXl3b3JkIAoic3RhdGljIi4gV2hhdCBkbyBJ
IHVzZSB0byBtYXRjaCBhZ2FpbnN0IHRoaXM/IGV4cHJlc3Npb24/IGlkZW50aWZpZXI/IApzeW1i
b2w/CgpBbHNvLCB0aGUgImF1Z21lbnRfY2FsbGJhY2tzIiBpcyBub3QgcmVhbGx5IGFuIGlkZW50
aWZpZXIgZWl0aGVyLCBpdCAKanVzdCBnZXRzIHVzZWQgdG8gZ2VuZXJhdGUgdGhlIGZ1bmN0aW9u
IG5hbWVzLiBCdXQgd2hhdCBpcyBpdD8gQW4gCmV4cHJlc3Npb24/CgpAQAp0eXBlZGVmIHNlY3Rv
cl90OwpkZWNsYXJlciBuYW1lIFJCX0RFQ0xBUkVfQ0FMTEJBQ0tTX01BWDsKCmlkZW50aWZpZXIg
YXVnbWVudF9jYWxsYmFja3M7CmlkZW50aWZpZXIgcmI7CmlkZW50aWZpZXIgZW5kOwppZGVudGlm
aWVyIE5PREVfRU5EOwpAQAotUkJfREVDTEFSRV9DQUxMQkFDS1NfTUFYKHN0YXRpYywgYXVnbWVu
dF9jYWxsYmFja3MsIHN0cnVjdCAKZHJiZF9pbnRlcnZhbCwgcmIsIHNlY3Rvcl90LCBlbmQsIE5P
REVfRU5EKTsKCk5vdGhpbmcgSSBoYXZlIHRyaWVkIGhhcyBtYWRlIGl0IG1hdGNoIHlldC4KCkFu
eSBpZGVhcyBvbiBob3cgdG8gc29sdmUgdGhpcyB3b3VsZCBiZSBhcHByZWNpYXRlZCwgdGhhbmtz
IQoKLS0KQ2hyaXN0b3BoIELDtmhtd2FsZGVyCkxJTkJJVCB8IEtlZXBpbmcgdGhlIERpZ2l0YWwg
V29ybGQgUnVubmluZwpEUkJEIEhBIOKAlCDCoERpc2FzdGVyIFJlY292ZXJ5IOKAlCBTb2Z0d2Fy
ZSBkZWZpbmVkIFN0b3JhZ2UKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczov
L3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
