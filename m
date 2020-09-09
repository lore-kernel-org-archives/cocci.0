Return-Path: <SRS0=pcGb=CS=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35252C43461
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 07:39:12 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 558FD208FE
	for <cocci@archiver.kernel.org>; Wed,  9 Sep 2020 07:39:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hvk45Jt+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 558FD208FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0897clFv003907;
	Wed, 9 Sep 2020 09:38:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 86A185F8F;
	Wed,  9 Sep 2020 09:38:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 563A54316
 for <cocci@systeme.lip6.fr>; Wed,  9 Sep 2020 09:38:46 +0200 (CEST)
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:444])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0897chPM004813
 for <cocci@systeme.lip6.fr>; Wed, 9 Sep 2020 09:38:43 +0200 (CEST)
Received: by mail-pf1-x444.google.com with SMTP id d6so1396602pfn.9
 for <cocci@systeme.lip6.fr>; Wed, 09 Sep 2020 00:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:date:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=nNv35u1ldXzOEKenltQUlGYnPVKRgGyBIl7aYeHbKY0=;
 b=Hvk45Jt+K2CExex1KQEe7xijNtxPDH900J+LbezL+idLn6L7Z5GV6Gdp/Qio1t7BBv
 ZlRWBjJ3NuxH1Als0iszlmnIDTJNynFnbc4XsbMVhOj745QKNUaVGPtbpwMGWEhInqr8
 9bwLAQUuiQWLJJWPLBA1WvsNALpxUxLGCylKXkXanocyf97PLW7MMfIVFzk3lxFOGYqG
 BAS79CU0LAc29/hoWg4nF6i8NWLXCttOpMarR01kSp/MmOlm1Z83Ue0EO/PTpaEnH8A1
 gv8C44sg52k2IKEX8iEo0H3FBm1R7b6+U00SIearqMWLoO6GUAIG0XyKzkj7X7CuEAXt
 Pouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:date:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nNv35u1ldXzOEKenltQUlGYnPVKRgGyBIl7aYeHbKY0=;
 b=ADLJCgArJAuN+AuXjzJJ7/EMi1wy9RcnRXbGtsg8UYOIAG3o05xCzAxBb7/k0FwCZx
 P1o1ctC/gJYehF97WZoPxT2F4gByCgAUVJ9obdoC+OGyT4y5WBLkM0klgOIq0hBhmTYe
 MAp/EcGvVhEJDwHs0t9lz5V1McLEv0Q/SVXcHmAYbCKN3fhLwya6CIejZfJtK9o/ThYb
 rzxLkDWxUCPrC46fewe9w/N/XeUmrqf0RCVIbWPW7y4viQHvF8JyCm31OkuQ9+dp+MPW
 c3+axBACD2gxZXJO7ekE2JHBJbdJmtaw0aR0gFeYtVorS4r5WqYyT5sOeL3OqWI00sZj
 6dvg==
X-Gm-Message-State: AOAM5329ciQTWM80iC++jdumQ8+dKIx9gx/IrS2agIdoKqYXYCuGFlwm
 Tf0hYJSpuvYD4Q3N7gZptEw=
X-Google-Smtp-Source: ABdhPJwsjfw30kgxWLkWH0FSYkSjPrI7Numm+JV/jM7fOZPTD7AjKnHY1CCZhtaVU/77wx21QRXW+g==
X-Received: by 2002:a63:4f26:: with SMTP id d38mr2019642pgb.72.1599637122985; 
 Wed, 09 Sep 2020 00:38:42 -0700 (PDT)
Received: from adolin ([49.207.200.122])
 by smtp.gmail.com with ESMTPSA id s8sm1796012pfd.153.2020.09.09.00.38.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Sep 2020 00:38:42 -0700 (PDT)
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
X-Google-Original-From: Sumera Priyadarsini <sumera@adolin>
Date: Wed, 9 Sep 2020 13:08:36 +0530
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20200909073836.yrsqb6o4i3c47xd4@adolin>
References: <036792a4-0454-732a-8a0e-83123713445c@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <036792a4-0454-732a-8a0e-83123713445c@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 09 Sep 2020 09:38:48 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 09 Sep 2020 09:38:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH] scripts: coccicheck: Do not use shift command
 when rule is specified
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

T24gV2VkLCBTZXAgMDksIDIwMjAgYXQgMDg6NTI6MTlBTSArMDIwMCwgTWFya3VzIEVsZnJpbmcg
d3JvdGU6Cj4gSSBmaW5kIGl0IGhlbHBmdWwgdG8gYXZvaWQgdHlwb3MgKGxpa2UgdGhlIGZvbGxv
d2luZykgaW4gdGhlIGNoYW5nZSBkZXNjcmlwdGlvbi4KPiAKPiAKPiA+IOKApiBNYWtmZWlsZS4g
4oCmCj4gCj4g4oCmIE1ha2VmaWxlLiDigKYKPiAKPiAKPiA+IOKApiBwYWFzaW5nIOKApgo+IAo+
IOKApiBwYXNzaW5nIOKApgo+IAo+IAo+ID4g4oCmLCByZXN1dGluZyDigKYKPiAKPiDigKYsIHJl
c3VsdGluZyDigKYKPiAKPiAKPiA+IFRoaXMgcGF0Y2ggbW9kaWZpZXMgY29jY2ljaGVjayDigKYK
PiAKCkkgZGlkIG1ha2UgdGhvc2UgZXJyb3JzIGJ1dCBJIGFsc28gcmVjdGlmaWVkIHRoZW0uIFRo
aXMgaXMgc3RyYW5nZQpiZWNhdXNlIG15IGNvbW1pdCBtZXNzYWdlIHNob3dzIHRoZSByZWN0aWZp
ZWQgdmVyc2lvbi4KRWl0aGVyIHdheSwgSSB3aWxsIHNlbmQgYSB2Mi4gVGhhbmtzIGZvciBwb2lu
dGluZyB0aGlzIG91dC4KCj4gV291bGQgYW4gaW1wZXJhdGl2ZSB3b3JkaW5nIGJlIHByZWZlcnJl
ZCBmb3IgdGhlIGNvbW1pdCBtZXNzYWdlPwo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3Nj
bS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24v
cHJvY2Vzcy9zdWJtaXR0aW5nLXBhdGNoZXMucnN0P2lkPTM0ZDRkZGQzNTlkYmNkZjZjNWZiM2Y4
NWExNzkyNDNkN2ExY2I3ZjgjbjE1MQo+IAo+IFJlZ2FyZHMsCj4gTWFya3VzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApD
b2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0
aW5mby9jb2NjaQo=
