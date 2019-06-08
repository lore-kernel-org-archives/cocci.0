Return-Path: <SRS0=nmSZ=UH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56316C28CC5
	for <cocci@archiver.kernel.org>; Sat,  8 Jun 2019 07:50:26 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4A3A92146E
	for <cocci@archiver.kernel.org>; Sat,  8 Jun 2019 07:50:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hJ8+aqNz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4A3A92146E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x587oAlf013513;
	Sat, 8 Jun 2019 09:50:10 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 281C17760;
	Sat,  8 Jun 2019 09:50:10 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3B138775D
 for <cocci@systeme.lip6.fr>; Sat,  8 Jun 2019 09:50:08 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x587o7QB026165
 for <cocci@systeme.lip6.fr>; Sat, 8 Jun 2019 09:50:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1559980207;
 bh=+kLZ3UykdUOsfqqvpifd5c6nIWrxn8gSgx9Sx5Uo9so=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=hJ8+aqNzrUBUoqneOzlQHRVOzPiuym3b3zUw0unf3TzAKNucKMtEp6/yc1NTVx8Wg
 xhR6uYypEykCeng2LfHlcr0gcZ8tejBH2KGFSYs7ucnsQGbtcr0y1y8nArE2cXyo9X
 HSlFRXfacRSJy0w+Reyg+EpXWp80070URrclYYow=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.4] ([2.243.189.212]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LmuQW-1guyAN0qmi-00h6J1; Sat, 08
 Jun 2019 09:50:07 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: cocci@systeme.lip6.fr
References: <5c138195-ac1a-4ad6-c6e6-720acd4ea34f@metux.net>
 <111faed6-ada9-63d8-b09c-2e6faf678351@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <e0e5dddd-7f86-ab1c-980b-10ed7f4e9aaa@web.de>
Date: Sat, 8 Jun 2019 09:49:57 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <111faed6-ada9-63d8-b09c-2e6faf678351@web.de>
Content-Language: en-GB
X-Provags-ID: V03:K1:3K3HTZoDnF6mZ8p+V762ZU+WfU9cD+f+VbDT29EE7iPp8dH5acR
 PS7F2+4PlkWMdr1thqO7f1uU7RM/fQ91zJgtzXB41d++9zE8eVGQhS3fOTXfSQgoGN5RXLh
 TZUZVdwGsfakUj2xJbq1nBotMja+mjjSqkreHyDX4Dn3m1biz2+od+lq9Hr2Vfgyb25mgic
 9kpbLIoF4mCYbJefySnsQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:5JVcpplL2FA=:pD0h+6aQZiqnwGNg2QinyW
 E+SQongfTxNOT9q0G84NRCth73QkPGQ8Uh0C0qM/RDzs1pf8154MK+JzmJvROQetimrZGeqIY
 wFsrn+rqt+/0F4G3FhqKRt14o5fHHfvPr98sk3irzohS+uQjrON53zq+u9YAOuDQnlIKL+xeh
 lcZ/IkJX60EffuMeTJgQh9T7pt5n916GrKin7M+J0kK/cX0s4fdx9PnAOymGb5DR4zywbQtza
 Nn/zv9ODGT06a1eSbvGDnQT7yCvQhcyn3OI0I9cx+oillHEugT6FGNdvcZa1hXJDqGfV1IgPm
 46+k3NrHmPtIRWEDNB/ysbUZC+nba2HCl+sifYphCF2Z60PXGecjS62NH6BrtiVlH50lsFJoC
 jFDIhFyxNbntoatsAs6SQWZoB+GpcA7QmcC/DAeqDF9CSY8gn2PFWdLqtUEzw1ANBIDLtYeGU
 ok16FHhyI6h64zP2GLNOnSVKAoz5Ntu+Kv750MAIssCCgCWw/BP5NID4kjlagHrS8dzkaXRBZ
 ZtzdkpEENhCs+VHKSP1kIyltgeNLzTbN3ywum2rjO867BEgKaIkI1/crTbDchObqEDBFYJqu9
 nFX3Z9jXc+s1js++MneKQYjOF9OcM5epLPu59iHuEyOeYkhdyvaWzLrFxd1NtvUF+a2do9r9n
 U80cl5elUaxp0DZQ8FYrX7Yj7RTgg5wiodX2V83efm/NzIOrKflk44aE8Vr9ArLnPHnFb+gk7
 hNjzFyS5daW46NBD4+lxMOhGky2UgW6P7nP8rEqmclm7FE7IDcbsqN/OHqFFJgPkpudrnn46M
 fcdgB+a/oMMl6WZf/urMxDVAJMSEeBS95eZ4QIaitSxygyk0FoHsawXYHjuHrveIbVuQd6xSu
 f3RZMqYRhCTHBWU+ue5UwUCOIcrjIbbKZXRFL83j9Biekbm/a6OflmSHZ/xZ2Pnd0YU7P5MvU
 D4yyGre8BbcB+i5NBbdUH8wutzZWkk8xC5uFFqTTAeK1RaP3CupwJxTq58HAB6kroo35nbTLp
 KQ==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 08 Jun 2019 09:50:10 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 08 Jun 2019 09:50:07 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Handling of designated initialisers by SmPL?
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

PiBXb3VsZCB5b3UgbGlrZSB0byB0cnkgYW5vdGhlciBTbVBMIHNjcmlwdCB2YXJpYW50IG91dD8K
CkByZXBsYWNlbWVudEAKY29uc3RhbnQgdGV4dDsKZXhwcmVzc2lvbiB2YWx1ZTsKQEAKIC5kcml2
ZXIgPSB7Ci0gICAgICAgICAgLm5hbWUgPSB0ZXh0LAotICAgICAgICAgIC5vZl9tYXRjaF90YWJs
ZSA9IHZhbHVlLAotICAgICAgICAgIH0sCisgICAgICAgICAgLm5hbWUgPSB0ZXh0LAorICAgICAg
ICAgIC5vZl9tYXRjaF90YWJsZSA9IG9mX21hdGNoX3B0cih2YWx1ZSksCisgICAgICAgICAgfSwK
CgpIb3cgZG8geW91IHRoaW5rIGFib3V0IHRoZSBmb2xsb3dpbmcgcmVzcG9uc2UgYnkgdGhlIENv
Y2NpbmVsbGUgc29mdHdhcmU/CgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvTGludXgvbmV4dC1w
YXRjaGVkPiBzcGF0Y2ggfi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL1Byb2JlL1dlaWdlbHQ5LmNvY2Np
IHNvdW5kL3NvYy9jb2RlY3MvcGNtMzA2MC1pMmMuYwrigKYKbWludXM6IHBhcnNlIGVycm9yOgog
IEZpbGUgIi9ob21lL2VsZnJpbmcvUHJvamVrdGUvQ29jY2luZWxsZS9Qcm9iZS9XZWlnZWx0OS5j
b2NjaSIsIGxpbmUgNSwgY29sdW1uIDEsIGNoYXJwb3MgPSA1MQogIGFyb3VuZCA9ICcuJywKICB3
aG9sZSBjb250ZW50ID0gIC5kcml2ZXIgPSB7CgoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApD
b2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0
aW5mby9jb2NjaQo=
