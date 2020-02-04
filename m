Return-Path: <SRS0=4B11=3Y=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF6E3C2D0B1
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 11:45:33 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B51F20730
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 11:45:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="pGMn0x/x"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B51F20730
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 014BjG90019431;
	Tue, 4 Feb 2020 12:45:16 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id C597177EC;
	Tue,  4 Feb 2020 12:45:16 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1EC6677E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Feb 2020 12:45:15 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 014BjEiZ018636
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 4 Feb 2020 12:45:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580816713;
 bh=wnq+x2OiczTqCRYD8wMSr6PSuyQiVKhwlgW5MHRu5Qk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=pGMn0x/xOEQ05zpMq2YFxEngm/oRsfeBnyy6PRdDZT0kTzLwcs5S/p2QsqdYXcSS2
 2/8T1ORRT9Bu+SPLXLbbg8u6/G3vfSzAIjvqTwe3ZeneJOYWZ1PngTUvjtONmBbJti
 RneVbgR1Cj9rwaSlvzN6djg7fL8pAREyqsS9tkes=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.133.16]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M89fV-1jl7Lk1Ae1-00vetW; Tue, 04
 Feb 2020 12:45:13 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
 <alpine.DEB.2.21.2002032151520.3356@hadrien>
 <b318a372-2f31-f57f-4684-62ac2b82bff3@web.de>
 <alpine.DEB.2.21.2002032226260.3356@hadrien>
 <f0ccaf84-1b37-4936-3a7a-d5c11e3ef1c3@web.de>
 <alpine.DEB.2.21.2002040913290.3236@hadrien>
 <04e7cc2d-8c7a-8d8c-b9f0-55cd7adaaa85@web.de>
 <alpine.DEB.2.21.2002041200210.3456@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <349ae8e3-2630-dce7-d1d6-1221059df948@web.de>
Date: Tue, 4 Feb 2020 12:45:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002041200210.3456@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:0iJt6W+Jok4gW3Z/v9DsDa/H0nAcFAGbqLeGjtNeaZlMv8TDynu
 g+xOtITAfevK1Ix4QHtB3c6438JyA+7U/eSKL1DWwVUgFkWGHcZ0/Dwbm5j5XBHAgK6M4nK
 8EZCjYFKZMpekwJvm611WjhFJ4gOBEE6I5Of7Hv04NWPrc1yUbsGtTnGwp1gTFjJsQ4ls51
 nNEujYYLYZkPw76OABm6Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:rooDlvXFEHE=:xveGTCKPoQalX3RUre78C5
 eSKzbnH1wr//xAxOvclXfyyO1V9VskmQvPfqAK6BxIHH3Ni09OJWtICwKGGk1tqykJabLwNs3
 YaXR40iE0vHo1bh6yIKtlyXActRLxoV3vxliYGplXp0mt2wt7w38XUa03EXMQxmyQEQwGFgGx
 xHCLgpp6DSFn71N281nxMzbHcNss7a0qN6hkuAjEckb5hqNVgEwnLMFv+yO7rsouhEMBKJPcz
 4QG6+sv1JRYDdIj++DGL91tpOkZlKTTmwVwvfZwk5fHIIzeWCuQw7u6aQDzkIRt4ybpevDYkh
 OPWoN5VCCfWdqxC8Ev3qA7imowooG0ypLMCozMy+Ue7j8wzGKkWb2FPGQKa5Wxg4WE0Z8tQml
 5XBDOl4cqb18ms5hvYO3rPr73r06PE/wAGNl5ji6dMNc4AFkImTM+zSptyXYi8UtoXOZZJA8/
 0QEFOqzQ2SL04NlIH+gwBIQCT5wqcK40dNdxuzwgGB1sdWWPf2MFAMWXyPwrbJsG0QVF1SPAE
 fmtcaAe+yKsB35Z4PZa9ifA4J95CMZ39aAlGTZAwX0rl8ZCAfjKWnVKyl22WCzTynx60P9BEC
 41E5LKXFXNfFYlkL76EoPpKL5Kqq746qONMdgeRYNt6dn5IRKTJifIyL0qfUAc1Ixes2sdUCJ
 +UYK+Lp1+P5hFbE/lmVIXtq23USyLF5q5y/Bru+3FlJ7eQF0aSkWRKE4jnxR2H/zSzZxXMOZb
 smjk3GVX+oz6TALPR1j/wVAJpQBQcCcbNA8IT/5oopXCQ3bQzadvsFSmIunNVy6eq1KAIYIzX
 bBccNVOGO18FMRgokh+prziX40SnQ87O7EbqaLT1KSM3I+iWX5guvdoxcsRRwr+mOlx92pWpl
 pYd8XumUJNfjQHDVGhhTbAxr1avmTzTIXvVxqTxNidOI9PNgpF+yoaXE/o/qtfKxoAr8+3D5y
 vJzrJFSNNRHzaXKl+NSnnw2loJWRe+XBBrE9y6IPT3nZMMzFowFvGWx2KeHfTdhleNfnNzjWl
 f9TWAsBYF6iSZRz0e1K5773auqJVA7/DtAjHhCe+jjsj9LxHJBBJTZdKnSFFvUiRuLmMi4oQ7
 NWfXm82ZPHrE7P4tFQD/Ktpp7xhMZdbd47jplkih/2si3EvMG4tejLxF9OD1XPpNRQoYATZQY
 5+mixm3S61l6wtl/XT1Zf5fXYyBQEHfTjMaaOZvGnsrzU4Q0JDML/lEzuBQas4R2Exp/QnB6p
 Q1frk5ZDeJswOQb5o
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 12:45:17 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 12:45:14 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Wellington Wallace <wellingtonwallace@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?Replacing_usages_of_=E2=80=9Cauto=E2=80=9D_with?=
 =?utf-8?q?_SmPL=3F?=
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

>> @replacement@
>> @@
>> -auto
>> +my_type
>
> There is nothing to support this.

Thanks for such feedback.


> So far I don't have the impression that anyone has had a need for it either.

How often will I be the first one who shows a need for further software extensions?


Would anybody like to help any more for corresponding development challenges?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
