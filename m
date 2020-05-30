Return-Path: <SRS0=5T8e=7M=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1ABAC433DF
	for <cocci@archiver.kernel.org>; Sat, 30 May 2020 07:50:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 16AF320723
	for <cocci@archiver.kernel.org>; Sat, 30 May 2020 07:50:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="hyZb3JAl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 16AF320723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 04U7oQUx010501;
	Sat, 30 May 2020 09:50:26 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DC7A73E1D;
	Sat, 30 May 2020 09:50:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A231A3C89
 for <cocci@systeme.lip6.fr>; Sat, 30 May 2020 09:50:23 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 04U7oLCk013062
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Sat, 30 May 2020 09:50:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1590825019;
 bh=OZ2hAK2xvAEMsMcleErEqanGHEAdD/lkSy926btWuek=;
 h=X-UI-Sender-Class:Cc:Subject:From:To:Date;
 b=hyZb3JAlWIVnf6puIXy2V65536HnZYgg8pGEuL4pTqJAnTW3ZUeUjKZ4QPPrClcVu
 Ko2S8kJhlG69AWlJP2rwF7knJyL93AO504SeOgPiVcniJlUAZqCzUE2d+PCtymiiHK
 8S52VJ79PmR9Dlert/8IvYq6qbbl3qk1kwdJ5Gvk=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.149.250]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MYclj-1jRYOO2Mk7-00Vcsd; Sat, 30
 May 2020 09:50:19 +0200
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
To: Jaskaran Singh <jaskaransingh7654321@gmail.com>
Message-ID: <9c30ee84-edfc-58d3-b246-f1e35e578357@web.de>
Date: Sat, 30 May 2020 09:50:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:dtb9WFM/z7J3d6mPqpfspxYtKvav+2DME9lMJZP0Cq3TCmsDvL4
 fmA5OiBNG8yKVE/ojJAYfVdEPQ3uJNTVH5CK2z1xDEY9oKiks+oGHV1x9Pbbf8UXvxZxP5o
 fc9cvOMWGXfnPvTFL0R2X/gLGl8IPXGtC0oDhZHyYq/4IDF4BcpyvCx2jLaUfB+YMM+teB3
 Qkg3oOQ9tUdOoqIafascA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:o5wUZSqL0R4=:lkkJ4fdt7K6Q6QZ4JCkom9
 4kMPCT9ORKLs2wZzSf96GCqw1kldl5r6yX+y0a2VNfKcAcIEgVcGI8kqaexgXJ0NZciBMiNPx
 LXjGadrJUbbL5SK17ofHHTE4uVtYbudQwQvlWnyCTOmuALRc5S5bzghRwNfQtZTUb9yXsflQ5
 gv0dr6G3qMjLWElTJdKvcnZfQZ7QGoClbOLf5PYWly1x3P3zrMsrcQqCUEKgb+hNE1ZyKdqbo
 NdWqSIfTFGBTCqZ6NV4VNuqz8BEiyXOGiIwACOK1n5xIw8GckyFPE/jLUR/1orBwThBN8jCa2
 98ofjKscvyy7kSvKQbfMIipDRBq18k4h05sF3YOsuW1QpRGtapD7I2ipyh2rdox7asxZt8AOd
 gKhxSUvwN/EfFdAM3Q4TfSJ/8pr4ahBRnyLIL5dQI/HGBlVpmIe8yfN5PAlkAC4KsH3DBN2fb
 S5vxczSLEx+j6F/eoR8ejoKcc7Zwm+wwgusPmgAJja9DdL+nr/xVkAmu9wEr8mnIqn+40mYRm
 Mk+YxapDl03KrIFVKondo9C58UJylkd0oQs3fF9VCvDtsk+2IClJG0mARfCUaXqSQqzza3aIf
 ZSgf8f17pogqM3kZ+rWoyGSi+f1VtcEb9jUIHzBRluY5a0h6ln3tiCEeRVYGwK5yBP9sn/x3g
 dMa9L3ZQETXUOhCfc9upQByBLPHn4nrad3OZuM0Ua2nHW5fHDjKNqHb38p0g1I4LhXAiLG1+F
 6YOy1rRs09b9i+eG+yI3NGpySdDnu0fsHz0zbd8VDmHNHjSXxTnFw0pfl4Q0tRf3R/sqPz/MB
 LxnHFLW4IOd48OzxdkFBt9LfHVH+3c9xu5pK0hiocXLSPo4FuB2bKFm/IG5bJRLCmtBdudPXC
 Br9RRq7Fg9i75YE5bUKXqKExNY5iQ57JDBeQVoLq7pxHvBFvnONdXhscPiMW7aE0GvY6wFr10
 VXCJQ0axrITKzj/rlSUT3rTCrFHq0RVqVia1/L5QPHyJzov8GoVJ75TcJGO4INIiWKxEuAPHY
 9vlPUVeq9t9kudDftARExBzd3Du9J9kznJTGhTYXVhhC2vY6YYb7E/JmiO5NiIMxrd00ciHPw
 IQk/v3Rp8s5SJZUbMz1QIQc3QpAlJ0LbuLu2Vj6YRxHVAEiqHMhjPuz8Uu0MvSRV0kincyFhi
 BkzFRzKv83KWrNgzY0YbyNBAGI/rNmQsFgIJmFV9HcduTiOMFXXOfysmaNlWEjay7zvUuMLE6
 D46IpW+lpDAKLi4QT
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 30 May 2020 09:50:26 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 30 May 2020 09:50:21 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: linux-kernel-mentees@lists.linuxfoundation.org, cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH v3 00/32] cocci: Add cast attributes to C and
 SmPL ASTs
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

4oCmClsxXWh0dHBzOi8vd3d3Lm1haWwtYXJjaGl2ZS5jb20vY29jY2lAc3lzdGVtZS5saXA2LmZy
L21zZzA3MTMzLmh0bWwK4oCmCgpXb3VsZCBhIGxpbmsgdmFyaWFudCBsaWtlIHRoZSBmb2xsb3dp
bmcgYmUgc2FmZXIgZm9yIHRoZSBkZXNpcmVkIGluZm9ybWF0aW9uPwoKWzFdOgpbUkZDIFBBVENI
IDAwLzI1XSBjb2NjaTogSW1wcm92ZSBDIHBhcnNpbmcgb2YgYXR0cmlidXRlcwpodHRwczovL3N5
c3RlbWUubGlwNi5mci9waXBlcm1haWwvY29jY2kvMjAyMC1BcHJpbC8wMDcyMDUuaHRtbApodHRw
czovL2xvcmUua2VybmVsLm9yZy9jb2NjaS8yMDIwMDQyNDA5MTgwMS4xMzg3MS0xLWphc2thcmFu
c2luZ2g3NjU0MzIxQGdtYWlsLmNvbS8KClJlZ2FyZHMsCk1hcmt1cwpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxpc3QKQ29jY2lA
c3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4vbGlzdGluZm8v
Y29jY2kK
