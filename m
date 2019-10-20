Return-Path: <SRS0=QaTm=YN=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78D4ACA9EA9
	for <cocci@archiver.kernel.org>; Sun, 20 Oct 2019 09:23:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82EDF2190F
	for <cocci@archiver.kernel.org>; Sun, 20 Oct 2019 09:23:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="iocVY7oV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82EDF2190F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9K9MoDk002163;
	Sun, 20 Oct 2019 11:22:50 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id AE9E17792;
	Sun, 20 Oct 2019 11:22:50 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4F72E76F6
 for <cocci@systeme.lip6.fr>; Sun, 20 Oct 2019 11:22:48 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9K9MkT4014163;
 Sun, 20 Oct 2019 11:22:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571563366;
 bh=ybgmSME55d6pA+V6Rxec8Yu8ss+RismAuNX4WzmgrQk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=iocVY7oVIm28YDsUucBm6Yd9iBIVV7uZLFuZCGD1oDbLC4qYXvvx/bR8DBG8gOgKt
 HySOR3kd+qPG2DEyM+4t0fahLLQLIaQESPSY23yCbY0XpDeko/Y0tW7KzmJ7MQ+kNN
 +J1JA8xVJFKL+BI82ge6hTRSzrsYNU3GlltU8O+w=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.112.181]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Le4Po-1hfLY228uS-00pvre; Sun, 20
 Oct 2019 11:22:46 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
 <45be389f-23f9-cbff-fa5f-8ad111124f94@web.de>
 <alpine.DEB.2.21.1910181530460.3697@hadrien>
 <1a3776fe-7f18-e072-9bda-30d10ffd1c07@web.de>
 <32b67cc6-0dd9-6615-d8ed-5c2dfe2af863@web.de>
 <alpine.DEB.2.21.1910191740020.3272@hadrien>
 <958b4a11-e45b-3795-a3cb-08f98aaa40d6@web.de>
 <alpine.DEB.2.21.1910200741180.3689@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 mQINBFg2+xABEADBJW2hoUoFXVFWTeKbqqif8VjszdMkriilx90WB5c0ddWQX14h6w5bT/A8
 +v43YoGpDNyhgA0w9CEhuwfZrE91GocMtjLO67TAc2i2nxMc/FJRDI0OemO4VJ9RwID6ltwt
 mpVJgXGKkNJ1ey+QOXouzlErVvE2fRh+KXXN1Q7fSmTJlAW9XJYHS3BDHb0uRpymRSX3O+E2
 lA87C7R8qAigPDZi6Z7UmwIA83ZMKXQ5stA0lhPyYgQcM7fh7V4ZYhnR0I5/qkUoxKpqaYLp
 YHBczVP+Zx/zHOM0KQphOMbU7X3c1pmMruoe6ti9uZzqZSLsF+NKXFEPBS665tQr66HJvZvY
 GMDlntZFAZ6xQvCC1r3MGoxEC1tuEa24vPCC9RZ9wk2sY5Csbva0WwYv3WKRZZBv8eIhGMxs
 rcpeGShRFyZ/0BYO53wZAPV1pEhGLLxd8eLN/nEWjJE0ejakPC1H/mt5F+yQBJAzz9JzbToU
 5jKLu0SugNI18MspJut8AiA1M44CIWrNHXvWsQ+nnBKHDHHYZu7MoXlOmB32ndsfPthR3GSv
 jN7YD4Ad724H8fhRijmC1+RpuSce7w2JLj5cYj4MlccmNb8YUxsE8brY2WkXQYS8Ivse39MX
 BE66MQN0r5DQ6oqgoJ4gHIVBUv/ZwgcmUNS5gQkNCFA0dWXznQARAQABtCZNYXJrdXMgRWxm
 cmluZyA8TWFya3VzLkVsZnJpbmdAd2ViLmRlPokCVAQTAQgAPhYhBHDP0hzibeXjwQ/ITuU9
 Figxg9azBQJYNvsQAhsjBQkJZgGABQsJCAcCBhUICQoLAgQWAgMBAh4BAheAAAoJEOU9Figx
 g9azcyMP/iVihZkZ4VyH3/wlV3nRiXvSreqg+pGPI3c8J6DjP9zvz7QHN35zWM++1yNek7Ar
 OVXwuKBo18ASlYzZPTFJZwQQdkZSV+atwIzG3US50ZZ4p7VyUuDuQQVVqFlaf6qZOkwHSnk+
 CeGxlDz1POSHY17VbJG2CzPuqMfgBtqIU1dODFLpFq4oIAwEOG6fxRa59qbsTLXxyw+PzRaR
 LIjVOit28raM83Efk07JKow8URb4u1n7k9RGAcnsM5/WMLRbDYjWTx0lJ2WO9zYwPgRykhn2
 sOyJVXk9xVESGTwEPbTtfHM+4x0n0gC6GzfTMvwvZ9G6xoM0S4/+lgbaaa9t5tT/PrsvJiob
 kfqDrPbmSwr2G5mHnSM9M7B+w8odjmQFOwAjfcxoVIHxC4Cl/GAAKsX3KNKTspCHR0Yag78w
 i8duH/eEd4tB8twcqCi3aCgWoIrhjNS0myusmuA89kAWFFW5z26qNCOefovCx8drdMXQfMYv
 g5lRk821ZCNBosfRUvcMXoY6lTwHLIDrEfkJQtjxfdTlWQdwr0mM5ye7vd83AManSQwutgpI
 q+wE8CNY2VN9xAlE7OhcmWXlnAw3MJLW863SXdGlnkA3N+U4BoKQSIToGuXARQ14IMNvfeKX
 NphLPpUUnUNdfxAHu/S3tPTc/E/oePbHo794dnEm57LuuQINBFg2+xABEADZg/T+4o5qj4cw
 nd0G5pFy7ACxk28mSrLuva9tyzqPgRZ2bdPiwNXJUvBg1es2u81urekeUvGvnERB/TKekp25
 4wU3I2lEhIXj5NVdLc6eU5czZQs4YEZbu1U5iqhhZmKhlLrhLlZv2whLOXRlLwi4jAzXIZAu
 76mT813jbczl2dwxFxcT8XRzk9+dwzNTdOg75683uinMgskiiul+dzd6sumdOhRZR7YBT+xC
 wzfykOgBKnzfFscMwKR0iuHNB+VdEnZw80XGZi4N1ku81DHxmo2HG3icg7CwO1ih2jx8ik0r
 riIyMhJrTXgR1hF6kQnX7p2mXe6K0s8tQFK0ZZmYpZuGYYsV05OvU8yqrRVL/GYvy4Xgplm3
 DuMuC7/A9/BfmxZVEPAS1gW6QQ8vSO4zf60zREKoSNYeiv+tURM2KOEj8tCMZN3k3sNASfoG
 fMvTvOjT0yzMbJsI1jwLwy5uA2JVdSLoWzBD8awZ2X/eCU9YDZeGuWmxzIHvkuMj8FfX8cK/
 2m437UA877eqmcgiEy/3B7XeHUipOL83gjfq4ETzVmxVswkVvZvR6j2blQVr+MhCZPq83Ota
 xNB7QptPxJuNRZ49gtT6uQkyGI+2daXqkj/Mot5tKxNKtM1Vbr/3b+AEMA7qLz7QjhgGJcie
 qp4b0gELjY1Oe9dBAXMiDwARAQABiQI8BBgBCAAmFiEEcM/SHOJt5ePBD8hO5T0WKDGD1rMF
 Alg2+xACGwwFCQlmAYAACgkQ5T0WKDGD1rOYSw/+P6fYSZjTJDAl9XNfXRjRRyJSfaw6N1pA
 Ahuu0MIa3djFRuFCrAHUaaFZf5V2iW5xhGnrhDwE1Ksf7tlstSne/G0a+Ef7vhUyeTn6U/0m
 +/BrsCsBUXhqeNuraGUtaleatQijXfuemUwgB+mE3B0SobE601XLo6MYIhPh8MG32MKO5kOY
 hB5jzyor7WoN3ETVNQoGgMzPVWIRElwpcXr+yGoTLAOpG7nkAUBBj9n9TPpSdt/npfok9ZfL
 /Q+ranrxb2Cy4tvOPxeVfR58XveX85ICrW9VHPVq9sJf/a24bMm6+qEg1V/G7u/AM3fM8U2m
 tdrTqOrfxklZ7beppGKzC1/WLrcr072vrdiN0icyOHQlfWmaPv0pUnW3AwtiMYngT96BevfA
 qlwaymjPTvH+cTXScnbydfOQW8220JQwykUe+sHRZfAF5TS2YCkQvsyf7vIpSqo/ttDk4+xc
 Z/wsLiWTgKlih2QYULvW61XU+mWsK8+ZlYUrRMpkauN4CJ5yTpvp+Orcz5KixHQmc5tbkLWf
 x0n1QFc1xxJhbzN+r9djSGGN/5IBDfUqSANC8cWzHpWaHmSuU3JSAMB/N+yQjIad2ztTckZY
 pwT6oxng29LzZspTYUEzMz3wK2jQHw+U66qBFk8whA7B2uAU1QdGyPgahLYSOa4XAEGb6wbI FEE=
Message-ID: <076f8c5d-7441-dbad-3e1d-877c4788e01b@web.de>
Date: Sun, 20 Oct 2019 11:22:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910200741180.3689@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:quh69FR1oKdcmzIOWkyI8Dr9XncgEneiXEVHSdXBh/Fd/OUh1U5
 Ji72ZzmdJQt1CzobTeOw7D3uOKahbshArVJs9QRfZyyaElAcQ4KVUb0BSLpYNPIOVkXFFzU
 2II2qsEKD0lNEkwo1lU64hwAR8blbazX2AJKXrr6WxnqJr5k+Ldl1ZNXY6HhYvYOKmqXCdx
 0YYpuQd2SmCYHHuJBjUoA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:qhgCrXhvZ/w=:1ayGQDu23Mhd5bEz4XfP3Z
 eHC8oBFthI/No0z4SsjJv4uh+4uglBqkLw2UzOAfMcyPJNc0vLb/z5aB3dTPzHQlzbuLqOlRU
 FGKns5jgaai93nBJaXiOhMHneA0pbqB0nNxBYmbyShArGIk7RKkA4fuO2Htv1ZSk7E7vQO7lw
 D7kIwqjEH53uzTGnn4lqcSPURijFvd3amNeWZlZSO6OmQETLgWz7huMOf0rkl+FmIjebsileu
 uwnX8MhJZACv4xKju9PhQCl0OviH/QT3hvhbKnrv+qRx8UjHUKBjoRVvgXPCCzklaRim4phBj
 1U0jzrBknuRl7PE5SFdItbSuHrFOCuVZNQQFHNE5VIhNbClcE3dRs6hKE3yqvwmUdBOQ9b//0
 YcvmpkLdbjjNxiIKa+P7kLiG7g56IBSHcQfmhgnyR4K9yLRTTif6/zzqSPzLkkHseWD6W0mNu
 FfA6LZkVUkzB9+nYR3hXJTBazNH9beYUoqL/8RV3K2OqHdM6FV1xWFcyU5IeXNe6EFOFhGoMb
 BG102PzkQCAlnUoAHZhJ0VL8IWmKtX+wAbFMrSZxnNl4wZk7WR+2B1Dfa1QgjPn0eJ2qHdgsq
 OXfq8nEGTUr7zylr65mcKgq2B4+CoyGwtZNPBAazx4QlVT+5/xGQaAaQzWhYMgs8LR+WC+ThN
 EyUKLXA2T8kuSvlXphPxl+X7viUSm/YaeU5HHBH6lfV1BS0W7uHPiOKdKeRaB4TNTKv4egsyS
 DFE4Zuu+tqBjo5E0GUqAQlODWqbSFwiSImNWPHFoZqP+kJhY/5fylaO7Emb2l+qrLwnxDtSeE
 ODG7A3BNv/dDNtP55oKeUK9zoKeB6K3G36zbR9YhXbOHGo2MsuPGqmuY2T3k/ogiMTwVy0/c6
 8czvfYWA3v2QLNSqRN5J/RlSlzuh8H2Jear22JoyzVCMIuERLv8ygGEv009y/7n8dIYpxBYHY
 FQEi4y76yjnsprF4a5na5GSZSHyBqBFfbDqIL48lCBPmQGrhhWeCQa9WZSHa8yY1tfDzM6myJ
 +hHTHQoiltjgSMHOmS/cp70Y0yShcbrPDNIhxbmPi2VKoYPXaKXRAh9uvat8teZPXllUxNLgm
 WtAtsvIA0pg5Jxbs8rIzKCEMmJ0VAsTbUO/f0WI7d0Cp5OEw+stUtlKhxd0+zcYoq7touX9h+
 06ex6JPMNkC0WNIrQSA6U2Jy3qt7LLtMr9zVH4TwZ/hqnuvuKhAnc/nZTD3IZOgACiXIe4ouJ
 g1Nba/oKJ+AO2RacTUKGTk1gRXLjN+tc0WIthoKejbLeRnFCEplPCV105Iy8=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 20 Oct 2019 11:22:51 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 20 Oct 2019 11:22:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked pointer
 function calls
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

>> The uncertainty around the partly (un)documented software behaviour
>> for SmPL when constraints makes it unclear then if the presented
>> source code place should finally be treated as a false positive.

Will it be easier to clarify this open issue based on a smaller
source code example?
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/net/ethernet/chelsio/libcxgb/libcxgb_cm.c?id=531e93d11470aa2e14e6a3febef50d9bc7bab7a1#n76

static bool
cxgb_our_interface(struct cxgb4_lld_info *lldi,
		   struct net_device *(*get_real_dev)(struct net_device *),
		   struct net_device *egress_dev)
{
	int i;

	egress_dev = get_real_dev(egress_dev);
	for (i = 0; i < lldi->nports; i++)
		if (lldi->ports[i] == egress_dev)
			return true;
	return false;
}


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
