Return-Path: <SRS0=LIJV=BY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1011CC433E1
	for <cocci@archiver.kernel.org>; Fri, 14 Aug 2020 14:37:07 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 666C2207DA
	for <cocci@archiver.kernel.org>; Fri, 14 Aug 2020 14:37:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 666C2207DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07EEaerm022165;
	Fri, 14 Aug 2020 16:36:40 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 88C8D7780;
	Fri, 14 Aug 2020 16:36:40 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E5D673C97
 for <cocci@systeme.lip6.fr>; Fri, 14 Aug 2020 16:36:38 +0200 (CEST)
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com
 [209.85.167.66])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07EEaaxt025695
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Fri, 14 Aug 2020 16:36:37 +0200 (CEST)
Received: by mail-lf1-f66.google.com with SMTP id b11so4921603lfe.10
 for <cocci@systeme.lip6.fr>; Fri, 14 Aug 2020 07:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:reply-to:to:cc:references:from:autocrypt:subject
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=NO9eozMTpwGqng8nuxmq3yXenUdC5M4ZNaIM3MPApoc=;
 b=CC1IIiogAjWJPDBT79n5KYlLvwHumH4Wzc6Y+CLR+J4e+fHsskgYmfm3K6+1F+yaZO
 tLrUozQ+/FiYGYdAkCYRjn+t2f/lWU0Nw9zGPALbcXvfeNSw73Qv1MlknH82AtmwA+zi
 bYB9ztXzCYo3oRRXvPmcLVr6ViyfvAuZMh8GQ/dV3kjH+uGNUSEZLGVzD9ttzrXNnFqf
 l6z0lypX20Bz2UBS0FYAPs+un3N1A5/bVYGpKBcVBHDTZiCYiG+sao7E5Ln5ysJ3XXSb
 pR+t2BwOwq9Jix5wJjoJwiQ+RRwPaNtVuh9BnoLG+u6nFOyKG4/iehkW3+UZJW3sH5Hi
 u6KA==
X-Gm-Message-State: AOAM532jeRniRtikr5xasKCXXimeMJ/ixpXLmLss0/sD9AV7iCOIxsSd
 UTxuIQtCTBPxfE3l1hCCxOM=
X-Google-Smtp-Source: ABdhPJwya6daZDg1709UAO+ZeAogK+wDgC0rCR3897JFviZd21xzcqM7b1cyMqFPpBPssXwfYKGtSQ==
X-Received: by 2002:a19:6b0e:: with SMTP id d14mr1370001lfa.103.1597415796370; 
 Fri, 14 Aug 2020 07:36:36 -0700 (PDT)
Received: from [10.68.32.147] (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.gmail.com with ESMTPSA id t12sm1242709lfe.43.2020.08.14.07.36.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 07:36:35 -0700 (PDT)
To: Markus Elfring <Markus.Elfring@web.de>, Coccinelle <cocci@systeme.lip6.fr>
References: <ed9a8046-4c21-e849-f68b-9e08991b701d@web.de>
 <8e76e81f-970b-b1f7-840d-10506dc3311a@linux.com>
 <48ffa436-6e73-88b2-07bc-89942f3c6d8e@web.de>
From: Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Message-ID: <0a9015b6-9037-59c5-31f2-cd2b32c86b50@linux.com>
Date: Fri, 14 Aug 2020 17:36:34 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <48ffa436-6e73-88b2-07bc-89942f3c6d8e@web.de>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Aug 2020 16:36:40 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 14 Aug 2020 16:36:37 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: api: add sprintf() support to
 device_attr_show
X-BeenThere: cocci@systeme.lip6.fr
X-Mailman-Version: 2.1.13
Precedence: list
Reply-To: efremov@linux.com
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

CgpPbiA4LzE0LzIwIDM6MzAgUE0sIE1hcmt1cyBFbGZyaW5nIHdyb3RlOgo+Pj4gWW91IHByb3Bv
c2UgdG8gdXNlIGEgbmVzdGVkIFNtUEwgZGlzanVuY3Rpb24gZm9yIGRlc2lyZWQgYWRqdXN0bWVu
dHMuCj4+PiBJIHN1Z2dlc3QgdG8gc3RhcnQgYSBjb3JyZXNwb25kaW5nIGNhc2UgZGlzdGluY3Rp
b24gYmVoaW5kCj4+PiB0aGUga2V5IHdvcmQg4oCccmV0dXJu4oCdIGluc3RlYWQgb2YgcmVwZWF0
aW5nIGl0IHRocmVlIHRpbWVzLgo+Pgo+PiBJdCBkb2Vzbid0IHdvcmsuCj4gCj4gSG93IGRvIHlv
dSB0aGluayBhYm91dCB0byBhcHBseSBhIFNtUEwgcnVsZSB2YXJpYW50IGxpa2UgdGhlIGZvbGxv
d2luZz8KPiAKPiBAcnAgZGVwZW5kcyBvbiBwYXRjaEAKPiBpZGVudGlmaWVyIHNob3csIGRldiwg
YXR0ciwgYnVmOwo+IGNvbnN0YW50IHN0cjsKPiBAQAo+IAo+IHNzaXplX3Qgc2hvdyhzdHJ1Y3Qg
ZGV2aWNlICpkZXYsIHN0cnVjdCBkZXZpY2VfYXR0cmlidXRlICphdHRyLCBjaGFyICpidWYpCj4g
ewo+IAk8Li4uCj4gCXJldHVybgo+ICgKPiAtCQlzbnByaW50Zgo+ICsJCXNwcmludGYKPiAJCQko
Cj4gCQkJYnVmLAo+IC0JCQlcKFBBR0VfU0laRVx8UEFHRV9TSVpFIC0gMVwpLAo+ICgJCQlzdHIK
PiB8Cj4gKAkJCSIlaSJcfCIlaVxuIlx8IiVsaSJcfCIlbGlcbiJcfCIlbGxpIlx8IiVsbGlcbiJc
fAo+IAkJCSIlZCJcfCIlZFxuIlx8IiVsZCJcfCIlbGRcbiJcfCIlbGxkIlx8IiVsbGRcbiJcfAo+
IAkJCSIldSJcfCIldVxuIlx8IiVsdSJcfCIlbHVcbiJcfCIlbGx1Ilx8IiVsbHVcbiJcfAo+IAkJ
CSIleCJcfCIleFxuIlx8IiVseCJcfCIlbHhcbiJcfCIlbGx4Ilx8IiVsbHhcbiJcfAo+IAkJCSIl
WCJcfCIlWFxuIlx8IiVsWCJcfCIlbFhcbiJcfCIlbGxYIlx8IiVsbFhcbiJcfAo+IAkJCSIweCV4
Ilx8IjB4JXhcbiJcfCIweCVseCJcfCIweCVseFxuIlx8IjB4JWxseCJcfCIweCVsbHhcbiJcfAo+
IAkJCSIweCVYIlx8IjB4JVhcbiJcfCIweCVsWCJcfCIweCVsWFxuIlx8IjB4JWxsWCJcfCIweCVs
bFhcbiJcfAo+IAkJCSIlMDJ4XG4iXHwiJTAzeFxuIlx8IiUwNHhcbiJcfCIlMDh4XG4iXHwKPiAJ
CQkiJTAyWFxuIlx8IiUwM1hcbiJcfCIlMDRYXG4iXHwiJTA4WFxuIlx8Cj4gCQkJIjB4JTAyeFxu
Ilx8IjB4JTAzeFxuIlx8IjB4JTA0eFxuIlx8IjB4JTA4eFxuIlx8Cj4gCQkJIjB4JTAyWFxuIlx8
IjB4JTAzWFxuIlx8IjB4JTA0WFxuIlx8IjB4JTA4WFxuIlx8Cj4gCQkJIiV6ZCJcfCIlemRcbiJc
fCIlenUiXHwiJXp1XG4iXHwiJXp4Ilx8IiV6eFxuIlx8Cj4gCQkJIiVjIlx8IiVjXG4iXHwiJXAi
XHwiJXBcbiJcfCIlcFVcbiJcfCIlcFVsXG4iXHwiJWh1XG4iCj4gKQkJCSwKPiAJCQkuLi4KPiAp
Cj4gCQkJKQo+IHwKPiAtCQlzbnByaW50Zgo+ICsJCXNjbnByaW50Zgo+IAkJCSguLi4pCj4gKTsK
PiAJLi4uPgo+IH0KPiAKCjMgbGV2ZWxzIG9mIG5lc3RlZCBkaXNqdW5jdGlvbnMgbWFrZXMgdGhp
cyBwYXR0ZXJuIGNvbXBsZXRlbHkgdW5yZWFkYWJsZQphbmQgZ2l2ZXMgbm8gY29tcGFyYWJsZSBi
ZW5lZml0cy4gSSBkb24ndCB0aGluayB3ZSBzaG91bGQgY2FyZSBtdWNoIGFib3V0Cm51bWJlciBv
ZiBjaGFyYWN0ZXJzIGluIHRoZSBrZXJuZWwgc291cmNlcywgZ3ppcCB3aWxsIGRvIGEgYmV0dGVy
IGpvYgphbnl3YXkuCgoKVGhhbmtzLApEZW5pcwpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2
LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
