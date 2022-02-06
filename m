Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F26D5C433EF
	for <cocci@archiver.kernel.org>; Sun,  6 Feb 2022 19:40:46 +0000 (UTC)
X-IronPort-AV: E=Sophos;i="5.88,348,1635199200"; 
   d="scan'208";a="19953308"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 06 Feb 2022 20:40:45 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 1339BE0381; Sun,  6 Feb 2022 20:40:45 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id BABE7E037F
	for <cocci@sympa.inria.fr>; Sun,  6 Feb 2022 20:40:38 +0100 (CET)
Authentication-Results: mail3-smtp-sop.national.inria.fr; spf=None smtp.pra=Markus.Elfring@web.de; spf=Pass smtp.mailfrom=Markus.Elfring@web.de; spf=None smtp.helo=postmaster@mout.web.de
IronPort-SDR: MDCtVMic93ZQPvzOACQx7FqyTDLEY9Ljnf7vFn2f8FiZPxkyitpBUTF/qfxLf1vR//giNIlJ1N
 DOyvAJqTdfJ5GzstCR4T2CSoHPguFCHjgj2GIPRkGO7QM8jlrjf/SHusFuolCZWzxCsNGeelLa
 jkod5h6zP8yMAWhFbe7WRHO72vR9z6i0EetOkBaYNn09dfUIpwlX78+ZauX5ApClNe6p79odhU
 hG558Coaroq7h3GG4pw0ei/DPKu+E8O3jevx9GL4q3Akpy9T26CY9/cKDv+/GdJ0LSTAIjLU9q
 DlL7PJktQNfB1aMFW5rmfb31
X-IPAS-Result: =?us-ascii?q?A0CqAQCSIwBihwsR49RaHAEBAQEBAQcBARIBAQQEAQFAg?=
 =?us-ascii?q?VoCgiZpbCsEC0KEVI5xgXcxiyOHE4wZCwEDAQ0+AQIEAQGCEIJ1AoNiAh0HA?=
 =?us-ascii?q?QQ1BQ0BAgQBAQEBAwIDAQEBAQEBAwEBBQEBAQIBAQIDBAETAQEBDA0JBQgKB?=
 =?us-ascii?q?w4QBTYGXgZkBIFLBIF0CzQNgjUpAYNkAQICASMVCAEBESYBBAsLGgImAgJXB?=
 =?us-ascii?q?g0IAQGDAIJlAQMNJas9eoExgQGCCAEBBoRKHywiUoFbCYEQKgGOMicQgVVEg?=
 =?us-ascii?q?TyDAz5phnQTglKUFqQ3njI0B4IQgTmBPgueAQYULoNgAZJKDgaRTpZKpnCBe?=
 =?us-ascii?q?YF9MxokgzhOAQIBAg0BAgIDAQIBAgkBAQKOHRmEC4osQDM4AgYLAQEDCYVHA?=
 =?us-ascii?q?QGLBgEB?=
IronPort-PHdr: A9a23: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
 Q==
IronPort-Data: A9a23:I+l8aaOHKH8K53PvrR2ykcFynXyQoLVcMsEvi/4bfWQNrUon1jJRy
 mJMXziDPvjfZDagc4pzYIznpE9UvMfRzNRjTnM5pCpnJ55ogZqcVI7Bdi8cHAvLc5adFBo/h
 yk6QoOdRCzhZiaE/n9BCpC48T8kk/jgqoPUUIYoAAgoLeNfYHpn2UILd9IR2NYy24DjW13V4
 7senuWGULOb824sWo4rw/nbwP9flKyaVOQw4zTSzdgS1LPvvyF94KA3fcldHFOkKmVgJdNWc
 s6YpF2PEsw1yD92Yj+tuu6TnkTn2dc+NyDW4pZdc/DKbhSvOkXe345jXMfwZ3u7hB2Pmdlry
 +Rnr6CoF1w4APbghrwiQgFXRnQW0a1uoNcrIFC6ttGPiVLLeT3gzp2CDmlsZNdeoLwoRzgRs
 6VBQNwORkjra+ae5buhSfR3wOknItPqOow3pXxqiz3UZRojac2aHvuQvoMwMDEYlJp1OO3Re
 JYlQAVoUi7MWR4MJVVHF8dr9AuvriCiL2MB8Qz9SbAMy2PUxwdw+KP8NcLcPN2MX8Rc2EiCz
 l8q5Ez8BQwGcsOSw3yJ/xpAm9Mjgwv9XosIF4yS7MJy3gaC+Dc/FkUpREO09KzRZlGFZ/pTL
 Ekd+ywLpKc09VC2QtSVY/FeiCHe1vL7c4UJe9DW+D1h2YKJu1rCXDRsoippN4x/5JVeqSkCi
 wfR9+4FEwCDp5W5ZBpxHJ+xqjWuMCIcMHVqicQsEFVZuoGLTG0btBLCT9BnGai5y+X7EDXiq
 w1mQQA7gKgPy9EG3eO38DgrYg5ARLCZE2bZBS2OAApJCz+Vgqb7PeREDnCFt559wH6xFAXpg
 ZT+p+CQ7foVEbaGnzGXTeMGEdmBvqjZa2yN0AI3R8J5qlxBHkJPm6gAuFmSw282Y645lcPBO
 xG7Vf55ucMCZyT0BUOJS9jrU517pUQfKTgVfqmJMoQXO8YZmP6vpW83LU+Ww233lkUw2agwU
 ap3gu78ZUv2/Z9PlWLsL89EieFD7nlnmQv7GM6npzz6j+v2TCPEEd8tbQrVBshkvfPsiFuOq
 b53aZDVoyizpcWlP0H/65AIF1kWIBATXNauwyChXrXfeVUO9aBII6O5/I7NjKQ/w/0FzbmZo
 i7hMqKaoXKm7UD6xcyxQigLQNvSsVxX9BrX5AQgYgSl3WYNe4Gq4PtNfpc7Z+d16+Fpi/J5F
 qFXd8KFC/VJazLG5zVEMcij9tM/LkzziFLcJTehbRg+Y4VkGV7D9OjkSQ2zpiMAOSy66Jklq
 Lq62wKHGpcOHlwwDMvfZP+14Um2uHwRxLB7U0fSfItMdU+q/IUzc379ifo+IsctLxTfx2LGh
 ljMXkpC/bHA+tZn/sPIiKaIq5aSP9F/RkcKTXPG6buWNDXB+jTxy4F3UNGOIWLXWlTy9fjwf
 u5S1fz9bKYKkVsW4YpxF7FnkfA369f1/uYIywN5ADPUYl7tBr45eiuK2sxGt6tswL5FuFLqC
 xzVpYQAYe2EaJH/DVocBAs5deDdh/sarTnl66hnKkvN4iIqrqGMVl9fPkXXhSEBfqF5Npgpn
 bUotMIMslXtjx03LpCZgyoS+2nVdi4MVKAut5c7Bo73i1N3mw8YPsGGUnf7sMOVdtFBEkg2O
 TvK1qDMsLRrwBaQeXQEE3WQj/FWgo4DuUwRwVIPT7hTdgEpWhPqMNxtHTULosB9yxJaz6RsN
 2ItO0AdyWBiOdt3rJArYoxuM1gp6N6lFojZ1FYD0mHUJ6VtfnKYN3UzYI5h42hAm1+xvVFnE
 HWw12vvFzrnFC00Mu3eRmY9w8HeoRdNGsEuVSxp8wlp33X3XNY9vpKTWA==
IronPort-HdrOrdr: A9a23:JsM1Oa6PGvtkVfI+BwPXwOzXdLJyesId70hD6qm+c20wTiXqrb
 HMoB19726NtN9xYgBYpTnkAsK9qBznmqKdjbNhWotKGTOW3ldAT7sN0WKB+VHd8kTFn4Yx6U
 4jSdkaNDSaNzhHZKjBkWuF+poboeVu68qT9JzjJppWPHtXg5gL1XYFNu4Rf3cdeDV7
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.88,348,1635199200"; 
   d="scan'208";a="5156234"
X-MGA-submission: =?us-ascii?q?MDHewON7zDdnRiFIVF+wE4ErQNenYkL32iDrQF?=
 =?us-ascii?q?qyCMj/L3PILMPzbFgAyAAMrRufcmESuveybMBNJmRR1qI89Wb7v6k8cl?=
 =?us-ascii?q?z9byzz7rtnVaYEfvEnE8oOGfDzfgVM9k2O2EZWrSH/wuBIJ8oK6mhqD+?=
 =?us-ascii?q?4QuEIHWhDysxHZIJq5CjkTdQ=3D=3D?=
Received: from mout.web.de ([212.227.17.11])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2022 20:40:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
	s=dbaedf251592; t=1644176422;
	bh=aMYJS4GzskHiZhnxlmfcWkGwSjsC9r58frkCxy43mcU=;
	h=X-UI-Sender-Class:Date:Subject:To:References:Cc:From:In-Reply-To;
	b=Or3iuNeFe7V+wIF0BrE76EJ4xDFvjXkUIWWpZgJJMa74LvMQmb1WkTjQIrr/F3IuK
	 pZrcMmA9vYjWerUHxhI6Qk213CbM1qSR0/gcoLSkPIuq9ipYu5uXjXe6+7BELZObSD
	 XmUYm2J4znqyoO/EAp8bRlArm0EBo7Yg2k/7I7LQ=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.126.86]) by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1M6pYS-1nP4Kh3k22-008GcH; Sun, 06
 Feb 2022 20:40:21 +0100
Message-ID: <42fb2d32-0b90-e485-3700-04d8a074b9c6@web.de>
Date: Sun, 6 Feb 2022 20:40:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Content-Language: en-GB
To: Denis Efremov <efremov@linux.com>
References: <cd9a37f0-9a90-1df5-cec7-853a783e5538@linux.com>
Cc: cocci@inria.fr
From: Markus Elfring <Markus.Elfring@web.de>
In-Reply-To: <cd9a37f0-9a90-1df5-cec7-853a783e5538@linux.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:cFvinHfC0jhRgMIY2RTt5gVsa4D9ZfI3JocqZgXBwwWxaA7soVf
 WEeU4SjiMTwdN+1nx4hv3a5L/y66SGzBCdi/38X0uzCKcVD0brnf8X74GFRcfA3S2ZQTD/W
 xq6R62+KvXWfgdUSzC+plwn68kEx/iBLG1vh8CXI3rjazogoLHmjXSsvf2TfusG61+kbAnl
 e05r3I9X9u6hNmwklwoRw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:FTHM+1QG7B8=:T3pE/TDYvFVjLiOnoZt74p
 MwwV8Wx+F5LvU7UkT0wbBpm+Nju2bmqi/VijOIDqZ4TNne+GtNOup1U/zFpzqSLnr4d+9CKrN
 +wgDavdF01/2+zjCZ8tP4pFhvZSUD4wSNo08pTIrgAZoCnlMo6Zg16w5SoNzSoTydiwnpyRM6
 3dP2wHg4RrVNQ0a/dW01FIZdUT5utxD2OMAUmfPc2kB+mmV2lhcuM8shCCssgdprpn/7dkMfn
 7zh0buraENvK2UJWHw1jqoY/mvCX7zyTZkVYQrGD4PA6W037On2ZW5b2TymctLb/XX+QobdEI
 9z22R7+aypa3LJK9G/nHIz+qQ0uRsa6AJFhW+KVuQxUuyC9rCv7VXy9KZcCqs2FVs/SVb3jfw
 cYJFbIwed6pzb1bPwl8/NKhfEcFt7ERcRpsjrcvN951siFOopBYxBjL7Q+Mk4c5PGYcEjLILI
 7mYdKNy5sLp1fV1ZUAWWVjdhhFq54jhvVyNGxOTopFnJwbFfkxhc4JX3pid41X+tbh7Dqz2Xx
 ZFDDHOmu6ACa5b3cxvm581hzB6K/JNiJW4fDkb2WQVZ071qH5pAoVtfFHd4vV3Iugx+PWwiPe
 4dDsfnO5Uwz6PeSqsjYyGqcbVUXt+TIWjVd+1akHESX95UBkq00YPHfY8gvJgXE/+Cvm7Poaf
 LGU+iOS/cZ4JokL6+Lo2SCIXc9y+Daer8bRORSJb5KGprGJEr36ZahCmo2wQTEWT/jfaddrkm
 qkWI/qDno9VC4/SqamxurRbVs8dWNifgPLO7Wd/uwGHa7zxmi/kkcsXEEHUDRNHx10P1IwDWG
 XF24Q8KnioWo5/Js8dwRGM80gXXKvIVJB6bgoqSTdFzci9mxEm7SHLbXeY6YI9A25Dbnhu+gy
 FD+SIngZ2iiCJekj+zmeayFB3BOzweEp8ocuUXg6/QNMMLiNI7/j64Cw9lVDShjyhwZ2ZLEzW
 adgcc/loA8BgQBP+As/hqT7eCOHfoa79kvsrLwI5t0qjzXC5dFOwS93TkNwOEeT07GFu/MXr6
 YMu6o2rXL844w13SMxBYBYwAjL1qobZBCmhOm7qEN3F62NobqCH3Gll5a9MjsEswkOdfse+0e
 1zKmoWSuhEwHA4=
Subject: Re: [cocci] spatch 1.1.1 segmentation fault report
Reply-To: Markus Elfring <Markus.Elfring@web.de>
X-Loop: cocci@inria.fr
X-Sequence: 126
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
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-02/42fb2d32-0b90-e485-3700-04d8a074b9c6%40web.de>


> 0 files match
> [1]    152475 segmentation fault (core dumped)  spatch segfault.cocci test


Can you share any debug symbols for such a questionable software behaviour
(besides omitting any code parts from your SmPL script eventually)?


Regards,
Markus

