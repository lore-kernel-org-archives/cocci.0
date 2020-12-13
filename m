Return-Path: <SRS0=kBm+=FR=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B259C2BB40
	for <cocci@archiver.kernel.org>; Sun, 13 Dec 2020 13:53:57 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A61A224B1
	for <cocci@archiver.kernel.org>; Sun, 13 Dec 2020 13:53:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A61A224B1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BDDrYKv009670;
	Sun, 13 Dec 2020 14:53:34 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4F14A77A4;
	Sun, 13 Dec 2020 14:53:34 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 003097B6
 for <cocci@systeme.lip6.fr>; Sun, 13 Dec 2020 14:25:16 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0BDDPFEt009269;
 Sun, 13 Dec 2020 14:25:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1607865913;
 bh=SwNzJ2bJGa86JPjK8v8iohCicBkE50+y5QdndOYqSWA=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=K61JjmbGzdMprjHT0Sl5IBBv7Iv4YzxGL8aCuKsmuBO9tmohgzfxPDIFCZI6aPi3+
 ADovq4iuB76zPHktRHC62Eux4bCRKWAAoWxqcZd8aWlQeKzZB4yd3yI65bFh8Xej+r
 PAEOoDU6+hRlUrMvQxKdbcwEYBNkupP4ZFw6ZWcI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.147.14]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MORqb-1kjCAu2Tyf-005nXg; Sun, 13
 Dec 2020 14:25:13 +0100
To: Masahiro Yamada <masahiroy@kernel.org>, linux-kbuild@vger.kernel.org,
        Coccinelle <cocci@systeme.lip6.fr>
References: <20201212165431.150750-1-masahiroy@kernel.org>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <682c6da6-08b3-e776-ea60-f3de8a74f833@web.de>
Date: Sun, 13 Dec 2020 14:25:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20201212165431.150750-1-masahiroy@kernel.org>
Content-Language: en-GB
X-Provags-ID: V03:K1:DZ3yPXo7JlzC+xu4TTQ+IuNQf0gsoXVlxwZa7NCAh6WJ3JG8kYi
 Yv7Q9PkhKChiCIvX7lTqdYx7/i3v+byOLejqQTF5LCIWdwb5W8KjX1G/zTI+9Zi+09ZhYdh
 ry+5ms6eUTTCU0+KDuf5C+ohYW0cKEc8fClfB0Uw6JcMq3OOvZMKizOVcNnJ0SQAw5suAyN
 aifhRdXJgioxJVS0cenOw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:61hHWaH079M=:szKnkjLQORXxwAB8eRZtRY
 CQBeoAwgcpcabs+llvM/zobfVlBFojFDwlJ9ihwkFRXqgF6wOeFz3Vv6khMCmLRpz06G+Za7d
 gcYF4IhGmelrb9H23rQC+iRkUXj0BZE3YDU+ma84nBoU5/0rd3K1JeChh3GFTcYBdBFiWNAmV
 OAgeFPK+MGUo82pIPJkw+hKuCtU0TA4nW94NYpKFbAnVRtIVovhVVAsIMPhBTnrHPd8Kpfyu4
 GlN7R7LYiZ7qUEJESfriiPSXr8fi9tUyjeY0OjMQZ7j1gqdRB29Z6u4zVsjtfqnth+dItNHQs
 +xxUlAFMyYblM/0zxAz9j2SMC1ZbvpAnYP91kr1jKYD+2nPwt4m3+O2WnbaRa0ws7wMglQSpY
 6m+7JZppqJQYhuxslSCqJhwyKIgJ6D+7CjtBXWfStS+gBVKsP7OGN4ib3D2GPc2bSYa+NKUWy
 kq+KfI/HGZpeUeuXby19WaeYcNnJ867eJXzQAVk91ITJtylNLA0SkCiQOK4UjOUhel5EtHo3X
 u6gwehrKNnoPlhmZjmTll47MQL0roAT9bujH5AjafThMXiqnC1+wA1Uxq15ikpc3WbRh3dL0b
 YEuEOm0ACzj+bIHetCvGfvkQaVcs1vX2vXRK6MFvAAgRG0K3K2MBeQNDDHG3fYdZhbSfTKf6K
 YpJfU+jsxmpzoOYsbdkww9U3ZV7zV5daS2GVrERCDL0iakNYlCiFx1vKiO8aU0AokFs4WBqEQ
 a9lGxJEKmZrEwsfZT5Mg2KU+mQwDvlw1ZOhRn9U0YkypFoOHOSIB2X5HZVWRHQ3E9Q1yab5pr
 FGQGjZq3LTXOHyLChhklN/v7xhqBuzFcQlPhO1jBxKC28JCxgYNemqdK5d7hj2lI3U4Qapcn9
 UC/zAe0rqh0OdvVvBTDg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 13 Dec 2020 14:53:34 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 13 Dec 2020 14:25:15 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 13 Dec 2020 14:53:32 +0100
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Dominique Martinet <asmadeus@codewreck.org>,
        =?UTF-8?Q?Matthias_M=c3=a4nnich?= <maennich@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Subject: Re: [Cocci] [PATCH 1/3] kbuild: do not use scripts/ld-version.sh
 for checking spatch version
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

4oCmCj4gKysrIGIvc2NyaXB0cy9jb2NjaWNoZWNrCuKApgo+IEBAIC0xODYsMTQgKzE4NSwxMSBA
QCBjb2NjaW5lbGxlICgpIHsK4oCmCj4gKyAgICBpZiBbIC1uICIkUkVRIiBdICYmICEgeyBlY2hv
ICIkUkVRIjsgZWNobyAiJFNQQVRDSF9WRVJTSU9OIjsgfSB8IHNvcnQgLUNWIDsgdGhlbgoKV291
bGQgaXQgbWFrZSBzZW5zZSB0byB1c2UgYW4gb3RoZXIgY29tbWFuZCBjb250cm9sIG9wZXJhdG9y
PwoKCisgICAgaWYgWyAtbiAiJFJFUSIgXSAmJiAhIHsgZWNobyAiJFJFUSIgJiYgZWNobyAiJFNQ
QVRDSF9WRVJTSU9OIjsgfSB8IHNvcnQgLUNWIDsgdGhlbgoKCkhvdyBkbyB5b3UgdGhpbmsgYWJv
dXQgYW5vdGhlciBjb21tYW5kIHZhcmlhbnQ/CgorICAgIGlmIFsgLW4gIiRSRVEiIF0gJiYgISBw
cmludGYgIiVzXG4lc1xuIiAiJHtSRVF9IiAiJHtTUEFUQ0hfVkVSU0lPTn0iIHwgc29ydCAtQ1Yg
OyB0aGVuCgoK4oCmCj4gKysrIGIvc2NyaXB0cy9uc2RlcHMKPiBAQCAtMTIsMTEgKzEyLDkgQEAg
aWYgWyAhIC14ICIkU1BBVENIIiBdOyB0aGVuCuKApgo+ICtpZiAhIHsgZWNobyAiJFNQQVRDSF9S
RVFfVkVSU0lPTiI7IGVjaG8gIiRTUEFUQ0hfVkVSU0lPTiI7IH0gfCBzb3J0IC1DViA7IHRoZW4K
CkFyZSBjb21tYW5kIGFsdGVybmF0aXZlcyBoZWxwZnVsIGF0IHN1Y2ggYSBwbGFjZT8KCitpZiAh
IHsgZWNobyAiJFNQQVRDSF9SRVFfVkVSU0lPTiIgJiYgZWNobyAiJFNQQVRDSF9WRVJTSU9OIjsg
fSB8IHNvcnQgLUNWIDsgdGhlbgoKT3IKCitpZiAhIHByaW50ZiAiJXNcbiVzXG4iICIke1NQQVRD
SF9SRVFfVkVSU0lPTn0iICIke1NQQVRDSF9WRVJTSU9OfSIgfCBzb3J0IC1DViA7IHRoZW4KCgpS
ZWdhcmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5
c3RlbWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
