Return-Path: <SRS0=LZrr=U6=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C10ECC0650E
	for <cocci@archiver.kernel.org>; Mon,  1 Jul 2019 11:13:50 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01455206A3
	for <cocci@archiver.kernel.org>; Mon,  1 Jul 2019 11:13:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01455206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x61BDTGo020155;
	Mon, 1 Jul 2019 13:13:29 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id CC1847777;
	Mon,  1 Jul 2019 13:13:29 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 5B3B676B2
 for <cocci@systeme.lip6.fr>; Mon,  1 Jul 2019 13:13:28 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x61BDQ7v024365;
 Mon, 1 Jul 2019 13:13:27 +0200 (CEST)
Received: from [192.168.1.110] ([95.114.20.47]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MxUfn-1iRdpQ2PQv-00xtVK; Mon, 01 Jul 2019 12:48:33 +0200
To: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Julia Lawall <Julia.Lawall@lip6.fr>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Nicolas Palix <nicolas.palix@imag.fr>
References: <05d85182-7ec3-8fc1-4bcd-fd2528de3a40@web.de>
 <2744a3fc-9e67-8113-1dd9-43669e06386a@web.de>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <0b48a5c5-0814-6414-39ba-beb1b8b5253a@metux.net>
Date: Mon, 1 Jul 2019 12:48:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2744a3fc-9e67-8113-1dd9-43669e06386a@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:Njcq1x3R4ZJkZ7KiN9HYHt+SP0u7e0aLw+qLGdcuybI5MhOotbE
 xj5KUayYBnDJQQM5w2Tmu/igOpNpoXaeujzHP6XWifVuFEaN4/DR6KioB9s5PEMNfHjRLMi
 /e5O0m0AWSrJQ0eNTOLW+fj8+uvFW6i54UdJdHqMHZK+OKIvjmjoMU1w0bMlBAIkOONSabT
 VfyI2YWfj+LRfAgP/Zd2Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:16faRLIn/lo=:ukIPtiz2hVH1Qgsj6iGgLh
 vPQkuPO3tWekn+Kg6VLPFg84sNQ2mKQ1KgzVvFlhIAo0fH/O+vUREirICh63S1rFXsPwmDxYt
 YtUuQrmQe+uPKW6+OmbJalKsNx4sEJOPveEs1SLD8N5E+0TQh4xyJ4Utrwlc83LeBTpQBgVEX
 /tIdj6Ff5b9IdsfQZzS6wn4DC7bmIz8oDNs8qPwCRvZp8SwHPB6WQOBX83cEE7cbX+xPSheBC
 eullSD3FPaTDSc+6sAM8QXIj6NG2Iy8fQ8lp403wL1jJ6RJytpGLsdZLhOzrCmlZ2oP79ELOm
 ZaLYHBm7cI+Oz8RdafelaM9i8YPVdoz+BgR4A/vF/TWRmRh/lyQeVcLrj6OnyJlBhh3y5wsu8
 V8z1/f4Qx1mU5hV20RdntfPpzP5MQkhHIfura4E/3xemQNH4V1yki6EWeL6WofApWtg1fBq9d
 po8PMJmrOxjpm5ECUa8UkxU8WC5qXP+QEtx9Rz7s7AU38q7fMhXzmnY1FiUVODSliHTEsp4YT
 5u6dJYqAhSvZk2VYt2AU91Nh9CcAlkHNiVHSvUexIE0u11ZpQEFmZGctaT6rLwvJYakGhs5fc
 UL1AzXlIyu0XYFat0Iq8soRUgZgO+cjApMtRJ7YDcVyTa97Q5LzYVbKTrf6Jkglso45vLolSr
 OWvk9bLuukuzzAnM8PkjVXUB9i3wJQrF2lBLluSqMl71b4oTeGMoTEB4ygB0kn9lwyuS9NLIG
 tlYQ9RE+iTIKzsEkM24ygBGYVnc59SSTW62iuGD6szp1WRoEJ6YXXUeoeHL9eB/azg99P8VgU
 y7laNf0vcE2SdSFsy1u/Tds7PNNLSgGHAQ48pEvU/VGz85gr3ce4eCDscRRCJA/zdmxJYVo
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 01 Jul 2019 13:13:34 +0200 (CEST)
X-Greylist: Delayed for 00:19:27 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Mon, 01 Jul 2019 13:13:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Ding Xiang <dingxiang@cmss.chinamobile.com>,
        Coccinelle <cocci@systeme.lip6.fr>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [Cocci] [PATCH v2] Coccinelle: Add a SmPL script for the
 reconsideration of redundant dev_err() calls
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

On 01.07.19 10:10, Markus Elfring wrote:

Hi folks,

> +@script:python to_do depends on org@
> +p << or.p;
> +@@
> +coccilib.org.print_todo(p[0],
> +                        "WARNING: An error message is probably not needed here because the devm_ioremap_resource() function contains appropriate error reporting.")
> +
> +@script:python reporting depends on report@
> +p << or.p;
> +@@
> +coccilib.report.print_report(p[0],
> +                             "WARNING: An error message is probably not needed here because the devm_ioremap_resource() function contains appropriate error reporting.")
> --

By the way: do we have any mechanism for explicitly suppressing
individual warnings (some kind of annotation), when the maintainer is
sure that some particular case is a false-positive ?
(I'm thinking of something similar to certain #praga directives for
explicitly ignoring invididual warnings in specific lines of code)

I believe such a feature, so we don't get spammed with the same false
positives again and again.


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
