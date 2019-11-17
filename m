Return-Path: <SRS0=ScdY=ZJ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08C2C432C0
	for <cocci@archiver.kernel.org>; Sun, 17 Nov 2019 14:46:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CE16E2071E
	for <cocci@archiver.kernel.org>; Sun, 17 Nov 2019 14:46:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="eetYTiPM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CE16E2071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAHEkYfD005151;
	Sun, 17 Nov 2019 15:46:35 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C646177A5;
	Sun, 17 Nov 2019 15:46:34 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BEEA27705
 for <cocci@systeme.lip6.fr>; Sun, 17 Nov 2019 15:46:32 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xAHEkW79002677;
 Sun, 17 Nov 2019 15:46:32 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1574001992;
 bh=7SY3ddrm/D0WYFbOFx946GObQ88yFDbtTp3D7mkm5Uw=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=eetYTiPMRQ6LdxqI+Vr52BFVkFWudGaUnvrQ5Cz8Horw6BHXEs3R79+EPX/oJ+dn5
 yIbhXFkum2Ne07qtqJsfqdmUOGgkiWlFwHsxY3FSRgLuRZqkxtZVhk7KMbWEGdloTM
 C9lh64lyi5hhRCJsEx6CNl0g+XcJHv82LzVPvpHs=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.59.42]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MBkPj-1igYZE3OSN-00AjSf; Sun, 17
 Nov 2019 15:46:31 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <87018ba7-e8ac-8b46-e082-c0c9ecc20624@web.de>
 <alpine.DEB.2.21.1911171320530.2641@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <4f6ed96c-9439-c060-19eb-75a7151d5823@web.de>
Date: Sun, 17 Nov 2019 15:46:30 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911171320530.2641@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:illkKHY2wvVsSX7QXZRJmm/F8o+D+AdAV+GfwwwBRkiQtVKlJZ+
 jmgYEEjZGnYT1ig+8d+/bKD8qQ9aJ+VM9bPAfMjz+EzQ66iKduXEivWrKsKitjpY+jEgxdd
 pK3sDBaz7WXy3CranzLmYu4bz6Jrru6QN0AhPNjKc6bBZ/cWMQwKha+0yyN++Rj00bVJyru
 +b1zqeFx667iSmYmlpzvQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:l16nde3HXVY=:/8U04+WFnxrwN4F1ti6VfK
 1QNkjw/COFDSL9ok3hjj7Hn8DfW8ujQXY2V4cL11LRMwU8e5dwgjopqOL2E46O8YV99ZwkrTI
 cXzmq/AEQLtDceMJmADL4EHBfAOubxUwWgQqXW78kWCipsLjqcdw00kxVq1iqw1pt+Mnzd7G7
 WazctljfpB0+FG8pFFHDGhqB5WO4G6ZVxwVqgNwVfyqo536cV4JzkjYpAEH+XT6/ntaVCexjH
 A3P5n3yOKplaait4EPggL1dD0g963yWCYp7K3Ii7281Sf27yffQJUUYSa5KTCMKmdn+6PHjl6
 s48sLkrxyeNACtf9+Ex7Is5YynkKgpMjpNt+KBrMrdrQLxeaWa9zP/OxcO0gPN8hrWi3AAM09
 b3JV7v/vwr1ILRPLTQE6PuzAW8wVD4+eIX1Of2rINorISBV8/soPhYdgeIF9y/yuEipETn0RR
 9HpK795KnSioMhUetNtg3/qyIJy67B5QZGKoYxtzDefbbeEhDqzUMk/l8pu8N+B/EcrZnmAqX
 k+4DdfyoBh3LtBUMnMkgD2CIkbRJp4r/H4n7ku0WuPGOpWxOXQVeDHWnRvyhDFwBRe/MX8Sxn
 pAXf98nC24m/2Fw3HuP8MJdzANsDWxEpZWnPMRVlJbiqZKt3HeW42fbBsivUWNyeQnXLfS/2L
 Z5mU0ztnZKN15tZ0ZgOqYXm5JQhTL81xzYEr//GrCi4Y8+3D5El5NyZWcw64TiI6SjU8BVX6u
 RUzHsQyol9pKJYSrA1wRTQM+6myvMFyuWLZPIkIzeQ/SuxcyMMU5D5WsSpsjCu8+zHzzc+hlY
 Q+whjze/Km8KcT9LxkoX2m5Laa5PisPSVwv6QQ/Hts7Qvbg3HlArCuj+j/PsSqC1fPsph/Krw
 JP/O6yvnMUhBMbK8mhQL2TbBCDobqnPyJF5h9OmbqfMIenBtNQza5ZYN6WoQI3WCOzDL4dK5W
 3YouLsfqsaDowTyrGnao/ZhuGgBwbXHPAkH/4jh43w/sVkdCKDIvVWprLaFbVlZPTrfadbbHU
 izNEJUW3fH1Ixeuuok0mqHIQxpWJjpZ4rvoQeaDIDqIAXXW6q7AZ//RPLDhIqKmmpxL9y8gqu
 KfjIoXpyCM9qlMyodJq2IW7JjJx5kiyn+PO2qIWsgw3yHzb8FSHjOnNrVLD1uymKYN1NRsMnh
 HK+e1/7i9K673LFTrOxWBc+vPkgpLJskiwrny9tp/y9oTvYqE8cK/rViklbA5HtYDIPa/eRLD
 iDZbel/Sv2Dxu5OXfr7jSekfKmBAAAPB34HpwiiwKWXfEtqOnp2/HhSCTJx8=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 17 Nov 2019 15:46:35 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 17 Nov 2019 15:46:32 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking size determinations with SmPL
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

Pj4gKlwoIHNpemVvZih0KSBcfCBzaXplb2YoKmUpIFwpCj4+Cj4+Cj4+IFdvdWxkIGl0IGJlIG5p
Y2UgaWYgYW5vdGhlciBzY3JpcHQgdmFyaWFudCBjYW4gd29yayB0b2dldGhlciB3aXRoCj4+IHN1
Y2ggYSBTbVBMIGRpc2p1bmN0aW9uIGFsc28gaW4gdGhpcyB3YXk/Cj4KPiBOby4gIFRoZXkgYXJl
IHF1aXRlIGRpZmZlcmVudCBiZWNhdXNlIHRoZSAoKSBpcyByZXF1aXJlZCBvbiBhIHR5cGUgYnV0
Cj4gb3B0aW9uYWwgb24gYW4gZXhwcmVzc2lvbi4K4oCmCj4+IEBkaXNwbGF5MkAKPj4gZXhwcmVz
c2lvbiogZTsKPj4gdHlwZSB0Owo+PiBAQAo+PiAqc2l6ZW9mKCBcKCB0IFx8ICplIFwpICkKCldv
dWxkIHN1Y2ggYSBzZWFyY2ggcGF0dGVybiBiZSBhY2NlcHRhYmxlIGlmIGJvdGggaXRlbXMgd291
bGQgYmUgaGFuZGxlZAphcyBub24tb3B0aW9uYWwgc2VsZWN0aW9ucyBpbiB0aGlzIGNhc2U/CgpS
ZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
