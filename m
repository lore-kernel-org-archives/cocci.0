Return-Path: <SRS0=hgwh=XT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8610EC432C2
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 18:33:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0FD7207FD
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 18:33:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IN9wfj8Y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FD7207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OIXECF028997;
	Tue, 24 Sep 2019 20:33:14 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B5CE377AB;
	Tue, 24 Sep 2019 20:33:14 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8CA49779E
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 20:33:13 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OIXDnE022887;
 Tue, 24 Sep 2019 20:33:13 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569349992;
 bh=QFv9XACBX5ZeQVPIhexyvTEUIlrQhwCc6flBemfIbU4=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=IN9wfj8Yewa9u4uyd+DJA5dUmQqFUw0F0Fjo3mpx3vFl8oIpSR+RzJavNNxZ89ZE3
 E+FEYWqcbL6nqSlNU7vrcRLYuJOW2q2CijLixG/4iPPJRZwgEsQvLDAb85DGyod9GY
 EvLXBzwVSsgZWdcqpndVjD59yOz54VDGy7QT48JE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.162]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MXHOz-1iivCH30hZ-00WB9c; Tue, 24
 Sep 2019 20:33:12 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <98c45e6f-d9a2-c8a2-1644-e530c1827971@web.de>
Date: Tue, 24 Sep 2019 20:33:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909231058380.2283@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:fFX4m4LHHAC286UaAjT8uGaaP28pBy2Lh6VEdiTIRbXPsEbh4vQ
 SnW8JkTLMK35PSeQ3+xAm1U6xKJ48CY6ZFH8oXh+i1f545LLN5zr19Z68/0m+tHQfHDGGC2
 7uSQ9JXkXtNeC4W8WD7SEFnahuCC+tEb3iq2/y+ubJYAMCjgA4gKPZelEUWRtPIFHdpW3pC
 SkPrDaWxdWKt0WPqsIMbA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XSE7xfryFNY=:Bw8ED7BkkNTSp5mK4IjFml
 rG9Gol6wbAxS9I9hfhwut40s6uNegqW4/b/Fp2l+ALPOysF4x1LR1FVTisnE7sDnb9l9lAf4G
 EguKnNBEPrfyFs3iycAHUv3VgxwjJGIWuWZEvdv1DL6uGK3iCNhrtxpsN9IoYQsYJMBkEj/RI
 gU7RHpN0lwP/0zbKk5oSjnky8aC5CchqBQ1YzmKt3XQ8eQeknIkaMhJaam0J921ya7Dfv+NdJ
 BZq/W6px2BvFgCCSUBFu0DCZ8O+LSlMhaxye9wzC8xPQD+VZSzq9f3f/yTu5EzynXugYu6Y4G
 0iL0Uda8BCRU1LjK0QI+oVJiTsFWW+/8uvFi4CYmZq3irnMjLlzHblzODjw9NilcV+/AyIJJH
 foEipkERDqcp6KC5OtmoQaT0rjpvHL2VpNA0SPzzGJmxAOmfxXoUHzCLHRkIqFEBiGjXAFpMa
 QjDU0wTQIiTvgstt/58/tgtPGEtOMkzl/osamv9dIA3JfbMCVJLN8ik9rrb9q1ipIkgcCXvFY
 EojAvpNZKz1jBlVr+3ejusfbfx/zFRS5mFrZ7wSNoY27YBwXlUxhgbBhThy3ZGuXcfn7pD4cJ
 DckscED3twgTfjlU78ePI/7uy6WiWNuO89Ug2kAXvW+jc0zlzHcVIVZoA6IZG5fQq+yY1LSkw
 VpSfFxT/ssAACphrZOs04UYqXIBDRu+P5YxAc9asuAu16SKdIUJ3az9F/GKMp7ghyX6Nhfx0H
 DstP1rBAPAMCNhX97BQuW6Ta2ftw4vjNGfr6oUrTZdl8OHeXH4wwxdIGYz4Oj2m2aoTXZBLDZ
 H04Z47kqYGMEFWa5XOOEhSCrfYZHFd0wWCinzAyUikuRPQxhr/3ik7bIU+xR10O87Cef7eVL+
 KwkA93sDldAUtXSY3iVziFGY/Hbe+d04Gwrbat/KxIRc0NizJit8PfCDh+GP5cxDJvtJFymNz
 8CeUorLy7S3o5vULPI327st4fxNhTc36HEQkzSnZlNm9ZVrvX34EByxfOQm0lqVGWgmEfl1XO
 UdYJrdZFuUdpWugJbZ54Nhl1OHE1S0K7iB1RGdojmBewmZQD0rhqx2Uce0Bk/FNqj1lSQeZfE
 SkCQDcy9nEpZWzvK7QrmkugHTYfNZeO47euK7V85Xv3X6/ttzPhPXmMpJsuI44CwRaU/ytsoc
 3uB8BDy9HWyKT+biYI/2s8Ff+bfosMyMhU0wNTGNhoDT5jIOwEv0JGBhc0/RotD3dtvP/1sFF
 BUSr6V1Xn61ZK8SUjack+M3yVK3YnoriWX6sg6VgQD9y0yGh16NLfvb3yDTQ=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 20:33:15 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 20:33:13 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reducing source code around return statements with SmPL?
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

Pj4gQEAKPj4gLXJjID0geDsKPgo+IFJlcGxhY2UgYnkgLSBscmNAcmMgPSB4OwoKSSBoYXZlIGNv
bnN0cnVjdGVkIGFub3RoZXIgdGVzdCBzY3JpcHQgZm9yIHRoZSBzZW1hbnRpYyBwYXRjaCBsYW5n
dWFnZS4KCkByZXBsYWNlbWVudEAKZXhwcmVzc2lvbiB4OwppZGVudGlmaWVyIHJjOwpsb2NhbCBp
ZGV4cHJlc3Npb24gbHJjOwpAQAooCiBpZiAoLi4uKQotewotbHJjQHJjID0geDsKIHJldHVybgot
ICAgICAgIHJjCisgICAgICAgeAogOwotfQp8Ci1scmNAcmMgPSB4OwogcmV0dXJuCi0gICAgICAg
cmMKKyAgICAgICB4CiA7CikKCkBkZWxldGlvbkAKaWRlbnRpZmllciByZXBsYWNlbWVudC5yYzsK
dHlwZSB0OwpAQAotdCByYzsKIC4uLiB3aGVuICE9IHJjCgoKVGVzdCByZXN1bHQ6CmVsZnJpbmdA
U29ubmU6fi9Qcm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNoZWQ+IHNwYXRjaCB+L1Byb2pla3RlL0Nv
Y2NpbmVsbGUvamFuaXRvci9tb3ZlX2NvZGVfdG9fcmV0dXJuMy5jb2NjaSBhcmNoL2FybTY0L2tl
cm5lbC9wdHJhY2UuYwrigKYKcHJldmlvdXMgbW9kaWZpY2F0aW9uOgpNSU5VUwogID4+PiB4CgoK
QWNjb3JkaW5nIHRvIGVudmlyb25tZW50IDI6CiAgIHJlcGxhY2VtZW50LnggLT4gUFRSX0VSUihi
cCkKCiAgIHJlcGxhY2VtZW50LnJjIC0+IGlkIGVycgoKCmN1cnJlbnQgbW9kaWZpY2F0aW9uOgpN
SU5VUwogID4+PiB4CgoKQWNjb3JkaW5nIHRvIGVudmlyb25tZW50IDI6CiAgIHJlcGxhY2VtZW50
LnggLT4gUFRSX0VSUihicCkKCiAgIHJlcGxhY2VtZW50LnJjIC0+IGlkIGVycgoKCmV4biB3aGls
ZSBpbiB0aW1lb3V0X2Z1bmN0aW9uCnJlcGxhY2VtZW50OiBhbHJlYWR5IHRhZ2dlZCB0b2tlbjoK
QyBjb2RlIGNvbnRleHQKRmlsZSAiYXJjaC9hcm02NC9rZXJuZWwvcHRyYWNlLmMiLCBsaW5lIDQz
OSwgY29sdW1uIDksIGNoYXJwb3MgPSAxMDA4NAogIGFyb3VuZCA9ICdlcnInLAogIHdob2xlIGNv
bnRlbnQgPSAJCXJldHVybiBlcnI7CgoKCldpbGwgYW55IHNvZnR3YXJlIGltcHJvdmVtZW50cyBi
ZSBuZWVkZWQgYXJvdW5kIHRoZSBhcHBsaWNhdGlvbgpvZiBTbVBMIGRpc2p1bmN0aW9ucyBmb3Ig
c3VjaCBhIHNvdXJjZSBjb2RlIHRyYW5zZm9ybWF0aW9uIGFwcHJvYWNoPwoKUmVnYXJkcywKTWFy
a3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCkNvY2Np
IG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9zeXN0ZW1lLmxpcDYu
ZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
