Return-Path: <SRS0=Pcyw=ZX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACD3DC432C0
	for <cocci@archiver.kernel.org>; Sun,  1 Dec 2019 08:00:58 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80ECB20833
	for <cocci@archiver.kernel.org>; Sun,  1 Dec 2019 08:00:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="VteC3rQY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80ECB20833
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB180c4N029621;
	Sun, 1 Dec 2019 09:00:38 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id F2EFD77C5;
	Sun,  1 Dec 2019 09:00:37 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C3FDA6104
 for <cocci@systeme.lip6.fr>; Sun,  1 Dec 2019 09:00:35 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xB180Zdp025780
 for <cocci@systeme.lip6.fr>; Sun, 1 Dec 2019 09:00:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1575187233;
 bh=o6yVt/ryKznIYAXEqIYOZ5yqhtchI/3z6DpR17Wd+5k=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=VteC3rQY0ECnZUduwSc0erhBf0fYLVvyxCam65m0yyxbEDwyFveAlJuKCnPqsCoQF
 VnD2VRsbPbazyuPA+iFHNd9iChneyBZKN4+K0dJ+rdOaihu5fmqv3PSU+Tedmcg97m
 UZ5hT9biJfq8lwCJWSOAyEZioKBiJGUjlmoXL3gU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.131.118.94]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M4qsv-1hs14X4AFp-00yv5l; Sun, 01
 Dec 2019 09:00:33 +0100
To: stracelabs@gmail.com, Julia Lawall <julia.lawall@inria.fr>
References: <CABvP5W1W=p1-n_831VaiJyNsHrepFS0CNJSDQqmfPkrC1rx=Ww@mail.gmail.com>
 <a64ca4bf-4d00-6d8f-19cf-0667d9b1ca83@web.de>
 <CY4PR1801MB200527E64CB2C5ECF218EFF4A3460@CY4PR1801MB2005.namprd18.prod.outlook.com>
 <509ffde0-ec26-a58c-d424-6910bc8e7473@web.de>
 <CABvP5W0d-MErjsS5yqfDtPu4OyiHzdurBDHrwJX4iNzzWjSgwA@mail.gmail.com>
 <02fa7455-e76e-7d7d-0d64-41b2803a8025@web.de>
 <CABvP5W0kVE+yBYa7gWLfsegb75fMyMcLSDbsnFUGRnnVoRLtDQ@mail.gmail.com>
 <alpine.DEB.2.21.1911292154450.3140@hadrien>
 <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <0c03f84d-a05b-2811-96aa-6f82541fb8a3@web.de>
Date: Sun, 1 Dec 2019 09:00:22 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CABvP5W3hmmovw09n6gJQ5m=Cps2YAYJFFfOPmKY6Zu_SJOU=NQ@mail.gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:skhQYjJZWhotBMWUKA7IITQXRTjN1jO7ZlN6YoyEjYCZKvDR6+N
 QGKOLOzgs4WMjH6KnBxsrMsLAhAACHm69S4OzjQi9aRTNKWKJSYlq6H+TSVjyi0VIkfH9Aa
 BAFXU1GkBriyvraj45TPXXjNTOpp5RmqV8JODEUT+FEq8ILDTJvH7HkUyfeJT+k1imljj1T
 aUJZnL9j/GPp8tryZ1IrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:AwbxhK4ra0w=:+xUnY6jKBsJX14lCSxdI33
 mCyPbomz82rMyo3EmsJajgUHczKziSJwsqaQFRr7vdmENqvyjjS6UaoCUHC7Qa2ecfSO/F3Bb
 jvxgQO77CF/95jXiJzXBL7HDtnCy1PCIdiBgxgyuClsslvMeFtoVWjvSO324CfHhoT84FmqBb
 Pt9Qlzj07Ce/oCL1skTTGcEg8rH/Ca8Wkm3amQyz9cKHKvguqbVDTlpTN/MeNv0WGmLq/ifEM
 QUzC87HBtMfK2elyncZogzBIIKJiubFgGdOI/F1+NoJ2Dr8BvvzGDytZu4PQlcUe5x7eAYJCj
 tXFZQW8BH3dCARHAUDZYI01jLuh4+uqXRbqa5dLQz/qRvyGRzDlWDSoR7ID450hy1QRP5yOOh
 U5QeRGfEx99aow/tFYXXBJ2Alge51ai/QpIfBa1iJh3pj04141Y6fdQBRpw2LVTik4/ofDLcy
 4QE3IL73wEPwbuMzFxsxy2mggdShEzuo011hvdqKi4yyMHYMALkLn01Lh9PDRsrMQTV8ye0K3
 8s1EbE6AWqYi8/NSKE+O8i+XmSqLYVx7f1BpeoGqmtNKWVs51+uuGrmJ7N2zwNDSR2Cma1u6g
 ve8vnHl0NquZG9KZyjVc+rmuThjT6f/wWVNXyjkfwtW20FzHVGQZ3Uyp+/REoHt3ousPOW7Kf
 Xy/AitYeXhzsuLWkCQ7mVDQan9O5q5rY9lC5AJqP95aKIRtcsVI7uTxa7vPOhz8XUYI+E02Cx
 I2WM9McKdcwXUo64QzfmRPquWddmix5N0G/1CUCAdrIF1CimKP9eNEQAQIJdjAixh+4zTetWc
 5dYMCe9bGC5STGA68Fdf0lXdNkyNH6uNc+5JhX7VBbMt/Pkji5nHh9x+bph8YHulUCEtTerXt
 mQoVCqnsFCc00aPncvgZQ3HONevnp3m0p4a01l1gceDrpLImH2ljyyrDnrEDR0bdm6cFR8k5h
 RyeFw043Li7/Gmr8im/6fCptittgId6ubck2YqDVXnzPcorSVCuzcQ1xfKSNZksLLIvG7nwqu
 il30ciiCFDtiW7Y1Rlj4x48jpgctuQsHqUAYuqZtBi0zyh5jjAgaMU/lbW9mm9DUFc17jrWil
 aCw7ZamoEWszoHUwwDOHCkBKjRUoGSkV7BfObvEj3H/83x8pGNrrV1Vl/Zd90Y/vbhkvcjvYG
 ZzDPEECZ0l68LYgKCeoA+HDlViGYzJA9iUugNivpKHSm2ObIGjomd0sMtawBdoCQSVDL8xZoK
 o8dGwF0cMDCqWrdvHeK3EJ8FEbkn/OrN9v3jS+Jt372kj1/p5eGE4yqIas0c=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 01 Dec 2019 09:00:38 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 01 Dec 2019 09:00:35 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Changing format string usage with SmPL?
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

> Basically, I intend to replace alls "%s" called with "mydata->name" by "%m" with "mydata" or "&mydata"

How far would you get the desired source code transformation based on
software extensions around a search pattern like the following?

@find@
expression action;
expression list context, inputs;
format list fl;
@@
 action(context, "%@fl@", inputs)


Which algorithm will become sufficient for your data processing needs
around the usage of functions with variadic arguments because of format strings?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
