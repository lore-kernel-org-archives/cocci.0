Return-Path: <SRS0=kdUr=DX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3683C433DF
	for <cocci@archiver.kernel.org>; Fri, 16 Oct 2020 10:02:46 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F2120848
	for <cocci@archiver.kernel.org>; Fri, 16 Oct 2020 10:02:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="sUcBgwRz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F2120848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09GA26qN002094;
	Fri, 16 Oct 2020 12:02:06 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DF5D7778E;
	Fri, 16 Oct 2020 12:02:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C0CE5578C
 for <cocci@systeme.lip6.fr>; Fri, 16 Oct 2020 11:47:15 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09G9lFMe003119;
 Fri, 16 Oct 2020 11:47:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1602841635;
 bh=1F6IYJHnDjcdsw+03ya7hMoalnNg4fp0JQtHBApB3WQ=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=sUcBgwRzbs9sOrlcJqswQ0qxi4acrzQFuN82xy1B8s7LYnN+Cxo+lE4WTDbt5w9kg
 ndqxw8jRjrcdf9uvQT2tpOn4OsAj0/XJvWPABDZs3lNswGI2PeVsrKZ0q1hMiccCfW
 41EcG5Joz23x0ltfLBCYF2gD0SUowQJ+8pqtr2dc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from sonne.localnet ([78.48.118.65]) by smtp.web.de (mrweb005
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MsaWF-1k9tpx3kD5-00tt14; Fri, 16
 Oct 2020 11:47:14 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Denis Efremov <efremov@linux.com>, Coccinelle <cocci@systeme.lip6.fr>
Date: Fri, 16 Oct 2020 11:46:56 +0200
Message-ID: <3528117.7ODa3CK5J5@sonne>
MIME-Version: 1.0
X-Provags-ID: V03:K1:Yze2MEpwGqqeMszRGnTFIY0FtHUCc5Jfi4k4PYNDryv2jQtqKBH
 NoryOmfaFHX5Vy7fIQf0fkd02kj3WTifMW4XZtroDf44hZHAjiAW6as4qLf7ZQOh0VyKMUx
 fXTLJSCb4G87OPyIadsnETNLnZ643BUZQO0dIa/IrB3+k+Aj9BNCAn8fhktcEFY0DR0a5vM
 C8kHKgrY0oFqKOZ8DS8XA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:JefUVXHQ3aA=:MRc2tWwdrCdm7+DoxW7l3t
 nlygAdiTYr8LQJYd3aMximWvuVeFGHVWfWq6RdTpYFV5Ia1w3J/VP/X+rBKhL4D0zWaJI2TH4
 SM8XZyFsbjF92Xjsl0Ana9Snekw+H+UzbHdGSV3ITxiiBvMl3ktsn8c4KEEKPFwGe6EViIwym
 WHIhE9f4UlZ7aQ06g4I92MBI6OZdcmX0KGun6DEN7rBgvEdlu1V4VtQgm7W4AayC/8f+elHRG
 Tnnj9RERvTVNum2eHfbneyKQGepC1yGHMw7fzFpAoXfRtzK86I5b4uBdzBuX3ru6tDNWfp/Vu
 zkOJ1fprikJk4WDnq1Rgg329bCmznAFypWH4moc1FxD2rXFH8twkfxNc9AqQQ2iIPA7sGfgjr
 yVP/iijAEzw0YV8NhlDMy/ZiQRWa0ZI+WDofsURByAb5Z5UTnwzVW7W3gO4CgKJH5sb50/s53
 YiapeWkQrDJlEvxb8kjw7RdlMp0i6lIQnd3Fy58+CscshkVRngldm/S+ZFymZswrP2TfKsUDg
 YmJQpyqmEfw+6+EqqdIvC3Mrsk8bnMj1Yeo+EtRXhLZ1aGpMFQTjjnvh5P/qeL7b4IUyUI/kg
 Xf12SoH1v1+IQUhPQYENuafk+RS4GR9hi5GzQjbcJCuGz3Ob53fWsM5PeovXKJaBKDkmLfssa
 PpPT0X6qmN+2zgVuLUEq831TwGd26f0djnNuNl6idsZC9PiQhql0reB6FSuEVEt+3CMqKg86S
 zRLfY9xiOu1fWa7FLH4rGd7vq6Acmm1dc+dn2GB4TDnGiMNFubpAner355P3W2DnRp+gWeCye
 zhh/B8HdO0NVxxh+kEbN+9qZWH0MsfwgOK8A1emKWuYSN/AVSppFUwbHqBpyao1p3b/YghC49
 8sBf538Zc0MZNFAOs21w==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 16 Oct 2020 12:02:06 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 16 Oct 2020 11:47:15 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 16 Oct 2020 12:02:04 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julia Lawall <Julia.Lawall@lip6.fr>,
        Alexander Popov <alex.popov@linux.com>
Subject: Re: [Cocci] [PATCH v8] coccinelle: api: add kfree_mismatch script
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

4oCmCj4gKyAgICBFID0gXChrbWFsbG9jXHxremFsbG9jXHxrcmVhbGxvY1x8a2NhbGxvY1x8Cj4g
KyAgICAgICAgICBrbWFsbG9jX25vZGVcfGt6YWxsb2Nfbm9kZVx8a21hbGxvY19hcnJheVx8Cj4g
KyAgICAgICAgICBrbWFsbG9jX2FycmF5X25vZGVcfGtjYWxsb2Nfbm9kZVwpKC4uLilAa29rCuKA
pgoKSG93IGRvIHlvdSB0aGluayBhYm91dCB0aGUgcG9zc2liaWxpdHkgZm9yIGFueSBhZGp1c3Rt
ZW50cyBhY2NvcmRpbmcgdG8gdGhlIG9yZGVyCm9mIHRoZSBtZW50aW9uZWQgZnVuY3Rpb24gbmFt
ZXMgaW4gcHJvcG9zZWQgZGlzanVuY3Rpb25zIGZvciB0aGUgc2VtYW50aWMgcGF0Y2ggbGFuZ3Vh
Z2U/CgpDYW4gYW55IGFkZGl0aW9uYWwgaWRlbnRpZmllcnMgYmVjb21lIHJlbGV2YW50PwoKUmVn
YXJkcywKTWFya3VzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
