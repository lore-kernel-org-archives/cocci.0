Return-Path: <SRS0=VPYo=LZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC67C11F64
	for <cocci@archiver.kernel.org>; Thu,  1 Jul 2021 18:43:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BFF06140E
	for <cocci@archiver.kernel.org>; Thu,  1 Jul 2021 18:43:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BFF06140E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 161Ih9xB027768;
	Thu, 1 Jul 2021 20:43:09 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5828C7610;
	Thu,  1 Jul 2021 20:43:09 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A088E4065
 for <cocci@systeme.lip6.fr>; Thu,  1 Jul 2021 20:43:07 +0200 (CEST)
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:52f])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 161Ih72v026686
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Thu, 1 Jul 2021 20:43:07 +0200 (CEST)
Received: by mail-ed1-x52f.google.com with SMTP id n25so9785172edw.9
 for <cocci@systeme.lip6.fr>; Thu, 01 Jul 2021 11:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hQsXVkspcWicXRxHUeQkors7x/x+vz+SkoV2vjuGQXk=;
 b=Dz7bdjD7qUygYAeuCltn6BolSDJ79bJIuOH5pzOB/h9NOH9Zfc3M87KoyxZoFKBp9j
 V8+Uji7DlVph/eMigv5iLy5tlIbquJbHM5pwyC2kMtRgxkGWwYxnp41cBJWmia2lB5qh
 tOYkW8pb4atC3OcdgcQUBUC5Nia8ZkXHHfdvblLln2vMptAFU7p1bxmQWT88BN4Neiy/
 AsXzC7MCPIfVjjh3jYyScJVxs/pqheKQcCzle/T0Z/o+WljOnNMoy2tjDk0hQq2a8pc0
 akQXz5CL/b339/k+lCofqv4gvY5FEeGro9oWVEXooCe8yn4W4Jr4Pno1n9iuowr42xx2
 YKNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hQsXVkspcWicXRxHUeQkors7x/x+vz+SkoV2vjuGQXk=;
 b=Ku0B1SpTvfa4PZnAKiBNPk8ujz5xEAsT0md8EnEihlntFF02+R3ntqhT+IBGeyWMrB
 ZUbHyBKpjGmLXOMigcTSagRKyie8AjmWe9XsrowSEIgnuNenk1BAgbvBhTxtwFxziz4/
 DgpjhdXaK8FeHGVfQ8gXMOx9Zm3ptiUz8K6Bg+8ENeMKYYfy9rcK3XcWMdyeJjysyTKM
 T7+yBdjnPu8WeFJ6e1jPoFYBexoKlvuVsGs0LR9BF5V3uY6u2wMTTCBdYElZJF6p3XJG
 qF/ekkOpbOqUe3q+dhZFyFDrwS+aH+4BZ2bHu9bpBXIU4QE/dG+8yDL4yilsvdPTicW5
 TWmw==
X-Gm-Message-State: AOAM532Fbdu0KoavmM3k53cVsHDJn//7L00F5dHkqthGR3SuoFEKtpHt
 9UV57AcNhGkD5tNvfeHTn+zddjfeFz915SeuvjU=
X-Google-Smtp-Source: ABdhPJzNrefmYIKfTZp0hhBKp7GDpHxr0wN3gPnR2VK09gcNgQfJmW1u4mFlaA2jp7Gc+xzTajTwMI1qY2FEHRnPSCI=
X-Received: by 2002:a05:6402:c10:: with SMTP id
 co16mr1647857edb.192.1625164986881; 
 Thu, 01 Jul 2021 11:43:06 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1622024972.git.sylphrenadin@gmail.com>
 <a205b3d2-5da2-8ed5-26a9-2103bee9a534@web.de>
In-Reply-To: <a205b3d2-5da2-8ed5-26a9-2103bee9a534@web.de>
From: Sumera Priyadarsini <sylphrenadin@gmail.com>
Date: Fri, 2 Jul 2021 00:12:08 +0530
Message-ID: <CACAkLup9dzuPDxNqtyirq5K38oDAfS=VQu=5brSJvVfv-a_mZA@mail.gmail.com>
To: Markus Elfring <Markus.Elfring@web.de>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 01 Jul 2021 20:43:10 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Thu, 01 Jul 2021 20:43:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] [PATCH 0/2] Add "use-patchdiff" option
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

T24gV2VkLCBNYXkgMjYsIDIwMjEgYXQgMTA6MTMgUE0gTWFya3VzIEVsZnJpbmcgPE1hcmt1cy5F
bGZyaW5nQHdlYi5kZT4gd3JvdGU6Cj4KPiA+IFRoaXMgcGF0Y2hzZXQgYWRkcyBhIGZlYXR1cmUg
dG8gZW5hYmxlIENvY2NpbmVsbGUKPiA+IHRvIG9ubHkgY2hlY2sgYWxsIHRob3NlIGZpbGVzIGlu
IGEgZGlyZWN0b3J5IHdoaWNoIHdlcmUKPiA+IG1vZGlmaWVkLiBJdCBwYXJzZXMgYWxsIHRoZSBm
aWxlcyBvYnRhaW5lZCBmcm9tIHRoZQo+ID4gb3V0cHV0IG9mICJnaXQgZGlmZiIgYW5kIGNoZWNr
cyB0aGVtIGFnYWluc3QgdGhlIHNwZWNpZmllZAo+ID4gY29jY2kgc2NyaXB0Lgo+ID4KPiA+IEFu
IGV4YW1wbGUgZm9yIHBhc3NpbmcgdGhlICJ1c2UtcGF0Y2hkaWZmIiBvcHRpb24gaXM6Cj4KPiBI
b3cgZG8geW91IHRoaW5rIGFib3V0IHRvIHVzZSB0aGUgcGFyYW1ldGVyIG5hbWUg4oCcdXNlLWZp
bGVzLWZyb20tZGlmZuKAnT8KCkkgd291bGQgcHJlZmVyIHNvbWV0aGluZyBzaG9ydGVyLCBsaWtl
ICJ1c2UtZmlsZXNkaWZmIiBidXQgSSBhbSBva2F5CndpdGggZWl0aGVyIG5hbWUgYXMKbG9uZyBh
cyB0aGUgbWFpbnRhaW5lcnMgYXJlIG9rYXkgd2l0aCBpdC4gOikKCkp1bGlhLCB3aGF0IGRvIHlv
dSB0aGluaz8gIEkgd2lsbCBzZW5kIGEgdjIgd2l0aCBhbnkgb2YgdGhlIGFib3ZlIG5hbWUgb3B0
aW9ucwooYW5kL29yIGFueSBvdGhlciBjaGFuZ2VzIHRoYXQgYXJlIHN1Z2dlc3RlZC4pCgpUaGFu
a3MsClN1bWVyYQoKPgo+IFJlZ2FyZHMsCj4gTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1l
LmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
