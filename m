Return-Path: <SRS0=zAny=Y4=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1A94CA9EB5
	for <cocci@archiver.kernel.org>; Mon,  4 Nov 2019 13:45:40 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FB320B7C
	for <cocci@archiver.kernel.org>; Mon,  4 Nov 2019 13:45:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="IwXfVRhf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FB320B7C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA4DjPMF012223;
	Mon, 4 Nov 2019 14:45:25 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 0749577AE;
	Mon,  4 Nov 2019 14:45:25 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id BCD7C454C
 for <cocci@systeme.lip6.fr>; Mon,  4 Nov 2019 14:45:23 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA4DjMi2026091;
 Mon, 4 Nov 2019 14:45:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572875122;
 bh=oPwm+Vq22zdFsCBBRYOkwZqL20f2KIZBvIxKbcuF/Yw=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=IwXfVRhfEE6AVii+lqlNPxPTKdhcm7AUffBaK8lmpirLrvJFE+h95Wbm83hv2tqra
 Am/bJvYgcMY7oc4/WddQ059YGxcqb3ZjzgKl6bDy/112kV6TjrbdihmN31jbhABOCU
 qgoMNwXjjN3Q9957vdbUigfdYdHvsk34x8nq5NUc=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.71.222]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Leca2-1i9aWd3O62-00qOuq; Mon, 04
 Nov 2019 14:45:21 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <1ee2e380-5e38-e2fe-7e4a-ba2ce01f72eb@web.de>
 <alpine.DEB.2.21.1911041437360.2870@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <baf4ead7-3e0b-cbdf-e9e0-f574835d3b59@web.de>
Date: Mon, 4 Nov 2019 14:45:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911041437360.2870@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:v0tAgXjXjiM9r0+ANCz32ioj5d7sjQMrBiHfxLoX4MSVbw2cmDf
 DtGCYYizWxY7nw3UVEZnL24yWfwwS8wpeFq3qvNZB7sEuR4rA83bYLwmkDmx5H5GL7odIVk
 qxX8NLOtrezx4B16Ob5UFEe8MJ5Qlho/1/ojqzqtRmwkgL9gU5/RdjWMoQtZ+6/BkRGJ2Ft
 IOpYRo+7YULvJ+MZEyI4Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:oKybLO2m0GQ=:SEdZQQ3aM3MAzy/P/PWnif
 LqWTzaPS3WRRBjzciJif7vYRMu/gFNmPMe8cjjza3fbK+kgYf4z3q+YFKQoPhaLa6GHzzwCqC
 r8JjBG4mxvEdAATh76PRhiAcqAyQcdJ4QCLyAYq6WO+cDIUoJQqXKcJSZXfFE6fVffswe5ogJ
 dlI4uxfIzgwz5WHtp9V2LyDzKFk0pxje7VfwzRA7Gojl8KaSyAaFIF+wRhVIdXJNIZdpJS93f
 KrGtUYFzMLfGeht14xHaXe5/R5Z7ybv5fWgQQDgAJzs2u6TURRm2dcmAZo+iu8npgummKs32p
 zXiEk7qii+pAlRRGWuCff+1Mx8DxixIlk6Mrm3zSEMcWdOjiXOeWiH69pWaUtPUeLO0ibgS61
 RwTmwi9KbxPStrDq+go9dX7pVmgBz+FPyOTmqTi31CVoCvGISvPUVCHEnmqzCXdVAQbyrkw0H
 7ZY4Qu8oR/oLXxeQ65XuP4aYoWlDLefKCP6znZcSj1zlk6dcpRdlxwnLrwmQAtUelK1My0ou2
 FcoSuEtYc9GP67+aVKeC80Ed0XMLzewfd9wsajxlEIbgO2X2dN1/REdosRxH9sbIkCfyKSpap
 G9g6yfrckruG0x6pHK6VMljR3LBbvM/YB5UEAom/DuuzFNmIWRr+OpGQsjUoQxPUzUf6exbys
 ZdaSCuVQqm9zhV0mME1sMxZ/g2tx8TdUBOihDDf+e0pNtXhxiU2G548GHfcsvtxE6WdTAE6RK
 unV4CZpDg1HghiwF1LniOQCrzI79rwY+RtiADWyjFybCE81IbVBKdCGn4vnWIUnh3bIX/iew/
 +aw+L0w/8swQig5JaJqRYmA62EeUmehz3O1Txu0A5pOCAyUP7Oc/pJLDmY04yrpwEqezME1/m
 JeCRo7PJ3ZmH+LPK5ltYiJkiixvVZ6c1pdB7FfEhtIDEXwkj1Edt4aFE/77lFDPlKcHZu+dFf
 hvCijdCL+yql7HVSjubRj1wjCIpfvB2MICG8vJbU/3L+u3u9RkmNzs2SKrQIbCxkdYmmAgg26
 9WBAPP6zk8Q03reHvw8KC2dWeNtGbaSY0n9+Jz4RCofvCY2FP3CcOuVev56br07ZU86Oxf+Rx
 kYOqcL+WjNOMZ0wo6pfYAO9oDabULKR3Z3OSjE1B2wdea6bMXHaHXpXxprk/oAgzPFTuY28n2
 LBxCNo0bMmD4URsHKAsJ7/tC6i04qLpaFe04D796CsTBNYxXhXZ6IGFDVD61aufGXA56Ft3Zr
 wUAs6HHsCFCjz883pEy3cFoOA7R90QYIMGJWehhrOq7tH10KOzEMYEel4euo=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 04 Nov 2019 14:45:25 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 04 Nov 2019 14:45:23 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Coccinelle: zalloc-simple: Checking data processing for
 a bigger SmPL disjunction
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

>> But I would like to add the last case distinction also to a similar
>> disjunction in the known (and discussed) SmPL script version.
>
> What is "the known (and discussed) SmPL script version"?

I am preparing further software updates.

Fixes: dfd32cad146e3624970eee9329e99d2c6ef751b3 ("dma-mapping: remove dma_zalloc_coherent()")

See also:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/scripts/coccinelle/api/alloc/zalloc-simple.cocci?id=a99d8080aaf358d5d23581244e5da23b35e340b9#n47


Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
