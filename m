Return-Path: <SRS0=qtAw=UG=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D68CC2BCA1
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 12:25:59 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4E60208E3
	for <cocci@archiver.kernel.org>; Fri,  7 Jun 2019 12:25:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4E60208E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=metux.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57CPlFv003645;
	Fri, 7 Jun 2019 14:25:47 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4DDEF7770;
	Fri,  7 Jun 2019 14:25:47 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 01458776C
 for <cocci@systeme.lip6.fr>; Fri,  7 Jun 2019 14:25:45 +0200 (CEST)
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x57CPjIt012601;
 Fri, 7 Jun 2019 14:25:45 +0200 (CEST)
Received: from [192.168.1.110] ([77.2.74.140]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MbAxU-1gxy0D44N6-00bZ22; Fri, 07 Jun 2019 14:01:50 +0200
To: Julia Lawall <julia.lawall@lip6.fr>,
        Markus Elfring <Markus.Elfring@web.de>
References: <alpine.DEB.2.21.1906060743270.2653@hadrien>
 <5be7081a-8c90-ed59-34da-21c523580aa7@web.de>
 <alpine.DEB.2.20.1906061233360.21477@hadrien>
From: "Enrico Weigelt, metux IT consult" <lkml@metux.net>
Organization: metux IT consult
Message-ID: <a2d09fdf-456d-e6ae-1dae-b24b9f683d57@metux.net>
Date: Fri, 7 Jun 2019 14:01:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.20.1906061233360.21477@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:VKUoVQMbjzkkP/bCKfylKzVmRxnBwbJLIRq3pl/Z/482SqawYed
 r24bCe17ElSCUDCgaC60f7gaRjQQV96CgihqfMMxqAcYJx6KRWmQvOdmjNcQbmQQD/x0OGG
 SZazsbRTmy/s0JyLVRnhO2rM51AR0x/5nYBiJB8BXrRo6IJOcoghY1SF3vO54xPMH+maW0z
 rMtvZj0lsaO0fpPE5sMyA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:7ii8dujF4Qw=:5E48qMqMAfTDpYBs6C+An+
 6+S8M+wviOZENrBJYDX0P26mj0RiQ8vL4YuPoOjpvBlEu1VjoI5Araq7MkYk3Uzm1J36/I+T/
 QiYo4EPZUGLUQMU0QGp72BsZy7nxX5iiXAr8Lq5Nt+gciZP+1jeLqWSWjByMItgSr9Baqr3O/
 OwflowyYsmQ6/f/q7kcH4agsOiDyZyGDC4yoCjlRPLZ9WRJLLDf81THz3LcHwoNERsxcvaMns
 751BskX1h7p6MCET08vcERpcFb2bfOP9E5icr4sloWH9FrK1W8mAI040F9gZmuM5RnQMimbjR
 MCDN4nlcljs+9tbs7ue36BKs131GNrl0DzIQSLFlGVFe6gTeDMbaUNpO/mzVyymYlYj8kFdzL
 p8pU6AXIbd6FPhDVwCrF6cN9lHcEylzGiRC8MkleSjKa8p0I6vWO1k2yjlLNITS5Rj5G9jqXo
 84w3yF3gXlbw+vN5rkpp5azO2H4jBBGu0tk+OcejlYs0WAp0fbIiQzE2/LeQoj3jXXWc6lq4E
 4syJkKAPrLrKcfCDY8SVbbfdMvLKXSYkbA7erBSqinMAomqdOLDyKwG3xIBZwJr0grX756taj
 Y7jAlEOb5fMEEHwJ7ex2RaOWaBCSqTp1NPz4p1S6I765i1qVpZPgsdzaq8HXat/LxsBKqbLXe
 dtKjdt0IO6E8ViDMmc2S6FZ4/vRl2Y1znLN07GoKN2GBu4R/icQz/NPsY8i/7+iElGZY8MH8n
 +ncpZyxwU3MwNCOy5gKf7A7+HY+o4UK/FvXAl9+G7Rg29BqCNYDBUCgEnsc=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 07 Jun 2019 14:25:47 +0200 (CEST)
X-Greylist: Delayed for 00:20:01 by milter-greylist-4.4.3 (isis.lip6.fr
 [132.227.60.2]); Fri, 07 Jun 2019 14:25:45 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] How to replace obsolete #ifdef's?
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

On 06.06.19 12:34, Julia Lawall wrote:
> 
> 
> On Thu, 6 Jun 2019, Markus Elfring wrote:
> 
>>> #ifdefs are comments.
>>
>> I wonder about this wording.
> 
> Ifdefs are parsed as comments.

Any chance that it gets extended to understand at least such rather
simple cases ?


--mtx

-- 
Enrico Weigelt, metux IT consult
Free software and Linux embedded engineering
info@metux.net -- +49-151-27565287
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
