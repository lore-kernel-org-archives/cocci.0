Return-Path: <SRS0=oKUP=V6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792DBC32750
	for <cocci@archiver.kernel.org>; Fri,  2 Aug 2019 07:34:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C29A320665
	for <cocci@archiver.kernel.org>; Fri,  2 Aug 2019 07:34:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="bIjS39WO"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C29A320665
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x727YODJ014104;
	Fri, 2 Aug 2019 09:34:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 93E267788;
	Fri,  2 Aug 2019 09:34:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E424761F1
 for <cocci@systeme.lip6.fr>; Fri,  2 Aug 2019 09:34:22 +0200 (CEST)
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:433] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x727YMQp019932
 for <cocci@systeme.lip6.fr>; Fri, 2 Aug 2019 09:34:22 +0200 (CEST)
Received: by mail-wr1-x433.google.com with SMTP id p13so1546705wru.10
 for <cocci@systeme.lip6.fr>; Fri, 02 Aug 2019 00:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=ShP51cKuW6C2vQ0J3tNPkiMG2Nqe0wECO6rfY7Z6t2U=;
 b=bIjS39WOqU7gJ3uDs4YzDzNmBDqEYTRLgfgpwvvTIQFj3QA1TL9JbOIpEkou1IkICG
 dct9jEdoSTnTSoxDmwpaMK4x2ccbaVH8qVmNIDHEm4ADA5o+cpg16DevnqRQmBpoEFwv
 QFPAYdJKrQLYQ3EQiQ3CVLrAkkRa9AbsIOCSPZHUDtCfVr6Y6+WqTz0W004nN8+5SktF
 x5R20pzKdeSEaGIQ/c5M/6v/7gxziw4zr9Ia1krgVm2qgljkVtenb45Ylvb0DdLGTTWh
 GnsDuRwWNt2dvd8UYOP53zx6ywi+SvrS+AmhNOIc6cUN2JmLvH4padYY2ITynb3V8mGS
 Yrig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:to:from:subject:message-id:date:user-agent
 :mime-version:content-language:content-transfer-encoding;
 bh=ShP51cKuW6C2vQ0J3tNPkiMG2Nqe0wECO6rfY7Z6t2U=;
 b=ZwEf5ffdNJne5y5PNyZL67O2Zrk/AIyxbpbJQY4xNBQN3zW/c6RPUxba3u7rrSfBMc
 hi0uGzvuZ46Z4kWJINHNSTmRTTTzySVJpAVSC9TGLdk3LosEdYkDTd+px/dZvc9vAlni
 NjGIe9XOK9PJVLW7Zlz87Zx8pyr4dM09IEc863c0Id5T99Q/I+YCJdKaUkRPIAwlGS5W
 oDu8+EXlZ9vMSZV+WWVRyycF3UyNr86K1zF/XhUGNF8bkJGFX/FQGUuhbgB4H5qRVqZi
 OxtmlcoOvauG9fdWiMZzFOsURfSMQY6Z9ZinfrfchwbadXOO33vS4e3Pq/LaHst5sX4L
 vKCg==
X-Gm-Message-State: APjAAAX/1dvKDlA1qOoODj8FILtivIInwbW2qf0zziOyB0AQq++O50iK
 adH0M98F940HBP+BSOWcvR/G1aUmlUg=
X-Google-Smtp-Source: APXvYqzTI5wxzrtML8ITX1LxbSfxbbzKRrYBbhcWJQIiWhmTLMadbZ6nFQrJKYyrLj9wBxNuaSECAg==
X-Received: by 2002:adf:efc8:: with SMTP id i8mr89296798wrp.220.1564731261569; 
 Fri, 02 Aug 2019 00:34:21 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:71b2:7b23:68a6:3aa3?
 ([2001:858:107:1:71b2:7b23:68a6:3aa3])
 by smtp.gmail.com with ESMTPSA id y2sm63930939wrl.4.2019.08.02.00.34.20
 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 02 Aug 2019 00:34:20 -0700 (PDT)
To: cocci@systeme.lip6.fr
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <b4c91fb8-5606-c06e-e349-5415458cf3b5@linbit.com>
Date: Fri, 2 Aug 2019 09:34:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 02 Aug 2019 09:34:25 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Fri, 02 Aug 2019 09:34:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] Make rule depend on comment
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

SGksCgpJIGhhdmUgYSBxdWVzdGlvbiByZWdhcmRpbmcgdGhlIG5ldyAiY29tbWVudHMiIGZlYXR1
cmUuIFN1cHBvc2UgdGhlIGZvbGxvd2luZzoKCnRlc3QuY29jY2kKLS0tLS0tLS0tLQpAIHIgQApp
ZGVudGlmaWVyIGZuOwpjb21tZW50cyBjOwpAQApmbigpQGMKewp9CgpAIHNjcmlwdDpweXRob24g
QApmbiA8PCByLmZuOwpjIDw8IHIuYzsKQEAKcHJpbnQoZm4gKyAiIGhhcyBjb21tZW50OiAiICsg
Y1swXS5hZnRlcikKCgp0ZXN0LmMKLS0tLS0tCmludCBmKCkgLyogYSBjb21tZW50ICovIHsgfQpp
bnQgZygpIHsgfQoKCnNwYXRjaCAtLXNwLWZpbGUgdGVzdC5jb2NjaSB0ZXN0LmMKLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpmIGhhcyBjb21tZW50OiAvKiBhIGNvbW1lbnQgKi8K
ZyBoYXMgY29tbWVudDoKCgpUaGUgaXNzdWUgaGVyZSBpcyB0aGF0IEkgd291bGQgbGlrZSB0byB0
cmlnZ2VyIHRoZSBweXRob24gc2NyaXB0CihpLmUuIHNhdGlzZnkgdGhlICJyIiBydWxlKSBpZmYg
dGhlIGNvbW1lbnQgaXMgYWN0dWFsbHkgcHJlc2VudC4KQ2FuIEkgbWFrZSB0aGUgcnVsZSBkZXBl
bmQgb24gdGhlIGNvbW1lbnQgYmVpbmcgdGhlcmU/CgpUaGFua3MsCgotLQpDaHJpc3RvcGggQsO2
aG13YWxkZXIKTElOQklUIHwgS2VlcGluZyB0aGUgRGlnaXRhbCBXb3JsZCBSdW5uaW5nCkRSQkQg
SEEg4oCUICBEaXNhc3RlciBSZWNvdmVyeSDigJQgU29mdHdhcmUgZGVmaW5lZCBTdG9yYWdlCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxp
bmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFp
bG1hbi9saXN0aW5mby9jb2NjaQo=
