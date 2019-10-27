Return-Path: <SRS0=POHO=YU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBB82CA9EAF
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2019 15:13:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DCB5620873
	for <cocci@archiver.kernel.org>; Sun, 27 Oct 2019 15:13:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cuUz2ywP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DCB5620873
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9RFCoGB012863;
	Sun, 27 Oct 2019 16:12:50 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4A96777B4;
	Sun, 27 Oct 2019 16:12:50 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3CDC277AE
 for <cocci@systeme.lip6.fr>; Sun, 27 Oct 2019 16:12:48 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9RFClgJ006055
 for <cocci@systeme.lip6.fr>; Sun, 27 Oct 2019 16:12:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572189167;
 bh=Dk+bShH4tlBM2tTJXXOyodwlSXkMGKGooGAZlztciAE=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=cuUz2ywPR4GFBy6l98BO9y8uweDX2nmNRHJHG9ma/ZNKbVqonccBqW1od4dyGmKY3
 lmZQD8KPlDDR3Tgem9Cw+lclhQnGawiqxJ67opIwMC6x1dsh+CVHNraxltC5brE5T9
 739NMvZ91lebZCtAqC1xmCbiHN9u9RUA9o1F5P08=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.56.174]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MK2JZ-1iNNAw0aEH-001TzG for
 <cocci@systeme.lip6.fr>; Sun, 27 Oct 2019 16:12:47 +0100
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <258d568b-2783-9f13-d84d-37a84150432b@web.de>
Date: Sun, 27 Oct 2019 16:12:40 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:v5VzvarqI9c7/ZbM6zWNvbFf4Zdd8hV8T+UFH22azam8EvoklIP
 +J+Xg6ZLf0aONdLJLovkLDABnqmh48r2fAtc1UuLY1W0OP9hDTVmpggccL/hT5NKtPEFa7/
 pzQfz4msOoX2WwqdJyuyUifijJAIu2LdZcI8ZSa1c5O1XkJhB770UQw1NC3M9AwSqUPu5zQ
 bA2/QrrfsiyBpaL43y4ug==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZTrjMEoFnic=:yu70/NUMtpH0aS8xuMKIpN
 QyXxYR15UutgPYpe1Dqo7U3AerRel/uD0vYm1j4bdfXZj6uWCemnH0ki9YH+WnnsxKtFsoTJV
 gApyVZx2D/k5SlM2dYa2AJsOLAziAVqbEFyWqV2yK8xR7WGP2Tq67UlugCY4VuPziPMl61lng
 PfFuzkq3N0H6NRFcL76eU1pBxG/zk4ZiekN9gW9aftAqEfHLvQFc1h892oMq0cEEQWl8H2CBU
 bWzhNwyYZ3gaJBmVu3lEIh8aab1kWCMlVrsv/juJlOgeZs/JPaXAP7JdaGCtWtO6QhSijT1L7
 Pr40EhJNEvvaHOkPhaavE6rTaknppH9z1tg7xB2XGIkFUmoGyuasEMvT5qZtSybo2zOb3HFKk
 yVAizJMKoot5GFtWWm8LmU9OK0VNmoM3aEhKyR+rQ4C/tF7CwhjKUEWDEWr9KJLZzslEfqBtj
 7mH+h19ISX+5gG4jbutLzHQc2wd2MVgHb+2ZU2mJN8tvcQ2+9WKuzrOCbflhlo5zDXgyNwd8c
 ucbsYrKdpC4hJrtCnYBZvWRK/cs2E4BtSaeHqYrknt6fj9rK8AIxYOtDQ4Hq+kU/ZJpkxFYUf
 Dd7ujb/IY7QvNlTkpdxgMoTEv9KAnkw02MJWg6C4wocKPVKeC0sV5JDoGM/tevMda5lHjmcrZ
 7S+IZRb/3/l9admhmNVQZAOLzol3bfs1KXFpGLt9b81sWXEXvz5lY5z5tBaanJGB1abYDLsnn
 8mL2bkajD6tAqesTsOyYDy1lDeLBza1MsRGJyFdgVt6DeqrzOkR60uFnCqO3MceEAqEF8cGk1
 QLMu3arImPUHd1dk+y4OwJJCATQOghKD5lw2LdfWBTEQvovSxBWdK5c45tpj0YdYr25Xtf1LJ
 /gEnMDW68QFgwp8+7HUYXIB3rLGRjyjb+vKHziR2JQRga1gKMyKYBt+l6KcH6sTqDamSPR1P3
 2jDLpqJDh/ya9pxfXfrVPYj9b7+HOregjLoh+LL4husg0UC7xgdWTZ8Hi0m5kz2n/Dq+Jt5RQ
 FyKa5dVMg1dSkrVETljQD97cD0DWjkh4b4kGhemla4kSrb8Bmu4dVM7WaVEwK7ZJKecU54kbf
 VnybaN/pBO8bzsMwPWT39d4C8k1YUM+7VUVRb14N73si+UCJSbYWeEhFUy63Mac4B0KSO0/Fg
 jfZTr/D6xMHcJUaHEszhtvj/LbzQZINDH57gd9OQcieAxD0um4BxGwg83hel5/0gwMpNMQHkC
 /kIpmXo9raHOR9sXBH+uvRQMQTAvBoQ0SMWc7C2ZZVc+KEaXgBMcJqcO9rPo=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 27 Oct 2019 16:12:50 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 27 Oct 2019 16:12:47 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Searching designated initialisers with SmPL
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

SGVsbG8sCgpJIGhvcGVkIHRvIGFjaGlldmUgc29tZXRoaW5nIHRvZ2V0aGVyIHdpdGggdGhlIHNl
bWFudGljIHBhdGNoIGxhbmd1YWdlCmJ5IHRoZSBmb2xsb3dpbmcgc2VhcmNoIHBhdHRlcm4uCgpA
ZGlzcGxheUAKaWRlbnRpZmllciBhY3Rpb24sIGRyaXZlcjsKQEAKIHN0YXRpYyBzdHJ1Y3QgcGxh
dGZvcm1fZHJpdmVyIGRyaXZlciA9CiB7CiA8Ky4uLgoqLnJlbW92ZSA9IGFjdGlvbgogLi4uKz4K
IH07CgoKVW5mb3J0dW5hdGVseSwgSSBzdHVtYmxlIG9uIGFub3RoZXIgZXJyb3IgbWVzc2FnZS4K
CmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9Db2NjaW5lbGxlL2phbml0b3I+IHNwYXRjaCAtLXBh
cnNlLWNvY2NpIHNob3dfZGVzaWduYXRlZF9pbml0aWFsaXNlcnM2LmNvY2NpCuKApgptaW51czog
cGFyc2UgZXJyb3I6CiAgRmlsZSAic2hvd19kZXNpZ25hdGVkX2luaXRpYWxpc2VyczYuY29jY2ki
LCBsaW5lIDcsIGNvbHVtbiAxLCBjaGFycG9zID0gOTEKICBhcm91bmQgPSAnLicsCiAgd2hvbGUg
Y29udGVudCA9ICoucmVtb3ZlID0gYWN0aW9uCgoKSG93IHdvdWxkIHlvdSBsaWtlIHRvIGNsYXJp
ZnkgdGhlIHNvZnR3YXJlIGJlaGF2aW91ciBmb3IKc3VjaCBhbiB1c2UgY2FzZT8KClJlZ2FyZHMs
Ck1hcmt1cwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpD
b2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5s
aXA2LmZyL21haWxtYW4vbGlzdGluZm8vY29jY2kK
