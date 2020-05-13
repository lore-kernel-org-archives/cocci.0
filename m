Return-Path: <SRS0=ftTc=63=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2B82C2D0F8
	for <cocci@archiver.kernel.org>; Wed, 13 May 2020 07:33:29 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2A49A205ED
	for <cocci@archiver.kernel.org>; Wed, 13 May 2020 07:33:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LkZfdyTo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2A49A205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04D7XA03015907;
	Wed, 13 May 2020 09:33:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id BF5D97559;
	Wed, 13 May 2020 09:33:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 575763DC8
 for <cocci@systeme.lip6.fr>; Wed, 13 May 2020 09:33:08 +0200 (CEST)
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:544])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04D7X6oA009047
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Wed, 13 May 2020 09:33:07 +0200 (CEST)
Received: by mail-pg1-x544.google.com with SMTP id n11so7398921pgl.9
 for <cocci@systeme.lip6.fr>; Wed, 13 May 2020 00:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=message-id:subject:from:to:cc:date:in-reply-to:references
 :user-agent:mime-version:content-transfer-encoding;
 bh=9etukbnS50pSfT1bKj2JppuLdXUV2SCUuoF5kBakPOc=;
 b=LkZfdyTo6tPZP3qRB7bnYT/m75bXnEnFuTR/yizrSRvxG97v/5PudC05kVfCbY64X2
 uGHTLQ+Tx9qHZGSNJMoXtJIMhV6cl80ILBGk50DSYGF2ZwgiHJDslLKJYpnRKtwXHArC
 Mg0oy1aMyWYtXcSBJWU3+8j9GVvF6cIZY0xPNiIN7biUj+feMZVXgPaWu5RUvlc3uYa+
 LvoQ6sn9pw0N1zSGvQxzW/ry6dNUwPw4L3GYWcX/fV9dQVxavk4Xd20UNwnpgf/ebAP3
 y+TItiCyOd6kXoNXxXtBNlmLSpcP8elFurRjBUPp2cIayi5etEBS5K4T79DvAiJJyA2d
 fQUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
 :references:user-agent:mime-version:content-transfer-encoding;
 bh=9etukbnS50pSfT1bKj2JppuLdXUV2SCUuoF5kBakPOc=;
 b=OCqqy25SBsJOF4ol1rptgmBxMwbzHuzKSpsRY+G30dXXyPFoak3r91UY270LM3L1JU
 GvTqJke7Xv5qqvK3REfU/lD/aG8yioCsVFEeDSMqHfOUz7NOVTfx/DLhYGuVH42x1aCa
 JOLIaL36sTz18poTdjOuSEWl1Hd5lopnYsZC4Id77ADTqrqIxQPNHwQ2OArNd6oi2Pbh
 KNTBaSRAosb9zrAbaIiGhLnn6i2/ccz8RbEht4TfQ9WTR5VdZfznJ4tUBvl9t6qMm9IE
 Z8DTcr3OSxfGF0neZ4larG1OUZJTD87UZA40bDZBGrr/HJEpUuzf7Y2qoeKcAu37dwYN
 RtoA==
X-Gm-Message-State: AGi0PuY4eb6q8Tm9SJmlk/qSl9QOW7KPiv+wGoef0C86Pm4+TqKN8lnE
 jPg6QTV5pRqhwtN0Kxk+KAo=
X-Google-Smtp-Source: APiQypKS+8iCaYTRFeNWuraZvqxqAK5VOSsZRzg1oNfCsvV8UtbJAiWqSVXJ8mbRYkDcgpvt5c0qew==
X-Received: by 2002:a62:7d91:: with SMTP id
 y139mr24497781pfc.172.1589355186069; 
 Wed, 13 May 2020 00:33:06 -0700 (PDT)
Received: from localhost.localdomain ([1.38.219.254])
 by smtp.gmail.com with ESMTPSA id 140sm14074963pfw.96.2020.05.13.00.32.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2020 00:33:05 -0700 (PDT)
Message-ID: <7c9f6da3779ca11e551224ca9efd06da5c569b56.camel@gmail.com>
From: Jaskaran Singh <jaskaransingh7654321@gmail.com>
To: Christoph =?ISO-8859-1?Q?B=F6hmwalder?= <christoph.boehmwalder@linbit.com>
Date: Wed, 13 May 2020 13:02:33 +0530
In-Reply-To: <fa30c7d6-5278-9575-517b-31658b1a37c3@linbit.com>
References: <fa30c7d6-5278-9575-517b-31658b1a37c3@linbit.com>
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 13 May 2020 09:33:10 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 13 May 2020 09:33:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Regression since recent parentypes patches were merged
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

T24gVHVlLCAyMDIwLTA1LTEyIGF0IDEzOjU3ICswMjAwLCBDaHJpc3RvcGggQsO2aG13YWxkZXIg
d3JvdGU6Cj4gSGkgSmFza2FyYW4sCj4gSGkgYWxsLAo+IAo+IEkgaGF2ZSBub3RpY2VkIGEgcmVn
cmVzc2lvbiBpbiBzcGF0Y2ggc2luY2UgdGhlIHJlY2VudCBTbVBMCj4gaW1wcm92ZW1lbnRzIAo+
IHdlcmUgbWVyZ2VkLiBIZXJlIGlzIGEgc21hbGwgcmVwcm9kdWNlcjoKPiAKPiBAQAo+IHN0cnVj
dCBzb2NrZXQgKnNvY2s7Cj4gc3RydWN0IHNvY2thZGRyICp1YWRkcjsKPiBpbnQgcGVlcjsKPiBA
QAo+IHsKPiAraW50IF9fX2FkZHJfbGVuOwo+IC4uLgo+IC0gc29jay0+b3BzLT5nZXRuYW1lKHNv
Y2ssIHVhZGRyLCBwZWVyKTsKPiArIHNvY2stPm9wcy0+Z2V0bmFtZShzb2NrLCB1YWRkciwgJl9f
X2FkZHJfbGVuLCBwZWVyKTsKPiAuLi4KPiB9Cj4gCj4gCj4gVGhpcyB1c2VkIHRvIHBhcnNlIGp1
c3QgZmluZSwgaG93ZXZlciBub3cgaXQgZXJyb3JzIG91dDoKPiAKPiAKPiAkIHNwYXRjaCAtLXBh
cnNlLWNvY2NpIGNvbXBhdC5jb2NjaQo+IGluaXRfZGVmc19idWlsdGluczogL3Vzci9sb2NhbC9i
aW4vLi4vbGliL2NvY2NpbmVsbGUvc3RhbmRhcmQuaAo+IG1pbnVzOiBwYXJzZSBlcnJvcjoKPiAg
ICBGaWxlICJjb21wYXQuY29jY2kiLCBsaW5lIDksIGNvbHVtbiAxMywgY2hhcnBvcyA9IDk4Cj4g
ICAgYXJvdW5kID0gJ2dldG5hbWUnLAo+ICAgIHdob2xlIGNvbnRlbnQgPSAtIHNvY2stPm9wcy0+
Z2V0bmFtZShzb2NrLCB1YWRkciwgcGVlcik7Cj4gCj4gCj4gSSBoYXZlIGJpc2VjdGVkIHRoZSBw
cm9ibGVtIGFuZCBpdCBhcHBlYXJzIHRoYXQgdGhlIGZpcnN0IGJhZCBjb21taXQKPiBpczoKPiAK
PiBjb21taXQgYzI4MDM3NTYzNWY2MmRmYmUwNTI3MDllNGU0N2E4MjE0MGQzMmNlNQo+IEF1dGhv
cjogSmFza2FyYW4gU2luZ2ggPGphc2thcmFuc2luZ2g3NjU0MzIxQGdtYWlsLmNvbT4KPiBEYXRl
OiAgIEZyaSBNYXIgMjAgMTI6MzE6MzIgMjAyMCArMDUzMAo+IAo+ICAgICAgQWRkIHBhcmVudHlw
ZXMgdG8gU21QTAo+IAo+ICAgICAgVGhpcyBhbGxvd3MgdGhlIFNtUEwgYW5kIEMgQVNUcyB0byBi
ZXR0ZXIgbWF0Y2ggdXAsIHdoaWNoCj4gZW5hYmxlcwo+ICAgICAgbW9yZSB0cmFuc2Zvcm1hdGlv
bnMuICBUaGUgcGF0Y2ggaXMgdmVyeSBsYXJnZSwgc28gSSBoYXZlIGxlZnQKPiAgICAgIHRoZSBk
aWZmZXJlbnQgbWVzc2FnZXMgYXMgdGhleSB3ZXJlIHByb3Bvc2VkIGluIHRoZSBvcmlnaW5hbAo+
ICAgICAgcGF0Y2ggc2VyaWVzLgo+IAo+IFdoaWNoIGlzIHVuZm9ydHVuYXRlbHkgaHVnZSwgYW5k
IHNpbmNlIGl0IHdhcyBzcXVhc2hlZCB0b2dldGhlciBJCj4gcmVhbGx5IAo+IGNhbid0IGJlIGFu
eSBtb3JlIHNwZWNpZmljLgo+IAo+IEFueXdheXMsIGlzIHRoaXMgYSBidWc/IE9yIHdhcyBJIGRv
aW5nIHNvbWV0aGluZyB3cm9uZyBpbiB0aGUgZmlyc3QKPiBwbGFjZT8KPiAKCkhpIENocmlzdG9w
aCwKCkkndmUgc2VudCBhIHBhdGNoIGZvciB0aGlzLCBpdCBzaG91bGQgYmUgbWVyZ2VkIGFmdGVy
IHJldmlldy4gU29ycnkgZm9yCnRoZSBpbmNvbnZlbmllbmNlIQoKQ2hlZXJzLApKYXNrYXJhbi4K
Cj4gVGhhbmtzIGFuZCBiZXN0IHJlZ2FyZHMsCj4gLS0KPiBDaHJpc3RvcGggQsO2aG13YWxkZXIK
PiBMSU5CSVQgfCBLZWVwaW5nIHRoZSBEaWdpdGFsIFdvcmxkIFJ1bm5pbmcKPiBEUkJEIEhBIOKA
lCAgRGlzYXN0ZXIgUmVjb3Zlcnkg4oCUIFNvZnR3YXJlIGRlZmluZWQgU3RvcmFnZQoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBs
aXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFu
L2xpc3RpbmZvL2NvY2NpCg==
