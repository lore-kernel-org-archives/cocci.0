Return-Path: <SRS0=TxBn=WB=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C18C9C433FF
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2019 08:36:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E86B92067D
	for <cocci@archiver.kernel.org>; Mon,  5 Aug 2019 08:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linbit-com.20150623.gappssmtp.com header.i=@linbit-com.20150623.gappssmtp.com header.b="BkJQFQY5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E86B92067D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linbit.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x758aTMB000839;
	Mon, 5 Aug 2019 10:36:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 43F2476B2;
	Mon,  5 Aug 2019 10:36:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3D0FC428E
 for <cocci@systeme.lip6.fr>; Mon,  5 Aug 2019 10:36:27 +0200 (CEST)
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:443] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x758aQ9i021085
 for <cocci@systeme.lip6.fr>; Mon, 5 Aug 2019 10:36:26 +0200 (CEST)
Received: by mail-wr1-x443.google.com with SMTP id p17so83475320wrf.11
 for <cocci@systeme.lip6.fr>; Mon, 05 Aug 2019 01:36:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linbit-com.20150623.gappssmtp.com; s=20150623;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=isKSjNaOoRCQvdXtvPmM1Oo2gzorafKc3cqBrs5/sns=;
 b=BkJQFQY59EmRZJRsD/Xfw29vq8ELM29Zn2iwC3CPi+OZUhutkp7XWv7MLHTYEknk9P
 sgCawZS6VxxV/k8Q4iUKg1pin7W3W6IN1/I/mhVE6/kdSpzX873GfLAUlza8nDdGY1yr
 cxzhLZgODcP76PxenZ+qc9dUEcRLcpTc8RTeedkvjEWdnvmWnaoVkkmf0TubvvowOdXR
 7667D3INib8FoKorH8Rg1T2O1WkrSIo7GaJyOUYtpHUXPEF7JBcLmKKY761a9FvZieio
 DQe0+SDFr6UlxcuQd6kqGEgRtKeAgojzDgzpjlI0+kyjlko5WhvgU0PCy2VjLM7M9azL
 p++g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=isKSjNaOoRCQvdXtvPmM1Oo2gzorafKc3cqBrs5/sns=;
 b=gXDaI2n15IbTp7pVoptLau4zlh8lmw6+fxXnYxdHrmn9M82Q8CBYvrxC8YHg4NZYf5
 CwwmqTKD2wsMw+yGJSUUMXTekpAf4ZKgPdzrEgCbdsWEo9558d933NnBi165AZCsy4Lg
 fwYfKVfR9olupCcqhJjxhSxpSdugZQSnn7the80P9bRuhB/7kxkDtYMSnMTU0MzyVjzz
 iEbb4DGXINVaoItltDpnCePTQiCIjuw/71veqjW4iK6wY5t3iFe8zb95LcgAf2RIFdmJ
 1znQqZ64467xuV0CF4tu/raOTybsNHszEFuO7gwAtRHS0nzpVnJq0cjiNP9c8jwSHnYs
 yhvA==
X-Gm-Message-State: APjAAAVHtICPhMmiA7igDt0+MXM0HvekPLVOXeKUTTWFfo+S3rt4uRQh
 57AFpsvcXlh7nlGZJeT54JUy0URaics=
X-Google-Smtp-Source: APXvYqxyig6YLvMrTpa/VHKcaFtpOlxdRHdu+nXyZyPZzRlGm1IlRSNVfnMBY4/Z4x9KRRXYLt/vhA==
X-Received: by 2002:a5d:4cc5:: with SMTP id c5mr106185454wrt.278.1564994186111; 
 Mon, 05 Aug 2019 01:36:26 -0700 (PDT)
Received: from ?IPv6:2001:858:107:1:28f7:ac40:788a:ffa1?
 ([2001:858:107:1:28f7:ac40:788a:ffa1])
 by smtp.gmail.com with ESMTPSA id p18sm86306463wrm.16.2019.08.05.01.36.25
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 05 Aug 2019 01:36:25 -0700 (PDT)
To: Julia Lawall <julia.lawall@lip6.fr>
References: <b4c91fb8-5606-c06e-e349-5415458cf3b5@linbit.com>
 <alpine.DEB.2.21.1908030841460.2547@hadrien>
From: =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
Message-ID: <656aeb1b-9c94-a428-bb0e-4397a0432651@linbit.com>
Date: Mon, 5 Aug 2019 10:36:24 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908030841460.2547@hadrien>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 05 Aug 2019 10:36:29 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 05 Aug 2019 10:36:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Make rule depend on comment
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

VGhhbmtzIGZvciB5b3VyIHJlcGx5IQoKPiBCdXQgaW4geW91ciBjYXNlLCB3b3VsZCBpdCBzdWZm
aWNlIGp1c3QgdG8gcHV0IGFuIGlmIGluIHRoZSBweXRob24gY29kZT8KPiBPciBpcyBpdCBlc3Nl
bnRpYWwgdGhhdCB0aGUgZmlyc3QgcnVsZSBhY3R1YWxseSBub3QgbWF0Y2g/Cj4gCj4ganVsaWEK
SSdtIHByZXR0eSBzdXJlIHRoZSBiZXN0IHdheSB0byBnbyBhYm91dCB0aGlzIGlzIHRvIGhhdmUg
dGhlIHNjcmlwdCBydWxlCmFjdHVhbGx5IG5vdCBtYXRjaC4KQWxsb3cgbWUgdG8gb3V0bGluZSBt
eSByZWFsIHdvcmxkIHVzZS1jYXNlIGZvciB0aGlzOgoKQmFzaWNhbGx5LCB3ZSdyZSBidWlsZGlu
ZyBhIGtlcm5lbCBjb21wYXRpYmlsaXR5IGxheWVyIGJhc2VkIG9uIGNvY2NpbmVsbGUgZm9yCmFu
IG91dC1vZi10cmVlIG1vZHVsZS4KVGhpcyBwYXJ0aWN1bGFyIHNlbWFudGljIHBhdGNoIGNpcmNs
ZXMgYXJvdW5kIHRoZSBrW3VuXW1hcF9hdG9taWMoKSBmdW5jdGlvbnMuClNwZWNpZmljYWxseSwg
c29tZXdoZXJlIGluIHRoZSBrZXJuZWwncyBoaXN0b3J5LCB0aGUgd2F5IHRvIHVzZSB0aGVzZSBm
dW5jdGlvbnMKd2VudCBmcm9tIHRoaXM6CgogICAgdm9pZCAqYWRkciA9IGttYXBfYXRvbWljKHBh
Z2UsIEtNX1VTRVIwKTsKCnRvIHRoaXM6CgogICAgdm9pZCAqYWRkciA9IGttYXBfYXRvbWljKHBh
Z2UpOwoKQXMgd2UncmUgbG9va2luZyB0byBldmVudHVhbGx5IHVwc3RyZWFtIG91ciBtb2R1bGUs
IHdlIG9idmlvdXNseSBjYW5ub3QgaGF2ZSB0aGUKb2xkIEtNXyogY29uc3RhbnRzIGx5aW5nIGFy
b3VuZCBpbiBvdXIgY29kZSwgc28gd2Ugc29tZWhvdyBuZWVkIHRvIHJlc3RvcmUgdGhlCnNlbWFu
dGljIGluZm9ybWF0aW9uIHRoYXQgd2FzIGxvc3QgYnkgcmVtb3ZpbmcgdGhpcyBwYXJhbWV0ZXIu
ClRoZSB3YXkgd2UgZGVjaWRlZCB0byBnbyBhYm91dCB0aGlzIGlzIHRvIGFkZCBhICJ0YWciIHRv
IGVhY2ggZnVuY3Rpb24gY29udGFpbmluZwphIGtbdW5dbWFwX2F0b21pYyBjYWxsOyBpbWFnaW5l
IHRoZSBmb2xsb3dpbmc6CgogICAgaW50IGZvbygpCiAgICAvKiBrbWFwIGNvbXBhdDogS01fVVNF
UjAgKi8KICAgIHsKICAgICAgICB2b2lkICphZGRyID0ga21hcF9hdG9taWMocGFnZSk7CiAgICAg
ICAgLy8gLi4uCiAgICAgICAga3VubWFwX2F0b21pYyhhZGRyKTsKICAgIH0KCkl0IHdvdWxkIG5v
dyBiZSBjb2NjaW5lbGxlcyBqb2IgdG8gbWFrZSBzdXJlIHRoYXQgZWFjaCBrW3VuXW1hcF9hdG9t
aWMgY2FsbCBpcwphdWdtZW50ZWQgYnkgdGhpcyBsZWdhY3kgcGFyYW1ldGVyIChLTV9VU0VSMCBp
biB0aGlzIGNhc2UpLiBIZXJlJ3MgdGhlIHNlbWFudGljCnBhdGNoIEkgY2FtZSB1cCB3aXRoIHRv
IGFjY29tcGxpc2ggdGhpczoKCgogICAgQCBmaW5kX2ttYXBfdGFnZ2VkX2Z1bmN0aW9uIEAKICAg
IGNvbW1lbnRzIHRhZzsKICAgIGlkZW50aWZpZXIgZm47CiAgICBAQAogICAgZm4oLi4uKUB0YWcg
ewogICAgLi4uCiAgICB9CgogICAgQCBzY3JpcHQ6cHl0aG9uIHBhcnNlX2ttYXBfdGFnIEAKICAg
IHRhZyA8PCBmaW5kX2ttYXBfdGFnZ2VkX2Z1bmN0aW9uLnRhZzsKICAgIGttOwogICAgQEAKICAg
IGltcG9ydCByZQogICAgbWF0Y2ggPSByZS5zZWFyY2gocideXC9cKlxza21hcCBjb21wYXQ6ICgu
Kilcc1wqXC8kJywgdGFnWzBdLmFmdGVyKQogICAgaWYgbWF0Y2g6CiAgICAgICAgY29jY2luZWxs
ZS5rbSA9IG1hdGNoLmdyb3VwKDEpCgogICAgQEAKICAgIGV4cHJlc3Npb24gcGFnZSwgYWRkcjsK
ICAgIGlkZW50aWZpZXIgZmluZF9rbWFwX3RhZ2dlZF9mdW5jdGlvbi5mbjsKICAgIGlkZW50aWZp
ZXIgcGFyc2Vfa21hcF90YWcua207CiAgICBAQAogICAgZm4oLi4uKSB7CiAgICA8Li4uCiAgICAo
CiAgICAta21hcF9hdG9taWMocGFnZSkKICAgICtrbWFwX2F0b21pYyhwYWdlLCBrbSkKICAgIHwK
ICAgIC1rdW5tYXBfYXRvbWljKGFkZHIpCiAgICAra3VubWFwX2F0b21pYyhhZGRyLCBrbSkKICAg
ICkKICAgIC4uLj4KICAgIH0KCgpUaGUgZmlyc3QgcnVsZSBmaW5kcyB0aGUgY29tbWVudCBiZXR3
ZWVuIHRoZSBhcmd1bWVudCBsaXN0IGFuZCB0aGUgb3BlbmluZyBjdXJseQpicmFjZSwgdGhlIHNl
Y29uZCBydWxlIHBhcnNlcyBvdXQgdGhlIEtNXyogY29uc3RhbnQgdXNpbmcgYSByZWdleCwgYW5k
IHRoZSB0aGlyZApydWxlIHJlcGxhY2VzIGFsbCBjYWxscyB0byBrW3VuXW1hcF9hdG9taWMgLS0g
aW5zZXJ0aW5nIHRoZSBjb3JyZWN0IHBhcmFtZXRlci4KClRoaXMgd29ya3MganVzdCBmaW5lLCBl
eGNlcHQgZm9yIHRoZSBjYXNlIHdoZXJlIG5vICJ0YWciIHdhcyBmb3VuZC4gVGhlbiBzcGF0Y2gK
cHJvZHVjZXMgb3V0cHV0IGxpa2U6CgoKICAgICBpbnQgZm9vKCkKICAgICB7CiAgICAgICAgICAg
IGludCBwYWdlID0gMTIzNDsKICAgIC0gICAgICAgdm9pZCAqYWRkciA9IGttYXBfYXRvbWljKHBh
Z2UpOwogICAgKyAgICAgICB2b2lkICphZGRyID0ga21hcF9hdG9taWMocGFnZSwKICAgICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGluaXRpYWwgdmFsdWU6IGNvbnNpZGVyIHVzaW5n
IGNvY2NpbmVsbGUudmFybmFtZSk7CiAgICAgICAgICAgIC8vIC4uLgogICAgLSAgICAgICBrdW5t
YXBfYXRvbWljKGFkZHIpOwogICAgKyAgICAgICBrdW5tYXBfYXRvbWljKGFkZHIsIGluaXRpYWwg
dmFsdWU6IGNvbnNpZGVyIHVzaW5nIGNvY2NpbmVsbGUudmFybmFtZSk7CgoKV2hpY2ggc2VlbXMg
dG8gbWUgbGlrZSBpdCB3b3VsZCBjb25mdXNlIHNvbWVvbmUgd2hvIGRvZXNuJ3Qga25vdyBleGFj
dGx5IHdoYXQKcGF0Y2hpbmcgaXMgZG9uZSBiZWhpbmQgdGhlIHNjZW5lcy4KCklkZWFsbHksIEkg
d291bGQgbGlrZSBmb3IgY29jY2luZWxsZSB0byBub3QgdG91Y2ggdGhlIGZ1bmN0aW9uIGF0IGFs
bCBpZiBpdCBkb2Vzbid0CmhhdmUgYSAidGFnIi4gSSdtIG5vdCBzdXJlIGlmIHRoaXMgaXMgb2Jq
ZWN0aXZlbHkgdGhlIGJlc3Qgc29sdXRpb24sIGJ1dCBpdCBzZWVtcwp0aGUgbW9zdCBsb2dpY2Fs
IHRvIG1lLgoKSSdkIGJlIGdsYWQgdG8gaGVhciBhbnkgaW5wdXQgeW91IG1pZ2h0IGhhdmUgcmVn
YXJkaW5nIHRoaXMuCgpBZ2FpbiwgdGhhbmtzIGZvciBhbGwgdGhlIGhlbHAhCgotLQpDaHJpc3Rv
cGggQsO2aG13YWxkZXIKTElOQklUIHwgS2VlcGluZyB0aGUgRGlnaXRhbCBXb3JsZCBSdW5uaW5n
CkRSQkQgSEEg4oCUICBEaXNhc3RlciBSZWNvdmVyeSDigJQgU29mdHdhcmUgZGVmaW5lZCBTdG9y
YWdlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2Np
IG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYu
ZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
