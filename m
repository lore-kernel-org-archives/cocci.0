Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0DB5CCA47E
	for <cocci@archiver.kernel.org>; Wed, 29 Jun 2022 14:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=to:cc:references:from:message-id:date:mime-version:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=8rkJSqKETwClDPJaK8yTX6aoKzP34mIGC/AyGXJCseM=;
  b=aDLg1hrWBS6Al5vFyisxQ9ZZu3ugOj6pvVxtRIFcN9RYbiqvWeBKd7xV
   AybWtZKA2KuPCuj82EcdbB2YoynBGkjtNgXDbiBlhAyyoQ7mFGHMS/dMn
   z6FpHXiEFDRtvjl0FU0b7eODB5tPT6uOdWfwEMGChUjnITcGaRxP3XeVa
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.92,231,1650924000"; 
   d="scan'208";a="43455075"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jun 2022 16:31:02 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 5AC99E4371; Wed, 29 Jun 2022 16:31:02 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 80B8CE2680
	for <cocci@sympa.inria.fr>; Wed, 29 Jun 2022 14:32:41 +0200 (CEST)
IronPort-SDR: n6j5ykBl1lN56J0STvH51OS1wdt/aJrN+uCxg13beHb6woSMiBHjYNwyO37lr65oxKdqNeCO9/
 sY1K6OIq7KQ6FCmJ7gYm/DTCg4fVXwjQL466KblZXlHAG4j9qPrelC4Uc1ss1EsY9SDYOPRI9x
 cfbeIjk+AYqjT13LWfYM0qqgKhQNvlCId29kBs/yxcY4A4yLERO3MnUvv54E0GsyrBQuPuhf0g
 vM/ryCw7lNYtxMjsY8beC55/S1o/kRfBcI7NxqacKIoGHFrZLEij+qV/PinSWD47THxPSLk00C
 V/E0vsZNEojxq7UTZ4Cy05bs
X-IPAS-Result: =?us-ascii?q?A0BNAwD4Rbxih73U+S1aHgEBCxIMQIFEC4IkgQFVLwQLR?=
 =?us-ascii?q?BeEN5BeLgNpgzqYUIF8CwEDAQwBMhAEAQGCD4J0AoVKAh0HAQQyBw4BAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBBQEBAQIBAQIEBAETAQEBAQsNCQUICgcOEAU8ZGiBT?=
 =?us-ascii?q?4F0CzQNgjUpAYNkAQICASNWBQsLGgImAgJHEAYBDAEFAgEBgnkBgnUjAw+sI?=
 =?us-ascii?q?IExgQGEboULBoERLIdLhywngimBFSeDAz6BD4E8FwQYhRyCZQSZVRwmBA8DG?=
 =?us-ascii?q?i0vEoEgbgEIBgMDBwoFMAYCDBgUBAITEk0GHAISBQcKBhUOFBwSEhcMDwMSA?=
 =?us-ascii?q?xEBBwIJEggVKwgDAgMIAwIDIAsCAxYJBwoDHQgKHBIQFAIEER4LCAMZHiwJA?=
 =?us-ascii?q?gQOA0IICwoDEQQDExgJFggQBAYDCC8NJwsDBQ8NAQYDBgIFBQEDIAMUAwUkB?=
 =?us-ascii?q?wMhDyYNDQQbBx0DAwUlAwICGwcCAgMCBhUGAgIYVi4NCAQIBBgfJA8FAgcvB?=
 =?us-ascii?q?QQvAh4EBQYRCAIWAgYEBQIEBBYCEAgCCCcXBxMYGxkBBVkQCSEWBgofCgYFB?=
 =?us-ascii?q?hYDIUomBQo7Dyg0NjwsHxsKgRosCSIWAwQEAwIGGgMDIgISKQY5AxoGIxsCm?=
 =?us-ascii?q?38IgSESBoIxlW1Gi39fnkAHA4NOiyGUYQYPBC2WapF6LZVQdSCNEYtWiTiEW?=
 =?us-ascii?q?gIEAgQFAhaBaA6CAHBQgmhOAQIBAg0BAgICAQECAQIJAQECjikNCRWIT4VXN?=
 =?us-ascii?q?zECAQgwAgYLAQEDCY1vgRIBAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23:vT4fHqnr8iVzf2GhPGtBWRDo5gykIERdPkR7XQ2eYbSJt1+Wr1Gzt
 xIfX2+PM66OY2TwKtAgPtmy90MF6pbQy95gGVA9rSpkRVtH+JHPbTi7BhepbnnKdqUvb2o+s
 p5AMoGYRCwQZiWBzvt4GuG59RGQ7YnRGvykTrSs1hlZHWeIcg944f5Ys7N/09QAbeSRWVvX4
 4us+ZyHYTdJ5hYtWo4qw/LbwP9QlK+q0N8olgRWiSdj4TcyP1FMZH4uDfnZw0nQGuG4LcbmL
 wr394xVy0uCl/sb5nxJpZ6gGqECaua60QFjERO6UYD66vRJjnRaPqrWqJPwZG8P4whlkeydx
 /1i67Kwcw5yI5bJv+8BWDhJFRp0ZI5/reqvzXiX6aR/zmXdYWvjyq01SUAwe40F8/l6ACdF8
 vlwxDIlMk3F3b7nhujiEK811pVLwMrDZOvzvll/zDXdDP8jB4DeSqPY5M5R2jgYht1HAvvfI
 cEebFKDaTycOEEVYA5GUfrSms+vvFOnSAVjtWvLnpgm7HeL6FQ2yarUZY+9ltuiH5gJwhjB9
 woq5V/RBhgFPdib4SiE93i2j6nOmzn6UcQcDtWQ/flhi1y73X0WEBRQVF2hoPD/hFTWZj5EA
 1cG6iUn9fN39UrtTsT0QBC55nWDu3bwRua8DcUVti+N8KOP/j2cIWMYRR9Qbucs7ewPEGlCO
 kCyo/vlAjlmsbuwQH2b96uJoT7aBRX5PVPudgdfEVRauIOLTJUb10uUEYw5SMZZm/WsQWmoq
 w1muhTSkJ04q6Y2O0iT5kLXjDv0/d3ISEg1+wzIU2Pj5QR8DGJEW2BKwQaLhRqjBNzDJrVkg
 JTis5TChAzpJc3W/BFhuM1XQNmUCw+taVUwe2JHEZg77CiK8HW+Z41W6zwWDB43b5hYJWaxP
 BCM4lw5CHpv0J2CMPMfj2WZVp5C8EQdPY69CqC8giRmO8MZmPC7ENFGPxPMgz60wSDAYIk/J
 J6EfMfkEXsRCaJgyD25RuoGmbQsgEgDKZD7GPjGI+Cc+ePGPha9EO9bWHPXN7xRxP7a/G39r
 ogOX+PXmk03eLCvOUH/rN9DRXhUdiJTLc6t9KRqmhureVcO9JcJUKOKntvMuuVNw8xoqws/1
 irmBBMIlAav1COvxMfjQikLVY4DlK1X9RoTVRHA937ys5T6SYrwvqoZabUterwrqL5qwfJuF
 qFXe9iJHflODD/A/m1FP5X6qYVjcjWthB6Pbnb6PWlgL8I8Slyb4MLgcyvu6DIKUni9u/w4r
 uDyzQjcW5cCG1lvAZ+OOvKixl+8p1YHn+d2UxeaK9VfYhy0ooh3IjP8j7k8JMRVcUfPwT6T1
 gC3BxYEpLiR/NJkr4mV2a3d9tWnCepzGEZeDlL317fuOHmI5HenzK9BTP2MIWLXWlTy9fjwf
 u5S1fz9bKAKkVsW4YpxF7FnkfA369f1/eYI1RZ0E3yTNBGqDPVgP3CZ0MgJvapIn+cLtQyzU
 0OJ299bJbTYZJy4QQFBeFYoPraZyPUZujjO9vBpck/00yl6oeicWkJIMhjQ1SFQcOlvPIU+z
 btzscIa8Vbm2AE4ItmP1nsR9mLKLmEJTKgm8JodBdaz2AYsz1hDZ73aCzP3sc3QNoQTYhV2L
 2/GnrfGipRd2lHGLyg5G0/L0LcPnp8Joh1LkAIPKlnhdgApXRPrMMC9MAjbTzi5Cj1cwfJ8M
 zAwckxzY6WT9ihlhY5IWGXE98StwvGG0hSZ9rfLvDSxo4qUuqjlLHA0JuuMukse9gqwuxBFq
 aqAxj+NvSnCJanMM+hbZaKhg/z+RMN890vJn8XP8wFp2XUlSWKNv5JCrlbkZ/cq7Q3dSaEHS
 SRXED5MVJDG
IronPort-HdrOrdr: A9a23:ybRoaKi/1sV/xy2uHsodiFcDl3BQXvAji2hC6mlwRA09TySZ//
 rAoB1p726MtN93YgBHpTngAtjmfZqyz+8X3WB8B9aftUzdyQ+VxeJZnO7fKl/bexEWn9Q1vc
 wLT0E9MrPN5DNB4PoSjjPVLz9t+qjkzEh17d2utUuEGmpRGtpdBlBCe36mLnE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.92,231,1650924000"; 
   d="scan'208";a="43422191"
X-MGA-submission: =?us-ascii?q?MDHfAY5O/9IlwFCsozPIE0CU8PjQhrj7CHGicI?=
 =?us-ascii?q?VFdT9xpn8Dq2dVdeTkgEbwZgf/DmAQZ2+rt0OGwdzMDfBl/J46klSbrL?=
 =?us-ascii?q?aqgEev/5IoGPJpWBCuD7C4N8LD9S/44pWOh1PCpBotbVGqSY05cYp3vK?=
 =?us-ascii?q?3H5TWWFZzjBRGQpA7GBaRkUA=3D=3D?=
Received: from szxga03-in.huawei.com ([45.249.212.189])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jun 2022 14:32:38 +0200
Received: from canpemm500006.china.huawei.com (unknown [172.30.72.53])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LY16v2ZnTz9sv4;
	Wed, 29 Jun 2022 20:31:51 +0800 (CST)
Received: from [10.174.179.200] (10.174.179.200) by
 canpemm500006.china.huawei.com (7.192.105.130) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 29 Jun 2022 20:32:31 +0800
To: Markus Elfring <Markus.Elfring@web.de>, <cocci@inria.fr>,
	<kernel-janitors@vger.kernel.org>
CC: Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix
	<nicolas.palix@imag.fr>, Fabian Frederick <fabf@skynet.be>, Yajun Deng
	<yajun.deng@linux.dev>, "David S. Miller" <davem@davemloft.net>, Phil
 Edworthy <phil.edworthy@renesas.com>
References: <20220616013253.520310-1-william.xuanziyang@huawei.com>
 <32da2d32-9554-de90-62ca-c4be456ad31a@web.de>
From: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
Message-ID: <6b3eac2c-6e24-46e0-c548-dc87f666709b@huawei.com>
Date: Wed, 29 Jun 2022 20:32:31 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <32da2d32-9554-de90-62ca-c4be456ad31a@web.de>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.174.179.200]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500006.china.huawei.com (7.192.105.130)
X-CFilter-Loop: Reflected
X-Validation-by: julia.lawall@inria.fr
Subject: Re: [cocci] [PATCH] scripts/coccinelle/free: add NULL test before
 dev_{put, hold} functions
Reply-To: "Ziyang Xuan (William)" <william.xuanziyang@huawei.com>
X-Loop: cocci@inria.fr
X-Sequence: 466
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-06/6b3eac2c-6e24-46e0-c548-dc87f666709b%40huawei.com>

> I find the patch subject improvable.
> You would like to detect the remaining usage of redundant null pointer checks
> before selected function calls.
> Thus it would be nice if the corresponding description can become clearer
> another bit, wouldn't it?

Sorry, I did not get your mean. Did you mean I should point out the selected function?

And the following is one warning, what would be like as your suggestion?

./drivers/infiniband/core/lag.c:98:2-10: WARNING: NULL check before dev_{put, hold} functions is not needed.

>
>
>> Since commit b37a46683739 ("netdevice: add the case if dev is NULL"),
>> NULL check before dev_{put, hold} functions is not needed.
>>
>> Signed-off-by: Ziyang Xuan <william.xuanziyang@huawei.com>
>> ---
>>  scripts/coccinelle/free/ifnulldev_put.cocci | 54 +++++++++++++++++++++
>
> How do you think about to achieve further collateral evolution?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=b37a466837393af72fe8bcb8f1436410f3f173f3
>
> Will it become feasible to combine any more source code analysis approaches?
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/free/ifnullfree.cocci?id=8c23f235a6a8ae43abea215812eb9d8cf4dd165e#n2
>
>
>> +// Comments: -
>
> Can such a line be omitted?
>
It's ok.
>
>> +@r2 depends on patch@
>> +expression E;
>> +@@
>> +- if (E != NULL)
>> +(
>> +  __dev_put(E);
>> +|
>> +  dev_put(E);
>> +|
>> +  dev_put_track(E, ...);
>> +|
>> +  __dev_hold(E);
>> +|
>> +  dev_hold(E);
>> +|
>> +  dev_hold_track(E, ...);
>> +)
>
> Did you order the case distinctions in the SmPL disjunction according to
> the call frequencies of the mentioned function names?

No, no any special, just list the related functions.

>
> Otherwise, I imagine that another software design option can be considered for
> the application of nested disjunctions by the means of the semantic patch language.
>
> Code variant:
>
> @r2 depends on patch@
> expression E;
> @@
> -if (E != NULL)
> (
> (__dev_put
> |dev_put
> |__dev_hold
> |dev_hold
> )(E)
> |
> (dev_put_track
> |dev_hold_track
> )(E, ...)
> )
> ;
It's ok.
>
> Regards,
> Markus
>
> .
