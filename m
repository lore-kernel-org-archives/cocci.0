Return-Path: <SRS0=b124=YZ=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40752CA9ECF
	for <cocci@archiver.kernel.org>; Fri,  1 Nov 2019 11:50:53 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AA2F208E3
	for <cocci@archiver.kernel.org>; Fri,  1 Nov 2019 11:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="FQRKOYp0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AA2F208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA1BoXCl003383;
	Fri, 1 Nov 2019 12:50:33 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3BF8B61B4;
	Fri,  1 Nov 2019 12:50:33 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 676F1454C
 for <cocci@systeme.lip6.fr>; Fri,  1 Nov 2019 12:50:31 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA1BoUTp020272;
 Fri, 1 Nov 2019 12:50:30 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1572609030;
 bh=9K3VvGg5vsHWZtkS4vgcgacUjZ2Pe4ly2zUeg8SUqWU=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=FQRKOYp04PttN4tfAcLBZwwFEReIIBZhFgf5yKqALNjHZjZCSRXOzJoPdrwyYBGfP
 pKKrMxY8w956UVQDFx7JMAFVqTg+FRqiU9JF/5Jh8mByug+1mp3APnYS/RgXFFutLB
 Tv7MfQRV0faPNknpdeNeOHS+OP77gDuDck1GJlKE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.35.66]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MSrgv-1iYa5D1zEL-00RppT; Fri, 01
 Nov 2019 12:50:30 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <708207db-69d7-8962-e507-cd705142d0c4@web.de>
 <226b4ce7-8284-ed03-a478-98e3e532cb15@web.de>
 <08618116-cd93-fedb-f90e-64c17b319794@web.de>
 <alpine.DEB.2.21.1911011037250.2883@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <af66ffe5-567b-a156-cbcf-73a06ecaeb01@web.de>
Date: Fri, 1 Nov 2019 12:50:29 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911011037250.2883@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:1ELxJlqj1ONH/+YOZAmGGqN63LWX8QDr+Z0o37kR/aco29QmNhU
 rnlFMg5osjptOPDm6GzahdOIrnfSNHJSrguUnFo5VVwWEVttehdMCYy1XalTItAnlLKmRLg
 Rw1Dz8Owc7eKLd01/LKjcju33PH+3z0oJjdRhSG2TDAKliScY+WH/CPmoxQsOgvq1cqboQS
 QluHXuBgVEhNuYIwupaKQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZaWK/AaBpxk=:mPOBoEKpvcTnlJXh1yAQme
 SPbGhzxy0iFtq7aclamWpQZuNSJS20mOU3whZs9qPn9MoSVk/5mn1INiTvghMO5taX1picRci
 3COGmKjVoLTEa/JReX30RS8h2i8Vcd1+pV/mftFFb6f6Nj2C57Ml3gbJVcWK2H/p4pV7lBq2G
 PPTVphb3p9yXzqfB3cdgPvXHN3vmS39voylMjuvhfpNlGyzbNuJmhMCBsHYDcL30INazhSUFV
 4e75yavJ9njHIlxfMb+YoYAmLkoe93P91iFjMJ45Cl5LNyY3I/jg2uEI+3alEBcepg/pxazo+
 CAvFNUOFmDaDL/sIHlwOXidb32RuLd8vhjQDxPysw5eX9a2oQX3tJnrJZ4f6Gx6ZQuXaIjXvr
 ki8wLCw4ddOv+jWf2SbpmYuWfO7e2qzELghR7n4Q+AdeDAJrGiF3J69o2dEPGPpRhFnYXtNrY
 JFggzYht/qcPKKc8UFGqxGx+8l9TyFkFdX+sh6zD01//+5MOOw10aGFziBAO5PtEpobmXjutR
 Md8dasYDzY15D/rmxnZgkVouCqYBTVp+GSagh7nfNDIHg4LpD0fVBhuoWdI2+F04T7dKxJg4P
 1LNsj3gO0YVjwkZv56fVG587h/13NBcKUuKFSpq/NHlHPlg4uE7aJuL/3SO2Q/7C8B7Qk2VtK
 mFeEZrGh5trzKBorZ0RkkoGesAbjnpBG1J7qCpEmbqWTAJbRTdBxmhTizc3haWgUmxrxUj8kk
 NX7bKFOPf8ZqBuYftwR9ESJ9CmmmeGIDRvgDDj02T+zFx4WRtGIrUnz5R7UXUP161oCxTG499
 h4VYVtt+GowS2CDdqOesMk8Wf0uL/m9+M5RGSmkNlNia4SVqBQbJcCG4sKXWMU7X8SBvduTDa
 E2+trSctRE2M86rUhOyH0RqepmzDnyivGRDTt74EEoSnc+DcATDiwLRly/7UQ++NVPriHVLG+
 H3J3bI01LkfnbAMC9Yj6fC9+9zOy11NaVgJbur4GGBrEM/7gwFOzlz+zhB3XXngyNPavz1iww
 b4IgydrlJhk1ZiDCxlH2TmRBCegSc1J7AhWGLeFcceYokq/KxTjfaexGbm9jToyVY5khDs35Z
 BdHOn75Ig1dCfq+kR4MdBsiFzW2LhexrHdavGwdCLiUsxwpINPy+I5GezwLcDE/ahksBKNU0f
 TC8ZrCoKXumMsf9dBh2bqTDDgQILEgBkyxcalbkzfT8canozM/0XQiixfXS6XohAAaKC7FYSe
 x5qgQbNZdlRaNYaRMy/1pHubrKjklQ/0OjPnKHSrro5Cycvf/E8LkqhDrYvo=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 01 Nov 2019 12:50:33 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 01 Nov 2019 12:50:30 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the occurrence of trailing spaces in a
 semantic patch
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

> How would you like to improve the pretty-printing for the Coccinelle software?

I can reproduce this glitch by the combination of test files like the following,
can't you?

@adjustment@
expression result;
@@
 if (...)
-{
-result = -ENODEV;
 goto
-     out_kfree_ioc
+     e_nodev
 ;
-}


static int megasas_mgmt_ioctl_fw(struct file *file, unsigned long arg)
{
	struct megasas_iocpacket __user *user_ioc =
	    (struct megasas_iocpacket __user *)arg;
	struct megasas_iocpacket *ioc;
	struct megasas_instance *instance;
	int error;

	ioc = memdup_user(user_ioc, sizeof(*ioc));
	if (IS_ERR(ioc))
		return PTR_ERR(ioc);

	instance = megasas_lookup_instance(ioc->host_no);
	if (!instance) {
		error = -ENODEV;
		goto out_kfree_ioc;
	}

// Deleted part

out_kfree_ioc:
	kfree(ioc);
	return error;
}


I guess that the trailing space character is just a questionable leftover
from the desired deletion of curly brackets according to the affected
compound statement in such an use case.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
