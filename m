Return-Path: <SRS0=ScdY=ZJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 946C1C432C0
	for <cocci@archiver.kernel.org>; Sun, 17 Nov 2019 11:47:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E4D220730
	for <cocci@archiver.kernel.org>; Sun, 17 Nov 2019 11:47:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Zv1grBnR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E4D220730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAHBlfiY026600;
	Sun, 17 Nov 2019 12:47:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2FBDD77A5;
	Sun, 17 Nov 2019 12:47:41 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 182E07705
 for <cocci@systeme.lip6.fr>; Sun, 17 Nov 2019 12:47:39 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAHBlcq6029355
 for <cocci@systeme.lip6.fr>; Sun, 17 Nov 2019 12:47:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573991258;
 bh=XOuFbPqHugv4099bOhHXpGjh+ToRuJeJ3jL0ogKNRdA=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=Zv1grBnRc1P5ykiaRs1D140ZDNajAIWnwdl1GhgViZP5caTxXjRNw50t859kxD0pu
 numZw8wLWkW+nsNJzkrBUDbzFClhdlBbkrWxruWr/zBK0sY5QHJ4dkaGM+rxElcbtJ
 hrRNv1VtMUzAuzBOXauBMv/FUWGiN3SMvqx2ZpgA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.59.42]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LnS8Q-1hwgp20tFW-00hfgH for
 <cocci@systeme.lip6.fr>; Sun, 17 Nov 2019 12:47:38 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <87018ba7-e8ac-8b46-e082-c0c9ecc20624@web.de>
Date: Sun, 17 Nov 2019 12:47:37 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:7QJ450EFJp/qnLT3HctVI0JggqyK485+Q4UzIm6o0ttGPb4JOSx
 xw+wwKLxIEunG5MhbDnPqB47mg/0ad9NrRVHVhY/zx4zgVcik9sGkrRg4JZF4UXlNd5KOHo
 EtIZGs7OOTYxub0wzUe40noDKLhNf4RjnQOSPzMcLdE4ll2XQGXY513Dnt+OvrVFn/bZSls
 m9XNss09VOCpKJYTJuPaw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:I/r+3toDhgw=:sbuO81W/VzIkqs4/bOr4ec
 8OOKIKltJJclDhAVQ05Fxb7XLGSvGTrng5dP0A8qH+nkv6/yQz8vnIyf43CTg2Exynutczc/6
 b7Q4S6xFxVFFbbS/boe0DMIGattolZnYCqvqSAlz6Hmz3gk9JHZOz7z3twLu6t6+a81QlVvFr
 YS76+0bdiC/F4EuBuFoVoYkwBcF2OuauTthAJAgDqUK33hrvBwLEIK7Gt5QFoWD0xueK8NKlj
 W797rGpJJjTaUkfQeBQ78MoUVjof8tT1jwb/vy3xhFp7kzpjFp6Vnl55xQvS4ZMyqCyMLCYzM
 PeRuUvqN1Gx/2zIrCj8DPbkwUwwHTRmDNi+9m5MfJdjvYxGb6iqjKTvy/3QuGG80Unt8PaVrR
 xd8SugwumlNpbCrz/Y7h5tykltz5xc6WtCwjj5HjZHFkeFNIfUbaUaHLk3eqTEAclPE6MDvQA
 1LZ2yq2FyOa4DmNW1q0skVBrXVh5n7BoXqWEzCNMhi+B5r0aOowjuDrJ6qvs+BQ1DoSg7BmhX
 LhtkGO+I9jvv0uE5WfnqOl/awloW2M4whLpYSqVGEsfJkGjGmHCgGCEE7QpEBKpS19vDFT7H1
 AEjvzu3nJDsyMZnlCn1ftUKtQeKB2qA+0A03oowECGe9oCAa9CKCoke5SBOwxNH2lj4b3XCYr
 C7rQx2uq02CE345OOea3jI37aj0blTB2Xgh/4tLyA47aW7BfihLy6WDdkKG/1s/vqGeBOG9wh
 l9DCZUA+CwMqsTpKNIdy4pWOcmxauumLIS5ZteQ0IDNuEHY/+6VP9Ioty/8WcTgawXvHGN9TL
 diBHpJ48u6nE2V5vUUPHj1rqxRdxerNuRjlI9MOb/w8qZv5syeTMCWEdVGQ4LbEPb40CsgeJs
 5f/XDXEYrmcCgyXfbY2Pr8b70VfL+axUprN3lxcLwWO81ynY8l0jXIS0C3XHWnt2NztygqP3a
 0iKusgJ23ZYgziV21CGZJQ8ngPrmwKJMxagRoFmH+KcwZ7ESnD+Fh9IxDR9i8/2hZRyf9uQYs
 UoLWyFeSndYzSR2KXsrjnndJm8RBjvcCx3OL5tnGIwnPBsFtiDIsD5BQ8Pec2YOQc0ZKG6oNG
 mQjiS3jPSdWAnDMWnUVV1HbUnSOojEyzyA4+dZHwratDAUIWj0ie5v/XEZEhBRcc7Y0ncapNB
 E+fuDnixjxN7heR966aFglwZ7MvIGPVtLkVKOv7SyPwsm4IQmnFMHsaPV6KrmJUamlBlx/Wqc
 FI7+tkHygxHt195sX5R4OsSIF3i4o9XcVgmMdPxPbqJpFae1rYtdUBx2prAw=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 17 Nov 2019 12:47:42 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 17 Nov 2019 12:47:38 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Checking size determinations with SmPL
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

SGVsbG8sCgpUaGUgZm9sbG93aW5nIGNvZGUgZXhhbXBsZSBnZXRzIGFjY2VwdGVkIGJ5IHRoZSBD
b2NjaW5lbGxlIHNvZnR3YXJlLgoKQGRpc3BsYXkxQApleHByZXNzaW9uKiBlOwp0eXBlIHQ7CkBA
CipcKCBzaXplb2YodCkgXHwgc2l6ZW9mKCplKSBcKQoKCldvdWxkIGl0IGJlIG5pY2UgaWYgYW5v
dGhlciBzY3JpcHQgdmFyaWFudCBjYW4gd29yayB0b2dldGhlciB3aXRoCnN1Y2ggYSBTbVBMIGRp
c2p1bmN0aW9uIGFsc28gaW4gdGhpcyB3YXk/CgpAZGlzcGxheTJACmV4cHJlc3Npb24qIGU7CnR5
cGUgdDsKQEAKKnNpemVvZiggXCggdCBcfCAqZSBcKSApCgoKZWxmcmluZ0BTb25uZTp+L1Byb2pl
a3RlL0NvY2NpbmVsbGUvUHJvYmU+IHNwYXRjaCAtLXBhcnNlLWNvY2NpIGNoZWNrX3NpemVvZjIu
Y29jY2kK4oCmCm1pbnVzOiBwYXJzZSBlcnJvcjoKICBGaWxlICJjaGVja19zaXplb2YyLmNvY2Np
IiwgbGluZSA1LCBjb2x1bW4gMTcsIGNoYXJwb3MgPSA1NAogIGFyb3VuZCA9ICcqJywKICB3aG9s
ZSBjb250ZW50ID0gKnNpemVvZiggXCggdCBcfCAqZSBcKSApCgoKUmVnYXJkcywKTWFya3VzCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxp
bmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFp
bG1hbi9saXN0aW5mby9jb2NjaQo=
