Return-Path: <SRS0=mjN0=CH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C960EC433E6
	for <cocci@archiver.kernel.org>; Sat, 29 Aug 2020 09:03:55 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D43B2075B
	for <cocci@archiver.kernel.org>; Sat, 29 Aug 2020 09:03:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="GhQdZuxE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2D43B2075B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 07T93Vsm009890;
	Sat, 29 Aug 2020 11:03:31 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5C91A777D;
	Sat, 29 Aug 2020 11:03:31 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DDC7D3F6C
 for <cocci@systeme.lip6.fr>; Sat, 29 Aug 2020 10:25:03 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 07T8P2UF027162
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 29 Aug 2020 10:25:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1598689501;
 bh=RnY+0To/5YBQ2WOnjfb1pK4gNI1qd4o/p1M1pqrWzVg=;
 h=X-UI-Sender-Class:To:From:Subject:Cc:Date;
 b=GhQdZuxE8VyQ9z0a4ltOpg4Y8/v8jMl9XOVdS3XJBYdg8EEcNhGIsr3jdjT7LyG/u
 ZcSth17rJIGoWFCx4sEc+JFtFOGOeQC2U/fxhWmdalZtBKPCl3axfzT8A+c73HwJn7
 G3fy2fhXXIkS/mwqn3OCoZg914mQc2FLJqLbfxsM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.31.245]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lk8T4-1kiX5z2GYU-00c7KC; Sat, 29
 Aug 2020 10:25:01 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <75644b75-443c-1da9-fd1b-35e2ce34cf47@web.de>
Date: Sat, 29 Aug 2020 10:25:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:g8mWa7O5enevdlBZTByrqFVMc3AVOW41hEfubts2eDVDDeck0W9
 142VoPb56Nja5DI6z8fjMoRBySaHE/bfa4PPFlWyTd3PvwS1cE4s20e4ntM1DGzgpjmuY/P
 Xf1EfnHQns1KsLPRf2jXrOclaTZRy9et4dcYqu6R2yu92lV334cDm1IxMHcVGgpnoYICacj
 nCocURwqDlR2dqDZewy+g==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Sm3v83EMf9g=:CnLB+43ocvNrOgD8LGNN2O
 2Tv8ZNf6vBGeUeC9xamjhAJglNukUQczg9yt8Vdff4PP6p4rQBonLRVQKcJ1TaxNtsN0vWiV3
 edh9GpJfg5ihQqxbYVJtnop8blVlzq+pjU36eR9tPfixHztneUioySe/wHwVkZiWTdAjaU+CM
 /oNNANp7p4hZa2N7ucneLZC0+ujjZA3LgHAtKas5S/qxZzFEVtlmFFzzX0HgaZFfPSbPOpJAp
 pdggr9vlQQy1PZ2HYVHC3gJBzMcpMDXmMDfP1fy0gL1g9c14bDbQiyu0kr6VQxK3qkRj9koRb
 8tKOGIcdxqeZhcEFhnh41Oc9PphOrKk6FZxtFBKECxosi1KkqBN8LTaEMIeBGVfzlVHw9RGZd
 A/d6whKhzJ/QqcBZ2s4kmLsZZbQBnER+pOQat1KhGgdy96hJLzaqNC7WR46tVeMzkvd9jr9dc
 kZRlp0H5wuW+R2rmYfJs1NLU/nzbyt+z4SbDw61i/vDtEVEsn7XuhNkhJ6p+dQt4uTAUU76ij
 60pxXY/2vyXnv+zs05JmT5bhdIllp9dCMxfTzftVxxDFg2RlPxq+FejraWHttnlb5+/dDXe0z
 j12BIv8JzFoa1hkM0Bq43lFir9ZcFHHpt7msBvbAVtaHaIAYdqt+YnssqU7xFPIGkW2XScMjh
 eGjQ1mcFrsC1P2W4lWLgISBpHHpgOQPxgv4Hh+MOApbDTu5TfKeIrmktcOMzjCekVDbRsqZ95
 QMB6tJdLHyxDmToumTYheGPUUfm8+UK8hrzxUBiZ7OtG7rBkpoNAEU0jD37ePuQYdRSMTdCFs
 7tQ5W0MAZvzBrlVFpRBhMs3L7mOABdiO8LXzx53iUcaPVUVgQJaWlLuQz4zprHihksKwWIubS
 bXs0Xnq5WS48pNaRlsQ56wvOY+E5TmAkLrxXMbjYMUkwp+JyA3XyCQtaCWn39XQhR9kiw+6cP
 y7W4hV7mVYfC3bbCLWuExdxPhfSdgVWWejJuuPGsJgAx01J0cRpUZgQcb9GPK0DOhsQqtmNbc
 RmkyHlzABlbSYegMg1m/zW58PxFQaWxcYPU4tAdLP5roYJT6xMl7kHWdzJQbdsXEoPYDXMSu6
 IG7QybCxYHIYQ6mjuU/xQWcNtfS+OOR4tQm7vW8YKss09O/nZ0juAfIbWCu9Exy9yokKAy2PG
 YJIEP1r8UXRXUqB0/nOs//XxszfPT18r1Q7OeqvXx+EStU/bhHLwxQvlm9FQ61ROfHj9SNiZH
 uczk2fiUIoV8kNgndiMXb4psszxjpDWhqtD+1PA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 29 Aug 2020 11:03:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 29 Aug 2020 10:25:02 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 29 Aug 2020 11:03:29 +0200
Cc: "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Kees Cook <keescook@chromium.org>
Subject: [Cocci] Checking the deletion of a multiplication operator with SmPL
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

SGVsbG8sCgpUaGUgZm9sbG93aW5nIHNtYWxsIHNjcmlwdCB2YXJpYW50IGZvciB0aGUgc2VtYW50
aWMgcGF0Y2ggbGFuZ3VhZ2UgZ2V0cyBhY2NlcHRlZAphY2NvcmRpbmcgdG8gdGhlIHNvZnR3YXJl
IGNvbWJpbmF0aW9uIOKAnENvY2NpbmVsbGUgMS4wLjgtMDAxNTktZzczMGRiYjAz4oCdLgoKQHJl
cGxhY2VtZW50QAppZGVudGlmaWVyIGFycmF5LCBpbnN0YW5jZSwgc2l6ZTsKdHlwZSBUOwpAQAoo
Ci1zaXplb2YoVCkKfAotc2l6ZW9mKCppbnN0YW5jZS0+YXJyYXkpCikKICoKK2ZsZXhfYXJyYXlf
c2l6ZShpbnN0YW5jZSwgYXJyYXksCiAgICAgICAgICAgICAgICAgaW5zdGFuY2UtPnNpemUKKyAg
ICAgICAgICAgICAgICkKCgpCdXQgSSBvYnNlcnZlIGRhdGEgcHJvY2Vzc2luZyBkaWZmaWN1bHRp
ZXMgaWYgSSB3b3VsZCBsaWtlIHRvIG1hcmsKdGhlIG11bHRpcGxpY2F0aW9uIG9wZXJhdG9yIGFs
c28gZm9yIGRlbGV0aW9uIChvbiBhIHNlcGFyYXRlIGxpbmUpLgoKZWxmcmluZ0BTb25uZTp+L1By
b2pla3RlL0NvY2NpbmVsbGUvUHJvYmU+IHNwYXRjaCAtLXBhcnNlLWNvY2NpIGZsZXhfYXJyYXlf
c2l6ZS10ZXN0Mi0yMDIwMDgyOS5jb2NjaQppbml0X2RlZnNfYnVpbHRpbnM6IC91c3IvbG9jYWwv
YmluLy4uL2xpYi9jb2NjaW5lbGxlL3N0YW5kYXJkLmgKRmlsZSAiZmxleF9hcnJheV9zaXplLXRl
c3QyLTIwMjAwODI5LmNvY2NpIiwgbGluZSAxMCwgY29sdW1uIDEsIGNoYXJwb3MgPSAxMDMKICBh
cm91bmQgPSAnKicsCiAgd2hvbGUgY29udGVudCA9IC0qCgoKQ2FuIHN1Y2ggYSB0cmFuc2Zvcm1h
dGlvbiBzcGVjaWZpY2F0aW9uIGJlY29tZSBzdXBwb3J0ZWQ/CgpSZWdhcmRzLApNYXJrdXMKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGlu
ZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWls
bWFuL2xpc3RpbmZvL2NvY2NpCg==
