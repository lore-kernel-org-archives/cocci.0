Return-Path: <SRS0=z9nG=EQ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E47C4742C
	for <cocci@archiver.kernel.org>; Tue, 10 Nov 2020 14:04:21 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70710207E8
	for <cocci@archiver.kernel.org>; Tue, 10 Nov 2020 14:04:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Di+p8tHp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70710207E8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AAE3u1s002464;
	Tue, 10 Nov 2020 15:03:56 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8746B74CE;
	Tue, 10 Nov 2020 15:03:56 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 28984454B
 for <cocci@systeme.lip6.fr>; Tue, 10 Nov 2020 14:12:34 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0AADCXsN027987
 for <cocci@systeme.lip6.fr>; Tue, 10 Nov 2020 14:12:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605013952;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2V11rFQ3FKVTN+koXAVvig/bkOvKVZoOl9jWSSiZ8Ik=;
 b=Di+p8tHpuaV5rtMlatp24D6j8+WKmCUBtqz8yv0zCEdrS6sGXtBKp/ajiNQKnRgk1iVbBf
 EPgPhQ0oDcmNLweqKLA2uf1G287zKEdUoDcJ+SAJtNZ7ElvnOQlZ77m+OxtwtGg6hoPAvK
 H8JUZjK8UjW7EnlIU91t9XZBpHRi/X8=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-iVaqILZxMJ64NFFqwhtldA-1; Tue, 10 Nov 2020 08:12:30 -0500
X-MC-Unique: iVaqILZxMJ64NFFqwhtldA-1
Received: by mail-qk1-f197.google.com with SMTP id s9so3071667qks.2
 for <cocci@systeme.lip6.fr>; Tue, 10 Nov 2020 05:12:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=2V11rFQ3FKVTN+koXAVvig/bkOvKVZoOl9jWSSiZ8Ik=;
 b=m1vt4FJoA+kSq3cmqBEEY5FYjGRJArc2djTADop0JfJ8d1MYdL6DI7k/x53UbKpIve
 LQUIobeo/UQrjifUELXBSVGLRPFKoL2Itm+UiX+DnFIGeYLCM7hrV1K2FkrOtKi5FZoE
 ZMiL7HWeygkSOredaf74NwMKSS2Qzhm0PLqT3Gtf7uRQLbJJr4qQhAWENWdKDIJzv7Vi
 20gJ50YK+2y5ISRekx7SnlOu1xCggf/FwJJeSN1zvie2oZ6wtwDZf521gTQ6qGyeu9R7
 ifhh6hqncCjC6Or7dbYOjiAxIi1h3T0oSFm/9/u/WGtEWngLQNOAr3OxC5pyZZmL5p86
 5SoA==
X-Gm-Message-State: AOAM531MCbEcB28RAgUtZrMIz8oMw1dKBjESQXRwmuflle0BGF7fypOc
 Orl40KmrAEEjR9oXovNinpYSUMSelXl33plhuCx4ieOxt2h2mWbnbE3PeK4ZGc1BC6OOaVAvfYF
 pXzjGJ6xLp4opaFQ=
X-Received: by 2002:ac8:3621:: with SMTP id m30mr8787103qtb.168.1605013950454; 
 Tue, 10 Nov 2020 05:12:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyRnI1rUF5eW2rST1vImtIogpOlMRBum2fO0dVCe+zUlRqVIaRBqmVo31rjlhOk2kmW2Hr8dQ==
X-Received: by 2002:ac8:3621:: with SMTP id m30mr8787064qtb.168.1605013950178; 
 Tue, 10 Nov 2020 05:12:30 -0800 (PST)
Received: from trix.remote.csb (075-142-250-213.res.spectrum.com.
 [75.142.250.213])
 by smtp.gmail.com with ESMTPSA id e8sm7658678qti.28.2020.11.10.05.12.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Nov 2020 05:12:29 -0800 (PST)
To: Joe Perches <joe@perches.com>, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com, cocci <cocci@systeme.lip6.fr>
References: <20201027164255.1573301-1-trix@redhat.com>
 <3c39c363690d0b46069afddc3ad09213011e5cd4.camel@perches.com>
From: Tom Rix <trix@redhat.com>
Message-ID: <cc512954-2e1d-a165-f1f1-2c489fd6d3a9@redhat.com>
Date: Tue, 10 Nov 2020 05:12:26 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <3c39c363690d0b46069afddc3ad09213011e5cd4.camel@perches.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=trix@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 10 Nov 2020 15:03:56 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 10 Nov 2020 14:12:33 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Tue, 10 Nov 2020 15:03:54 +0100
Cc: alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
        linux-iio@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-stm32@st-md-mailman.stormreply.com, linux-rtc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-scsi@vger.kernel.org,
        linux-rdma@vger.kernel.org, qat-linux@intel.com,
        amd-gfx@lists.freedesktop.org, linux-pm@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-amlogic@lists.infradead.org, linux-nfs@vger.kernel.org,
        netdev@vger.kernel.org, linux-mmc@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net, linux-crypto@vger.kernel.org,
        linux-btrfs@vger.kernel.org
Subject: Re: [Cocci] Subject: [RFC] clang tooling cleanups
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

Ck9uIDExLzkvMjAgNjo1MiBQTSwgSm9lIFBlcmNoZXMgd3JvdGU6Cj4gT24gVHVlLCAyMDIwLTEw
LTI3IGF0IDA5OjQyIC0wNzAwLCB0cml4QHJlZGhhdC5jb20gd3JvdGU6Cj4+IFRoaXMgcmZjIHdp
bGwgZGVzY3JpYmUKPj4gQW4gdXBjb21pbmcgdHJlZXdpZGUgY2xlYW51cC4KPj4gSG93IGNsYW5n
IHRvb2xpbmcgd2FzIHVzZWQgdG8gcHJvZ3JhbWF0aWNhbGx5IGRvIHRoZSBjbGVhbiB1cC4KPj4g
U29saWNpdCBvcGluaW9ucyBvbiBob3cgdG8gZ2VuZXJhbGx5IHVzZSBjbGFuZyB0b29saW5nLgo+
Pgo+PiBUaGUgY2xhbmcgd2FybmluZyAtV2V4dHJhLXNlbWktc3RtdCBwcm9kdWNlcyBhYm91dCAx
MGsgd2FybmluZ3MuCj4+IFJldmlld2luZyB0aGVzZSwgYSBzdWJzZXQgb2Ygc2VtaWNvbG9uIGFm
dGVyIGEgc3dpdGNoIGxvb2tzIHNhZmUgdG8KPj4gZml4IGFsbCB0aGUgdGltZS4gIEFuIGV4YW1w
bGUgcHJvYmxlbQo+Pgo+PiB2b2lkIGZvbyhpbnQgYSkgewo+PiDCoMKgwqDCoMKgc3dpdGNoKGEp
IHsKPj4gwqDCoMKgwqDCoAkgICAgICAgY2FzZSAxOgo+PiAJICAgICAgIC4uLgo+PiDCoMKgwqDC
oMKgfTsgPC0tLSBleHRyYSBzZW1pY29sb24KPj4gfQo+Pgo+PiBUcmVld2lkZSwgdGhlcmUgYXJl
IGFib3V0IDEwMCBwcm9ibGVtcyBpbiA1MCBmaWxlcyBmb3IgeDg2XzY0IGFsbHllc2NvbmZpZy4K
Pj4gVGhlc2UgZml4ZXMgd2lsbCBiZSB0aGUgdXBjb21pbmcgY2xlYW51cC4KPiBjb2NjaW5lbGxl
IGFscmVhZHkgZG9lcyBzb21lIG9mIHRoZXNlLgo+Cj4gRm9yIGluc3RhbmNlOiBzY3JpcHRzL2Nv
Y2NpbmVsbGUvbWlzYy9zZW1pY29sb24uY29jY2kKPgo+IFBlcmhhcHMgc29tZSB0b29sIGNvb3Jk
aW5hdGlvbiBjYW4gYmUgZG9uZSBoZXJlIGFzCj4gY29jY2luZWxsZS9jaGVja3BhdGNoL2NsYW5n
L0xpbmRlbnQgY2FsbCBhbGwgYmUgdXNlZAo+IHRvIGRvIHNvbWUgZmFjZXQgb3IgYW5vdGhlciBv
ZiB0aGVzZSBjbGVhbnVwIGlzc3Vlcy4KClRoYW5rcyBmb3IgcG9pbnRpbmcgdGhpcyBvdXQuCgpJ
IHdpbGwgdGFrZSBhIGxvb2sgYXQgaXQuCgpUb20KCj4KPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3Rl
bWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2Np
Cg==
