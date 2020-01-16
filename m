Return-Path: <SRS0=PnfW=3F=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A697C33CB1
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 13:03:04 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A88E20730
	for <cocci@archiver.kernel.org>; Thu, 16 Jan 2020 13:03:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WEWo8W/N"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8A88E20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GD2eXx004036;
	Thu, 16 Jan 2020 14:02:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D18F577F5;
	Thu, 16 Jan 2020 14:02:40 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C3FC377E5
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 14:02:39 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 00GD2YG6008032
 for <cocci@systeme.lip6.fr>; Thu, 16 Jan 2020 14:02:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1579179752;
 bh=7BnV0LQz5V1Up3Q41YRqsJlEzn5CnqkHLndWWcJg+wg=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=WEWo8W/NvWD14/bVRuERLY+jG91RlP3D8Wep+cpfds7tILq0yddXnZ2K88czsT35r
 JQfIbfT+HU8ptU6UPcPiWFGM0TIASPRsRsA8Wa3dXr8hBrfUFfVirZovKw4koDYRzD
 6iZ2izodUm+w0a1QOr0tTeAisSgvVV9PqAHohjEU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.6.163]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MRlJB-1j3JAn0vIf-00Ssxr; Thu, 16
 Jan 2020 14:02:32 +0100
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>, cocci@systeme.lip6.fr
References: <1090dc9b-9556-f6ab-23dc-f7d0a8176220@web.de>
 <61e7b9f2d132e6bc9feb13ae8fc4636cd934f0b2.camel@gmail.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <28ea7e72-aef3-b5f5-52a4-270e3702d430@web.de>
Date: Thu, 16 Jan 2020 14:02:31 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <61e7b9f2d132e6bc9feb13ae8fc4636cd934f0b2.camel@gmail.com>
Content-Language: en-US
X-Provags-ID: V03:K1:qGByIz/1u4wdSSPkkctb500I2MgrWVP0L9ehvvq557NDW0oC5z4
 7tht8GLYQtBVL6Mjc8oqKv9Z2mp2vFMWm1MNjWzGuXQLVhPrRjflqKnHFmBFPj9y/LcGHS1
 q6VvWMBMrSuAY9zIcuhXYSXblpm91ONQONEtCrUatoOFBd6hcVJLMpe58wx8k/9NYnlYQbf
 Xn7ugIHz6YS63TPc/x0Sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:VVzHqTSX7gU=:rwBsTqovQ/nz4CbsqjefZq
 Qw0DPZ49E41NgrV6HRlUzbsZwzjGXKTcgP4yRO4pIamE6kVNviC775EQxDJ++wxu+T1DCtZwI
 wsZ6WZQxYkyO4DOARm+URDnxCtwp5voT1s/M7vExkGuD64nXlwzscUV6OSebMQSXDdd/yAc0o
 teG90IlejG2orgkbmRs1yqrUWX2qx6t9bXxHAYLv/zWbzDxGVGIUHuH+TJaE2V/RojjRocu6n
 aqL4heGIhMHUwQaW3lz4hLjkuIKeIhgsd7jv/AA/Wecj2AcuNClDMsbwuMf0AWZKuHDZId1sO
 U01/Kc4k85kbzssWU95kb20VzT/TH+BgIPIjiS+/6zf+iYVtFsya2opT0G1NUYHftw2bNCq97
 WR+AlqLDwgmzBqfTlW7oMkMWqtaPRGuisCxS+7rb4bnSTxvwMqasG6lCQa7d3xTCuRfvl6lBB
 cXpGSnPMSk3mEQsbHQrJ6zPxggYeEppvzCjXHMxl/AWjqKAuTXvBpP3Jcnr41jMspR/Ru1xJJ
 BNQ5q+pCTKXQkLYgpkOck/2KasN9/ObXbsT0kJl/xwFfOIz7GAKm0W0bmTgEqTdZakmur2B8f
 vPIr6Kds0cxYNK+V/Rf/icEq3fd7Eo01wWogiDDDk3RR1T0O7oj0Z2HOAicWAv5oK4YMdrTQG
 GHv+ONlW3mLt0AbNH/1f6e2XojHNpAyZshQPUd/1X0DlSIB0uqnsCzWQAS8ASxYDgqMBLEHj8
 13tJ2Y8xL/QrG2gEmVlW7xY4+91f5PqqSxODBLCcrtle938lX9BfNy7/pmnGi8p+CqaSQQVwZ
 8E6zSwRmvDOoMKy95Wg3iiucjtmvxvLhmt/e+vLsuHgsY2kxyTyBJO+pZoT3c0VtXovCsqC0M
 RoSlniHFAPHhEw212tsb619hKwnUcblguSil9y9V9ZstJDLeU76PevGE3JAEC4TvKMPZmLAQR
 Rhs3q1HSnojdJn7C0Isw9FV9khfs2iaZdBzD603Bv8I5wA8XF8VVGW0IAh7V3H7tfznf0P9PW
 E2gUwPF+ioESG1Gro1d0meo1Y0H72T3WO9nLV0+nY98QGFIdl/k9TJDD7qP4yWX0Pz+VoteUM
 ZyP6Q9pTy9ysQ/V9Yn/bJx0GVaT8VPzYmSzm7YEaE2/0mzRYBv9++lwxTwuQjdAskKyz+5WHD
 VynwroN5qnmlwp5kL88U6YSkAK1cwtpzWpmi86sEKqTfVnlsBpbIrRZ4VwRal7bRP1ZnLc6K8
 OcUyP8w6QtmNXlvf97tKtxsIJB3GZ4tEgNKRrO8nbX9igz/CulOw8ZVDZxMc=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jan 2020 14:02:42 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 16 Jan 2020 14:02:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org
Subject: Re: [Cocci] parsing_c: Add space for tokens after *
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

>> https://github.com/coccinelle/coccinelle/issues/37
>
> Not sure what you mean.

I suggest to take another look also at the circumstances for the placement
of white-space characters (around asterisks).
I guess that we come along different pretty-printing preferences.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
