Return-Path: <SRS0=tDau=5O=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34310C43331
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 11:50:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A05E920675
	for <cocci@archiver.kernel.org>; Sun, 29 Mar 2020 11:50:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="c6POc2Qx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A05E920675
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02TBoOTU012579;
	Sun, 29 Mar 2020 13:50:24 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 822837750;
	Sun, 29 Mar 2020 13:50:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CEE1F66CB
 for <cocci@systeme.lip6.fr>; Sun, 29 Mar 2020 13:50:22 +0200 (CEST)
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:32e])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02TBoMQI010703
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Sun, 29 Mar 2020 13:50:22 +0200 (CEST)
Received: by mail-wm1-x32e.google.com with SMTP id f74so7005130wmf.0
 for <cocci@systeme.lip6.fr>; Sun, 29 Mar 2020 04:50:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=0R9tSLgWME3W9/rhYJHZwtXgrMPaikcJHBlMVhxCcaI=;
 b=c6POc2QxZ9h0yKcJdf0msGetIDFJ4bdIqTs43yJ2sftLIOkHwx30/nkwwn0OML1nyK
 2KO2l151/nR0ba5ZFtJsviX3JXfC0GgbKG7WUV2nZQCXxhMT+eNP5PRTwc5qPntfgLk1
 Nk5YlfwViU6s/gZcaF/I5O2YOX2OCb5WdYak0XPbxaN/jdOnAwMu86E+F1+sZT7pdmpW
 yZ/BPSdkHB3JmIRWwSFL7YhJFNyAyok0/RgNJL8mTrH08XcIe+MTFSKIL+ukC4sNKfmh
 iM2ohjcaDAoMJrA7vn21P4/5moZ0/0uRexKBs0Lzu7QOSOGKMKqfRQH0IIJUyaEpag0I
 wHlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=0R9tSLgWME3W9/rhYJHZwtXgrMPaikcJHBlMVhxCcaI=;
 b=fQ+K1+Km8KuxHiv1HC+POZfV4g+w4yz6Swp/ho5X4VwU3yxU1hUQq4cHRrAYLpdQ6R
 AJMCTk8XJXVFSjHrAzIN9hix9KupXmdSKnPRBgC67LfdldOa7ITpRJBwr051FtZB3MVK
 IASO7TgeLTrO1ruoS4FW3ixZJVSQ2uULevOpkeMj7ZWOFsJ6bCMNSCZCLyRvBsaMBya+
 HGe0YR+o54Kx3VJUJ/kzHO2C72btP0lKHbLPvM74TgleiofDYZ1IfEL0xs80lfqaIFfn
 OyHWD91v/iN+7iCPOpvpR3F7ATLZJPXwrN+HxxLVVM0intTaZYrovzlZG42lDcwV1eEL
 od7w==
X-Gm-Message-State: ANhLgQ0BrwmoENxJK0YqJurfH7ufz0P5HgGvq5MiNUrXUj0VNjlRtntJ
 wNooCAAFS6ngyfLf/dXkhgcUoSAv3KQ=
X-Google-Smtp-Source: ADFU+vuQIGrzTkgRmVXHMO/47RHXEfOUo5XSaj2g3tpljfKH7ASoOdEXuqfJbe3MXXLAO8Uyhv5pug==
X-Received: by 2002:a1c:4987:: with SMTP id w129mr8573307wma.168.1585482621820; 
 Sun, 29 Mar 2020 04:50:21 -0700 (PDT)
Received: from localhost.localdomain ([94.136.13.132])
 by smtp.gmail.com with ESMTPSA id a82sm20691889wmh.0.2020.03.29.04.50.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 29 Mar 2020 04:50:21 -0700 (PDT)
To: Julia Lawall <julia.lawall@inria.fr>
References: <b86347f3-69d3-0801-c91f-87c3424e71dc@linbit.com>
 <alpine.DEB.2.21.2003271645370.2709@hadrien>
 <1f1a7b29-b767-551c-e2ec-d5cdf5ceecd0@linbit.com>
 <alpine.DEB.2.21.2003271714150.2709@hadrien>
 <2a36722e-c5ff-aa94-fac1-d885b89176d0@linbit.com>
 <alpine.DEB.2.21.2003291118410.2990@hadrien>
 <0d87349e-f919-562e-eeea-fe6b09f44462@linbit.com>
 <alpine.DEB.2.21.2003291322190.2990@hadrien>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <7c61f198-a302-e711-31f9-00b6aed7483b@linbit.com>
Date: Sun, 29 Mar 2020 13:50:20 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2003291322190.2990@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 29 Mar 2020 13:50:24 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Sun, 29 Mar 2020 13:50:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Matching against a declarer macro
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

QW0gMjkuMDMuMjAgdW0gMTM6MjQgc2NocmllYiBKdWxpYSBMYXdhbGw6Cj4gRXZlcnl0aGluZyB3
b3VsZCBiZSBmaW5lIGlmIHRoZSAic3RhdGljIiB3ZXJlIG5vdCB0aGVyZS4KPiAKPiBNYXliZSB5
b3UgY291bGQgdXNlIHNlZCB0byByZXBsYWNlIChzdGF0aWMgYnkgKFNUQVRJQyBpbiB5b3VyIGNv
ZGUgYmFzZSwKPiB0aGVuIHJ1biB5b3VyIHNjcmlwdCwgYW5kIHRoZW4gdXNlIHNlZCB0byBnbyB0
aGUgb3RoZXIgd2F5Li4uCgpUaGUgcHJvYmxlbSBpcyB0aGF0IHRoZSBzY3JpcHRzIEknbSB3cml0
aW5nIGhlcmUgYXJlIGNhbGxlZCAKYXV0b21hdGljYWxseSBhcyBwYXJ0IG9mIHRoZSBidWlsZCBw
cm9jZXNzLCBpdCdzIG5vdCBqdXN0IGEgb25lLXNob3QgCnJlcGxhY2VtZW50LgoKRldJVywgdGhp
cyBjYW4gbm90IGJlIHBhcnNlZCBlaXRoZXI6CgpSQl9ERUNMQVJFX0NBTExCQUNLU19NQVgoU1RB
VElDLCBhdWdtZW50X2NhbGxiYWNrcywgc3RydWN0IApkcmJkX2ludGVydmFsLCByYiwgc2VjdG9y
X3QsIGVuZCwgTk9ERV9FTkQpOwoKQnV0IHRoaXMgY2FuOgoKUkJfREVDTEFSRV9DQUxMQkFDS1Nf
TUFYKF9TVEFUSUMsIGF1Z21lbnRfY2FsbGJhY2tzLCBzdHJ1Y3QgCmRyYmRfaW50ZXJ2YWwsIHJi
LCBzZWN0b3JfdCwgZW5kLCBOT0RFX0VORCk7CgoKTWF5YmUgaXQgd291bGQgYmUgcG9zc2libGUg
dG8gIiNkZWZpbmUgX1NUQVRJQyBzdGF0aWMiIGZvciB0aGlzIGNhc2UgLS0gCnNwYXRjaCBoYW5k
bGVzIHRoYXQganVzdCBmaW5lLgoKPiBJIGRvbid0IGtub3cgaWYgaXQgY291bGQgYmUgcG9zc2li
bGUgdG8gYWxsb3cgc3RhdGljIGluIGFyZ3VtZW50IGxpc3RzLgoKVGhhdCB3b3VsZCBiZSBhbWF6
aW5nIGlmIGl0J3MgZWFzaWx5IHBvc3NpYmxlLiBJZiBub3QsIEkgZ3Vlc3Mgd2UgY2FuIApwcm9i
YWJseSBqdXN0IGxpdmUgd2l0aCB0aGUgd29ya2Fyb3VuZC4KCj4gCj4ganVsaWEKPiAKVGhhbmtz
IHlldCBhZ2FpbiBmb3IgYWxsIHlvdXIgaGVscC4KCi0tCkNocmlzdG9waCBCw7ZobXdhbGRlcgpM
SU5CSVQgfCBLZWVwaW5nIHRoZSBEaWdpdGFsIFdvcmxkIFJ1bm5pbmcKRFJCRCBIQSDigJQgIERp
c2FzdGVyIFJlY292ZXJ5IOKAlCBTb2Z0d2FyZSBkZWZpbmVkIFN0b3JhZ2UKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNv
Y2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3Rp
bmZvL2NvY2NpCg==
