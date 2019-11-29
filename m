Return-Path: <SRS0=mX9+=ZV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D165C432C0
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 14:48:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA4C621736
	for <cocci@archiver.kernel.org>; Fri, 29 Nov 2019 14:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="no1FfS0+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA4C621736
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATEmOJP003555;
	Fri, 29 Nov 2019 15:48:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2796D77D4;
	Fri, 29 Nov 2019 15:48:24 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 6FF5577D2
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 15:48:22 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xATEmL2v022917
 for <cocci@systeme.lip6.fr>; Fri, 29 Nov 2019 15:48:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575038899;
 bh=sNJkLJTbQP9GhTaCkH52ykCHiGRcqnkbfQ2G6OU6gy4=;
 h=X-UI-Sender-Class:Cc:References:Subject:To:From:Date:In-Reply-To;
 b=no1FfS0+elWFEUxgprz9MTJOZFOqiQmkA+L3xvhZhlTjfgnDkivaEfMFbH9Kl3urV
 ldfDXDkCwlCuAZfbKN0voD5diZ8AdrtWL/Ex6ET6P7OcY7J1aEK8UoCMVpaFTL2Ivh
 ePXH7dtuEKTtfxZL0WV4r4ZSYcNBuqBAeIkFbxaI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.90.162]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Maayz-1iL5Sc2YBd-00K7IJ; Fri, 29
 Nov 2019 15:48:19 +0100
References: <alpine.DEB.2.21.1911280807030.3704@hadrien>
To: Julia Lawall <julia.lawall@inria.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <96e6a3b5-0d84-38d8-35d8-9d5bc6b0dc26@web.de>
Date: Fri, 29 Nov 2019 15:48:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911280807030.3704@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:qDH9/S0+Y5QoMIgxPD/WTCGU0kjBAben+Drfy5C6xVlSmCDdL3l
 SLPdciIPaeHXq6udorxSbgo0JdbNPyNMtKk5wRSQ9JanwO25QDtJUALNT8hT5J/5SOErbb0
 s76OQFf6MZnc9DpqD2HTBmrqsLShz+q+oXX/1KkRscgNwVmJS7du4vLPVP7QsB6aj7aKo6w
 1WYK1JLR/JMW5O2As/CXA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:PPQh0Zfjhsc=:hYz7JpzmaP4AsWj5gSjOn2
 ZK3RvXd7ZKEZ8QaXjwx0pcxhK1Xi9Ur3LjOI1OJeOT83pLvKKCUgMA2RUF+G+KPJQ3d/E1Dq3
 XgtxKE1ThfX6/E5CxyPInvkzMAV8aT6/NAEbp/mN2OPa/EnL4xzYaXvksoCV8wdbzd/RWaJQI
 t4M/IzAhiEYjy5XV2yLsLJHCCx5FWuBBy5rTJVcrmZNZ9vhZHeqk0YMF/EPjRKGYvdVHJR1Rc
 jpop5oNdM7Lvpt7sl/1lksCxPsYf62xF+m3fREAySE67lwjDJ/fQx7EokRxFkho8Sv3jzetp9
 mLXTNvJmSAHfiwQgxUafOM2GbqpP8838KgB/T8nczkpKIgmXCrYlm7VczWV3JmerTOYcyN1N1
 ELacN9amXXyjCgBgXV/jSxbl6LEEB4bYMZ+jta0EJODxG2VMAq1b2tCAO//FLXmcwcZl55PPa
 bNwjXhLtMjX0rZSe/N4HXllZ6fvr72P7M+QFcmPx3haFgyioH48GfLTdkqbamJu5HfCsbntzc
 K3e08kf8u5MtR0VnMqAVADkGGMP0ir/ixjds0see/JbebVKbO9TxqNjorp3VoDGVmT86TtHAx
 WLaPzBZRcUyjMRChuOAWBRhu5AMwPxxIlMjhZWb69E3ILEcDXG9wkQ4zO7pAMbtXHk4kMGR7H
 kaxWzPN3qXhNRbsFA4/0FJ9g4Cu74gt1N6wmp27wCJA4di1WbUgONYDFC/UqjIlOWr4aeTApn
 PAiubW6KvDWVYQ8cbnx+8z0MaQuIQH9okuEiUIJrKJf1VPxSD13I5XOy5o6LUTaRHGP4be3+F
 EE3NKQ19pX5ZSfnevV9ottB8xKj1fsFJijwMoxW0PFEksKCKrHE6V3cha5auboV96ZAHlQAAZ
 V6Z33qOR9W560ChZP9VI6yHc5hFcx8zKRC34My81IR70ODG9+LR7rpKZL+5nb5MyIHAZxYnvC
 KtpUbhYjYYClQG/vCjSt2Fr8TkRDMAhhm2ToygAMjD8x7nkFe5CGqjv1Rm3w4/BwhNCWufFxc
 Bt99eYHW8P2Opb84MjCeaw4i8tT32O/0JdoqtDVHr8N2pixwphMJY1lrBxspOLtYdBWGyP9vo
 dTW0VmW8N9DN4HN25uqPjJxkF7x3I6O48I9c++Br4/0ZpyMYLz8lRBWLrAeWNwmGqk+KMECxt
 EcKhKCBJD9IWUWlK/TOuwN+G9f+yAsCBs38aorD+n2/8Kr5HNjn0gkrVgC33q96DjOveOPU0f
 CugcdPQfMUu5M3pGKIcKngkbBwuwJhoUBxfY8YZ23LF7yUv56gpv6/xXVmWY=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 15:48:24 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 29 Nov 2019 15:48:21 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Replacing printf() parameters according to used data
 types
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

PiBBdCB0aGUgbW9tZW50LCB0aGVyZSBzZWVtcyB0byBiZSBhIGJ1Zy4gIEkgd2lsbCBjaGVjayBv
biB0aGF0LgoKSSBhbSBhbHNvIGN1cmlvdXMgaG93IHRoZSBzdXBwb3J0IHdpbGwgZXZvbHZlIGZ1
cnRoZXIgYXJvdW5kCmFkdmFuY2VkIGRhdGEgcHJvY2Vzc2luZyBmb3IgZm9ybWF0IHN0cmluZ3Mg
d2l0aCB0aGUgc2VtYW50aWMKcGF0Y2ggbGFuZ3VhZ2UuCgpDYW4gYW5vdGhlciB0cmFuc2Zvcm1h
dGlvbiBhcHByb2FjaCBiZWNvbWUgaW50ZXJlc3RpbmcgZm9yCmEgY29ycmVzcG9uZGluZyBjbGFy
aWZpY2F0aW9uPwoKQHJlcGxhY2VtZW50QApzdHJ1Y3QgbXlkYXRhIFNNRDsKZm9ybWF0IEYgPX4g
InMiOwpAQAogbXlfcHJpbnRmKCIlCi0gICAgICAgICAgIEBGQAorICAgICAgICAgICBtCiAgICAg
ICAgICAgIiwKKyAgICAgICAgICAmCiAgICAgICAgICAgU01ECi0gICAgICAgICAgICAgLm5hbWUK
ICAgICAgICAgICk7CgplbGZyaW5nQFNvbm5lOn4vUHJvamVrdGUvQ29jY2luZWxsZS9Qcm9iZT4g
c3BhdGNoIC0tcGFyc2UtY29jY2kgU3RyYWNlX0xhYnMyLmNvY2NpCuKApgp3YXJuaW5nOiByZXBs
YWNlbWVudDogbWV0YXZhcmlhYmxlIEYgbm90IHVzZWQgaW4gdGhlIC0gb3IgY29udGV4dCBjb2Rl
Cndhcm5pbmc6IGlzbyBmbGRfdG9fcHRyIGRvZXMgbm90IG1hdGNoIHRoZSBjb2RlIGJlbG93IG9u
IGxpbmUgMTAK4oCmCgpSZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlw
Ni5mcgpodHRwczovL3N5c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
