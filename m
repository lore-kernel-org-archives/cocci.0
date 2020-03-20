Return-Path: <SRS0=15MF=5F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90504C4332B
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 08:01:39 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1034C20777
	for <cocci@archiver.kernel.org>; Fri, 20 Mar 2020 08:01:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="ecmddFE5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1034C20777
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 02K81Oub014397;
	Fri, 20 Mar 2020 09:01:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id E5018780E;
	Fri, 20 Mar 2020 09:01:23 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 303FA3B93
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 09:01:22 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 02K81LHf028783
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 20 Mar 2020 09:01:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1584691280;
 bh=l/0r93W5tS1co6cOx8bovFrGGfvlq66a5j4gHLk/xEI=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=ecmddFE5JnHQjmke0H7AaEIOeBzxgLyMzqDEZz9Gb0+o+Eu6qoxSokGYnYO3Pk3FI
 Il7dlcRyAf3YwZZiCrkG6GJYbsL3xaRZUHS7s0dIXhaAlfkdYwmhEP6JKx0b11qLy+
 HTxZqm0v+9mFhZONEpn2MB8z5O0VN5t7kjqQlSWo=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.75.57]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lx7Ab-1jM5RB0xrt-016j2Q; Fri, 20
 Mar 2020 09:01:20 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <3a2d554c-4da9-ee52-4ff8-3a115896ea6c@web.de>
Date: Fri, 20 Mar 2020 09:01:19 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:iCGr5/aWuEWdkXgIcZRmlt652J3KmrJWsN2VzyinFBpZqa3WSX9
 Qyv6/PjYy3IK3Q4T7fqJis1teyBZ4IzvYJmLpZcsZvu6sLExD4mSvcNcYZnVBoFJ9LwVYzl
 L9IO0HYicFqeVBzBHANnDUszJCdRSMYqnBTXlzSVYFokqPzrTBxzzXKsj1eF9A630YpvUPz
 8oV60aU1Cl8qDShVZ0sZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:lp6FozVpago=:865lMskQkI5RWMwKXq8/0E
 CC5PJpcd0BYDzkWXxWkTWOABSq0dK3WBKkDyfANUhn/DX03kEaSx5m4UjQZzEeDR97mpL19vJ
 KDSggbDxu3Jzp/eK6ngzEhmtYa8Hc8hX+8q1Vbx1hfzdVrLhZmguDgAmieSiAMdaJ8oSiex2T
 xDig8asoMwyvYs+vBazXY+e0nTGfzc57DOMY0ww3nZ15z6sWXKLKxz9+D2NMUBNZsS2S8kNXS
 JYC5qsJCdtef1bToozXVXzqzmv5yIp7iQv8Zh0G/AltP+lE2jNeXIwG/rTJoI4pslZk4z3r9n
 q1p8QCjt54xLRd5ywwpAQTh9yU3djwbKzg+voX3vgeyI+LTypugsKavdEOLn/PA2hQTNfvO+2
 z0wE9RlCuhH7A4CKOFBU5JD+azybthCcfsuHolusHxHw0vCPOFXfG02/YTEWAa9iH0M0daA9t
 RBhbJlM86uQdNGi+j86MWYkGfBawg2yIrAPiWh5sbPQ8qmnHLuYVHO+PK5ra26B16BkPM/v8o
 wRh4LwVSdTd6OGsySbAdACTU7qcEC87NWojRwUVoV3Yj6h2MiVkQDE1gQEt6xgXpeM17MxXOG
 6plLdCC2wCcV6BeAjwk1oMhlJtF9Yj3sDfPRsTapisFcFb6bUzSpnaw1owvMn49vWTlT6s5kt
 YLjowQ0uCFtGOIja25rzfvbgbzTg60VUChOfsLCTLAJlmebTozG54taI2WLroAcNmUYyCKdZU
 F5Ks3OpMafmcxNMm4mWKbGEtU0RDNKpkgb0oGEhC20fubrlWfhptj+iTBP7F5IRsoMKo7kkMM
 Me7zp2g8+cCjXRoAe19jByiL9pJf9d1ziMjfPfN4O7XwyMDmhQF8z6OcSAYXaDbJ8beGCF1Bh
 VTYyYu/civGRFTsBE8w63udY1K+mH9eMs0jglBUl9mqH1CyhuPa5HrY741tmjKIfDBv6ncm1J
 R8cVsP6o0SFT03eOIW3UHWIzq6aq1M+Db5qqJWrcHsbM25SzY0XamjcmzsO5g8IT45ISVF0Ha
 EauzRFMZfDAlAeKlp/ru77IiqTg11iic6COzS7Myd4JvmJC3qydoeMum9pRuEIYFl+BNigN/S
 VVbdX9DRrPYRiALWxGbeC8CYYUh7SXB2sNQgDTYXr1id763eJvefECip4MV5ZCF/FcO1zuc6r
 NkbhGMP+NRLlqgrnpy3myARzYJpzaLCLepziM5MAAvhyIt71BnduDE6DGHKVp3LtHdAF/22EG
 G8tvOkzXh2ou6yKGh
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 09:01:24 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 20 Mar 2020 09:01:21 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] [PATCH v3 05/26] parsing_cocci: visitor_ast: Add cases
 for ParenType/FunctionType
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

PiBUaGUgb3JkZXIgb2YgdGhlIHRlcm1zIGluIFBhcmVuVHlwZSByZXF1aXJlIGltcGxlbWVudGlu
ZyBhIHNwZWNpYWwKPiBjYXNlIGZvciBQYXJlblR5cGUuIFRoaXMgY2FzZSBoYW5kbGVzIG9ubHkg
dGhlIGZvbGxvd2luZzoKCiogV291bGQgaXQgYmUgbmljZSB0byBtZW50aW9uIGEga2V5IHdvcmQg
bGlrZSDigJxwYXJlbnRoZXNlc+KAnT8KCiogSG93IGRvIHlvdSBkaXN0aW5ndWlzaCDigJx2aXNp
dG9yc+KAnSBmb3IgdGhlIGFmZmVjdGVkIHNvZnR3YXJlPwoKKiBJIHdvdWxkIHByZWZlciBsZXNz
IHJlcGVhdGVkIGNoYW5nZSBkZXNjcmlwdGlvbnMgZm9yIHRoaXMgcGF0Y2ggc2VyaWVzLgogIENh
biBhbiBvdGhlciBwYXRjaCBncmFudWxhcml0eSBiZWNvbWUgaGVscGZ1bD8KClJlZ2FyZHMsCk1h
cmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2Nj
aSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2
LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
