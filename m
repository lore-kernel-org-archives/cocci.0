Return-Path: <SRS0=bhL7=YX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46FA8CA9EC5
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 20:51:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B175420659
	for <cocci@archiver.kernel.org>; Wed, 30 Oct 2019 20:51:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="cRBzJcDF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B175420659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9UKpJdL021928;
	Wed, 30 Oct 2019 21:51:19 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 6DAB776F8;
	Wed, 30 Oct 2019 21:51:19 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 0E26A74CD
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 21:51:17 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9UKpFkX025855
 for <cocci@systeme.lip6.fr>; Wed, 30 Oct 2019 21:51:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572468620;
 bh=awYX94K/3Ef/IkgRJzU4vUFsU8ft/ilecpb3Nwonm9Q=;
 h=X-UI-Sender-Class:Subject:From:To:Cc:References:Date:In-Reply-To;
 b=cRBzJcDFRBy7tdgPLy+IzMmnVBwqCw+RTNcN90pEfAOODemmynGj2NRIFX8btHrOC
 MWe+NGsEutjd2HpVH+82PAycT6SPq7YaEDeMdq+BZN9xFrSDae5pxwBzyeFrsqgFky
 Cgb+WtrxFtkmirDycNJ0zyZt+HeSSlVeUo9ZvHsc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.104.79]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lfipe-1hbgfp3kCo-00pPoH; Wed, 30
 Oct 2019 21:50:20 +0100
From: Markus Elfring <Markus.Elfring@web.de>
To: linux-tegra@vger.kernel.org, Coccinelle <cocci@systeme.lip6.fr>
References: <fe6868a4-01f5-2832-9081-7643be0ab4a1@web.de>
 <3e3f40db-2422-c64d-3825-35f8c2471eb7@web.de>
 <161bbb97-09d9-f128-bd25-ef9348534144@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <205e2b3a-2934-f5d0-6b12-59beee0d58fa@web.de>
Date: Wed, 30 Oct 2019 21:50:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <161bbb97-09d9-f128-bd25-ef9348534144@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:T65/O15SDHXdx23PrZy6oljaIBK8YZdtQ/lTQkgK3BJRP5lcjCi
 Swyb/bojLr1ULUOof3qlqgp3cmahJeR3Nn+8pYYupdOfnFyIRVIpMQMXHRsZLgrouZOEFoy
 QwUborX5BDzipL3qgMRIW/h9lCLfQ8aw5H+Q3da7ySDm7xZ9Kqeh0RiPRX47jEyQ1Ata97P
 jfo1Xc2HasJt20xzgIfRg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:TzC8nlXS5AA=:MErmcLQ8bfDxaTJUo3mXTJ
 feVEUnLbKQQvBKGEf70IcAueT53rA8jivlV5PrZKCiQnKIIO2rTKGZBGPVYYJPmjxxzo6uDhE
 sebzXSPMVMXLBm9G1vtgxC7VKH8AtFnZqDX+7VPd7rWbsgSp/U/BvR34dwzHF81INSi2VPrnK
 4oUod/V1G82N6YFp9GzD6VQSqqgmbX2X0SKNoa+v+hm0dY+vWwAarzMK0DYyR/osC0GBzkn9F
 O7k90bbs585RnHVjxpBMMMbjy+loD3KlwHGMTax3O93UbCJpbhL3PmIC2vyzuK9yIVGs2RfmY
 tUViR+0VoZhX83QHQM8ypy+t+m+LOZoE3Ae7titKZx21lkmmwIlMJRWCyOmEmsNFOwrVJTQ1Z
 JsDl0rbOxUop0OLgC/BPb+aukjM0WrRRWnOnUMFTH+Ju+62bbzAQSqGGMAIkJ7hV67aqsdTiq
 vZMcTN/Z1LvVYZQlA6hIXp/XBr49X+u7GTkXzXzyFMI6xW7f7lz3iFuZ8xFMhkjZZBO9wSOXT
 9n+T4IBU2nvgRA69P5KOYyComb+8JEIEpeKyjouEX/bcD+ez3DGVo/DF+w5VvIDIxRHYx3oSj
 W7kt6q5SyVh6jyItSS2Es/35VI1h+8y24hkO6eZXztgEnVItjGJLl+ukJsbBHeZ3OV977hu/G
 pefBnDS6yUtB7yB6UOt7PMeNHRtzjyXnDpX1qaqBfwXeO9Iv3ADw38hi14dsS+ousROJjcX2A
 zag4jlp9CcKyfDcEeTwY/6o4JAUr5jPIEiAyBNU/xD/e6wWS9PUkz7NkOebEmBCuGDWjeRdat
 ZBLzoKyaV2zWSGziVYAnEgyz+5bmEW8trAV4/OpxjVk7U7oURV1eOXPmxwsLbFshks+rk0U0X
 HhrztKHhYtCZCzDbQgmng7CHD7seq8z1mRPGkq9xcDqtso4RMG4EhrZ9YI6H7M5fGI0TCFV8a
 MAnJQAw6iXATiXVjuOBb90+iF97nqzSramKVZ1TDnX8TbACxWsDV0GkjhPP9FZUc5Ee8En8Bf
 wXZodSawLH8JX7HQRwM9SrGY25Hv9snLLfazcpRRwPeqjJrynRP5dVlx0aoZ9c9iwvooJWHCv
 wu8J4CKuMVqkG3mGafHPRT+Qw6Rdc3IlrDAN3kxXEqzMz8EmbCgiJftmG3bh/oN8+PhqWuGSx
 A6pKYFnIFaKC2CNmD2ODDRIE9Bphwx9G9K7dg1hrbS1t5fylA5etoaxXsJ0LmYjYqwWyUIcSF
 GP6s1ZIOVqpGoGi4PqwwONlKcdmCo6q2SY623wwn7WPO7oMzhenNPKiq57Co=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 21:51:19 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 30 Oct 2019 21:51:15 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Jonathan Hunter <jonathanh@nvidia.com>, YueHaibing <yuehaibing@huawei.com>,
        JC Kuo <jckuo@nvidia.com>, Kangjie Lu <kjlu@umn.edu>,
        kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Navid Emamdoost <emamd001@umn.edu>,
        Stephen McCamant <smccaman@umn.edu>,
        Thierry Reding <treding@nvidia.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: [Cocci] drivers/phy/tegra: Completion for exception handling in
 probe functions with SmPL?
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

PiBCdXQgSSBzdHVtYmxlIG9uIGFub3RoZXIgdW5leHBlY3RlZCB0ZXN0IHJlc3VsdC4KCkkgZ290
IG1vcmUgcHJvbWlzaW5nIHJlc3VsdHMgYnkgdGhlIGZvbGxvd2luZyB0cmFuc2Zvcm1hdGlvbiBh
cHByb2FjaC4KCkBhZGp1c3RtZW50IGV4aXN0c0AKZXhwcmVzc2lvbiBvYmplY3Q7CmlkZW50aWZp
ZXIgZXhpdDsKQEAKIG9iamVjdCA9IGt6YWxsb2MoLi4uKQogLi4uCiBpZiAoLi4uKQoteyAga2Zy
ZWUob2JqZWN0KTsKICAgIGdvdG8KLSAgICAgICAgZXhpdAorICAgICAgICByZWxlYXNlX21lbW9y
eQogICAgOwotfQogLi4uIHdoZW4gYW55CiBkZXZpY2VfdW5yZWdpc3RlciguLi4pOwotZXhpdAor
cmVsZWFzZV9tZW1vcnkKIDoKK2tmcmVlKG9iamVjdCk7CiByZXR1cm4gRVJSX1BUUiguLi4pOwoK
ClRoZSBzY29wZSBwcm9wZXJ0eSBvZiBzdWNoIGEgU21QTCBydWxlIG9jY2FzaW9uYWxseSBuZWVk
cyBhbHNvIG1vcmUKc29mdHdhcmUgZGV2ZWxvcG1lbnQgYXR0ZW50aW9uLgpodHRwczovL2dpdGh1
Yi5jb20vY29jY2luZWxsZS9jb2NjaW5lbGxlL2Jsb2IvZWQxZWI4ZTA2ZjgwMDczOWQzOTkyMTU4
ZDM2OTQ1YzBjNGM2ZjBjNy9kb2NzL21hbnVhbC9jb2NjaV9zeW50YXgudGV4I0w4NjAKCkkgb2Jz
ZXJ2ZSB0aGF0IHRoZSBwcmV0dHktcHJpbnRpbmcgZm9yIHRoZSBnZW5lcmF0ZWQgc291cmNlIGNv
ZGUgd2lsbCBuZWVkCmZ1cnRoZXIgaW1wcm92ZW1lbnRzIChhY2NvcmRpbmcgdG8gdGhlIExpbnV4
IGNvZGluZyBzdHlsZSkuCgpFeGFtcGxlOgoKZWxmcmluZ0BTb25uZTp+L1Byb2pla3RlL0xpbnV4
L25leHQtcGF0Y2hlZD4gc3BhdGNoIGRyaXZlcnMvcGh5L3RlZ3JhL3h1c2ItdGVncmExODYuYyB+
L1Byb2pla3RlL0NvY2NpbmVsbGUvamFuaXRvci9jb21wbGV0ZV9leGNlcHRpb25faGFuZGxpbmdf
aW5fcHJvYmVfZnVuY3Rpb25zNi5jb2NjaQrigKYKQEAgLTQ2MSwxMCArNDYxLDggQEAgdGVncmEx
ODZfdXNiMl9wYWRfcHJvYmUoc3RydWN0IHRlZ3JhX3h1cwogCXBhZC0+c29jID0gc29jOwoKIAll
cnIgPSB0ZWdyYV94dXNiX3BhZF9pbml0KHBhZCwgcGFkY3RsLCBucCk7Ci0JaWYgKGVyciA8IDAp
IHsKLQkJa2ZyZWUodXNiMik7Ci0JCWdvdG8gb3V0OwotCX0KKwlpZiAoZXJyIDwgMCkKKwkJZ290
byByZWxlYXNlX21lbW9yeTsKCiAJcHJpdi0+dXNiMl90cmtfY2xrID0gZGV2bV9jbGtfZ2V0KCZw
YWQtPmRldiwgInRyayIpOwogCWlmIChJU19FUlIocHJpdi0+dXNiMl90cmtfY2xrKSkgewpAQCAt
NDgzLDcgKzQ4MSw4IEBAIHRlZ3JhMTg2X3VzYjJfcGFkX3Byb2JlKHN0cnVjdCB0ZWdyYV94dXMK
CiB1bnJlZ2lzdGVyOgogCWRldmljZV91bnJlZ2lzdGVyKCZwYWQtPmRldik7Ci1vdXQ6CityZWxl
YXNlX21lbW9yeSA6CitrZnJlZSh1c2IyKTsKIAlyZXR1cm4gRVJSX1BUUihlcnIpOwogfQrigKYK
CgpIb3cgcmVhc29uYWJsZSBkbyB5b3UgZmluZCB0aGUgcHJlc2VudGVkIHVwZGF0ZSBzdWdnZXN0
aW9uPwoKUmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0
cHM6Ly9zeXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
