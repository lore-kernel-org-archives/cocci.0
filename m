Return-Path: <SRS0=TLPZ=22=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFC40C33C8C
	for <cocci@archiver.kernel.org>; Sun,  5 Jan 2020 11:33:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0926120848
	for <cocci@archiver.kernel.org>; Sun,  5 Jan 2020 11:33:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="AjZGLcUe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0926120848
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 005BWp1p007299;
	Sun, 5 Jan 2020 12:32:51 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4BAE87718;
	Sun,  5 Jan 2020 12:32:51 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ADCB673E2
 for <cocci@systeme.lip6.fr>; Sun,  5 Jan 2020 12:32:49 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 005BWnpm017642
 for <cocci@systeme.lip6.fr>; Sun, 5 Jan 2020 12:32:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1578223967;
 bh=Je7snHhuRQPQscFiHnp1EFv4aIwbcmbhjQPAWvPbf0A=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=AjZGLcUefp16gKOHL1btISIlsQAWv6e1aYeZVn/iHV2RVB5v1o3l9KSdiOCBWQe7V
 C3s2VPKlyMm5SFCHBuNNfzfv4M6e3/DnYSaEyJ88vk5BqttEyK1RcNmO75eOfrgnQI
 9A6xSyCSs20VJSwKrkayJtKHB3ryeC7uZZgIIwAk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.187.152]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LbroC-1jX45D2fw4-00jHI3; Sun, 05
 Jan 2020 12:32:47 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <20200103160304.GG17258@pobox.com>
 <08d3a32e-7adc-ff5b-52d0-9e67ed03ae42@web.de>
 <alpine.DEB.2.21.2001051100550.2579@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <b3e1aeca-8416-59ae-83d7-5260493926d5@web.de>
Date: Sun, 5 Jan 2020 12:32:46 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2001051100550.2579@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:fJSxmphlkyTzI2DLjp0J5dVTK4hOd4YCNVdXFsUFvyIhlBRGYaD
 TBqJ1/yraIZ0UQeHoh3vtusDESttv73DhQ7NTSuXKAQVE9Y4DYWOIt1SzY/cmsm+/IRgGHz
 lZGSBdN7IMyWO28xyBcsLtPou3W1gTr3rXJcSAm+7bLC3ZgCXfK7JbBHfieIGv/FoA/zpC5
 uUl+nInkq8YIfOs8BlAAA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ScTEK+etmdw=:Y/EU6hq/reDZhWlHxX8Puv
 UBKLyMoqsSqsVfv/cYfPlXsBJorwzqmCq1jyQZRSNWFxMzO7id7tvKc+Cu//2gZBCsvK/7cLs
 +B8DgFx1+m/3d4ImyFd6OuTdDnETSgB3lAikeIN/kzENzRu66PvckSXa8nttC/IfaZQE+5212
 rGDB+WfdDJFAw9aqHyeum7LR91BBnfOu9jwCFyRBl5zR+AQn8C/p8WyUn5X8Tyb7kHRjKDYBG
 icVID+7UTch7RIsLqUYAyKNxMG7MsJW6n/QNMKhpbNWNIWMfEc/E70xGAPQUSPPhZGWln4l0U
 LEAVO7jtohjPTjHpDS62Mf2tI6GdUifHF1fxqCBKFZ1y6/SYJG6+x5q6z2Jeh2XVCXP8yCEyn
 gFu/4O0PSzNOfsE7XfLS9xsUZ/L3xbR+KmyzKhqtxf8tZekwDb5c2akfcSw91luEFLHKZWqPm
 4aDapcNUdfQSMm/ajIsoG7RA/Idl4QPrgTsML93xfBDSu43pcs+Dj2rHg+op/o1KMyz5wMSoj
 u6+piSDaU3jo/LmqgMH5FKE6F6aOgsRDB0GEs70mINrT+cIjxSTO0LerBJUim7RQ/kophaOgw
 7utb5peT+MjeIQrmoCVMNZevtyYLxWxBJ9NYcxcHkPpgFZ3IawvJ2mjS/FCs5UPMEuwy5my9T
 jHNOScBftARfEttZeIyq2JDKEAsem2RXn14+mZsBgC3tYi08a8hTPEco384qXU0x/X8f6lkuw
 AHfb5Rd0+R28wMY6Cv3AZn0d8ouPXcKYGf+np4/rljN70E6UESqQ49wffOQZPrjvp/RjXtOof
 UqlVU9pMqXPosu61BToTpVMC8H9Bn+McCrPw6J+j5x2ZgROIJyPLm4y7PK/lDnzPD5SA160wY
 om6jXCmTck9ZRerFtWPU4o3txs/MgW+hk0bH2DUQoikjV1k4EuT6lletIlsA4cANxkh6OXjSE
 SZ1/LSLoqII9MDJj/I4ySqQVw4z1UGf8Otsx63n/de883/HMAaZWEjs8e62gDfkyyF0EZFvhb
 xg47zrTCFqLs514QnZcq72p1fOR6gV/47i7K5CcgL4Ah1Cn06tVFt4uk6sEywWXU7BA0iQ3vI
 VjM5P3YA5qdtETRbOOnWpI/v9ga2HZFRsqMwXvrpgcfdwiMUx0rd1Z0uoc9QKCMQwALicm2Bc
 VxtexfxlvPGyKB+dvlTAE6ml7i7OBjmQAwwKlEsGJ3bQj9GeAVGp3FQazneFStA++NGNmp5aV
 hdMGdU5v60c9KSSbZifBnYaU7C13aWgDTogikP97fjdfM8M+8MMMMyVE/SFk=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 05 Jan 2020 12:32:51 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 05 Jan 2020 12:32:49 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] transforming arguments to statement macros?
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

> The problem is that the arguemnt list is considered to be comments.  THere
> is no way to specify to put a semicolon at the end of a comment.

This information needs further clarification.

Are there any other challenges to reconsider for the addition of a semicolon
after a closing parenthesis for the relevant macro call?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
