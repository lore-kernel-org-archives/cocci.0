Return-Path: <SRS0=Xu+Y=BF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54072C433E1
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 14:16:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A25AE2070B
	for <cocci@archiver.kernel.org>; Sun, 26 Jul 2020 14:16:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="EN2MsiN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A25AE2070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 06QEGW87003846;
	Sun, 26 Jul 2020 16:16:32 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2E499777B;
	Sun, 26 Jul 2020 16:16:32 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id CD3143F6C
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 15:52:22 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 06QDqIeZ020218
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sun, 26 Jul 2020 15:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1595771537;
 bh=gMIDRroIJTtDQvx6AfMCih/+BdE3UFkKCmIf50fa1SU=;
 h=X-UI-Sender-Class:Cc:Subject:To:From:Date;
 b=EN2MsiN+ZvVof9BfWTel6E6M2nKRmhNCxHKAaEDbTiioLRs9z6sdW48mmyjjn1tnj
 IxKqlWcJzkk5ErReufsTRmSlkj9AsHwyakqZfJHeOBZID5o6D0PTkj6LM2ZJEBvKlU
 SSk4YG3wq2+RX9U/b6X1gZtCuApYJuoJ9TGNaGi8=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.103.185]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MHuv7-1jw7Ey2vkL-003aLA; Sun, 26
 Jul 2020 15:52:17 +0200
To: Jaskaran Singh <jaskaran.singh@collabora.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e0df5e31-bf24-0876-f485-e274db6000aa@web.de>
Date: Sun, 26 Jul 2020 15:52:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:EIxflP/VhCtD3S+KGFT6F80oNxql1B5R+tJiY1MEjBm6wcm/Fat
 bbnbZcxYiO2Q51cNWXX7bkm9JwKIM7B9UqSv17v/twNkM/zg3X6+9CP2V8G6pV1q5+KqhVn
 fTfWc+xu79jmM5D+ZJTtegTxhbgF5hRfYm4tQ3FYLeF2LbbE1DC56FLLKb/IzHCapxBdWEu
 BkBdwWIlWDyMzQMsyzcuQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:9KJAwdHtaUQ=:Va4HR1/tOhCj7RAHYXlp/p
 WKmW1H4EP393YjS/yY/IqSYt5zoXS47g72Vy/yB4qKaZ593OtRR9fSxvKt1SYwmEmmIKV2zNP
 ATlC4m6Ll906LqNwxecI/1aG6rSVH9LqPfcA3dcunNINWRq0sJ9k1eCS78wypfrlmW813fx3a
 yDMfAuEszxOXJLnExZMKKzQyxm5I6oSKppl6STdZ0FgSuVLNW57GEfQgAOaGPNGWNWlQsYpK8
 yFXIbQZHtEmPJ0VJKcFYTkWZiY8F9OkoO9lCNPFDofHW3Yhy2wPahqiroACcbCkiceVSz9kK8
 gdYnXY/IX64r9Ni/jEOMLCVuOiaEQE4SmNaB4DL/tCEqmTS8bsGJiCgA5tgX5NERZEEyREB3y
 EJ6AZE/v795zcYkLm3fEIpaUxgnf0zkLVePov+a8W89AqIOKyYLfaMSksa+MfsDvJwGM04lyL
 hvxX4moscC5CVcUjc2LS+uPdbbMWClqwpsaKXeZWeju+cp3Udj1limAwZvfzGdWBLKiNW2tGq
 EKLZ+wQQQhjlMeFGsu9fwxQ1aB/Dykfcb4AG30OUeasE+FKXeJckH4nJ7OREGUhS42wz+puHy
 DGf1wLOt9y+Tqzd526aWixDVtAjN8pST6w4JuAIirVYkrp6Ad+HSHJkDk8Yfg8pgKErZwkY5e
 vspjRDifORTX5U9ZP2Xx/7AuTs0DQWjfmoYXQFDEBVdQ1+yN6GRl9v87mVVKsm0eTUxDWtBQG
 7OhA0W3c3L2kTlfupAW82PnP39QRU7oNcz0HuWcPCH+Duf0q4SGq1++XaJju5JijMF7De+yIv
 2SN0J8R4ScEkuF7gjS7RQiBP6wsW1ASQFdPLunsNwdRZhUaDsLeWyrlsKoNUVqGtd6F9WfQII
 qjMJwvnhKASXQH8vy/uiiDQu2Ejcuvf98CWzk0Ob+EBgsomM3c6HyscZbFZ4LfQlMITkceGUI
 JjzSbs2Vjs7OZW1xZ1AwSAd9NkuGQ+rvBe4FKH+JRiULvpe0G9lynyQQ+oGOOf7u7A01ZDWCJ
 XOLEkpOPgEccJrVO55ZH5XbC7UWACP9SQCdBIh9JsvE86kirS1j6NK9evtXYglhvhVgXKQmhb
 x82TTJVkDMMfWEF/8jhjL605TKAQE23fEJqLT3sVbQIknTJD5rhXT6AdnfJrDvsiRUvj9wc8p
 jWbNURbPRk4PscvdohjvfD9Nc+GpdoPWQC6MBSaaSxAicJuGTDcEBeq1QjIVEAn/6Jbu8zQlf
 yDUAk9laPZPx0T5jbiOJZNUeSZjdy47jZhja8kg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 16:16:32 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 26 Jul 2020 15:52:18 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 26 Jul 2020 16:16:30 +0200
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH 42/43] tests: Add test case to match meta
 attribute
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

4oCmCj4gKysrIGIvdGVzdHMvbWV0YWF0dHIuYwo+IEBAIC0wLDAgKzEsNSBAQAo+ICtpbnQgbWFp
bigpIHsKPiArCWludCBiIF9fYXR0cl9fID0gMTsKPiArCWludCBiID0gMTsKPiArCXJldHVybiAw
Owo+ICt9CgoqIFNob3VsZCBzdWNoIHRlc3QgY29kZSByZWFsbHkgd29yayB3aXRoIGEgcmVwZWF0
ZWQgZGVmaW5pdGlvbiBvZgogIHRoZSB2YXJpYWJsZSDigJxi4oCdPwoKKiBXb3VsZCB5b3UgbGlr
ZSB0byB0ZXN0IGhlcmUgaWYgdGhlIGlkZW50aWZpZXIg4oCcYuKAnSBzaG91bGQgYmUgaGFuZGxl
ZAogIGFzIGFuIGF0dHJpYnV0ZSBmb3IgdGhlIHZhcmlhYmxlIOKAnF9fYXR0cl9f4oCdPwoKUmVn
YXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0
ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
