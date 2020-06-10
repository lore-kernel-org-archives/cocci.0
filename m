Return-Path: <SRS0=+0BU=7X=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E868C433DF
	for <cocci@archiver.kernel.org>; Wed, 10 Jun 2020 15:25:08 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842BA20734
	for <cocci@archiver.kernel.org>; Wed, 10 Jun 2020 15:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="Yg0r283J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842BA20734
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05AFP5uG023946;
	Wed, 10 Jun 2020 17:25:05 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 10C947783;
	Wed, 10 Jun 2020 17:25:05 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 085803BAB
 for <cocci@systeme.lip6.fr>; Wed, 10 Jun 2020 17:25:03 +0200 (CEST)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05AFP1wv005844
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Wed, 10 Jun 2020 17:25:01 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1591802699;
 bh=THgvBtwQZpZGJTEsN5D4mz5PgNSh/34BNlBrwjUd+kk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=Yg0r283JUL1SeNZFP3HswQXglzQgrPrzAs3CUr/dnQ6nyrlSpCVezJ5Eh/YAKm4Dd
 CnD+cPAPSAEXvD1CvSBXDe/0246eSMN6NL4TKumTgmhvMVhAf9r4ltIsKjyygtuNy9
 kQ4MMyZyzuMk+OJ1/SMTqxI8CpcfrBbxtCH8zrko=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.155.16]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LkPrz-1jCieG1zdj-00cNG7; Wed, 10
 Jun 2020 17:24:59 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <88d56de0-0a22-3371-ebd9-0ccbbc81f76e@web.de>
 <alpine.DEB.2.21.2006091952570.2516@hadrien>
 <5156fabe-d9c0-def9-cd8c-d85b8b5c704f@web.de>
 <alpine.DEB.2.21.2006101653030.2235@hadrien>
 <4befcdd7-5c9c-ebfe-7c2b-f493c8c2cbc8@web.de>
 <alpine.DEB.2.21.2006101708580.2235@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7cfacf39-224e-693e-1b7e-06914f8d0e26@web.de>
Date: Wed, 10 Jun 2020 17:24:58 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2006101708580.2235@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:IHllV0HQ7yTnL3OmIECDpt/6fp7VFap6vQzcm/zEzME3V6nt000
 v/LNSPo2fbr0qT8xWKpk1ZgUTomSYAC40jyfyEzRB1mWSEiltXFWmuPhHg83OmVt9VgLeEo
 7u9L1HAvJiC1ysQct8ReofIvJfhbld5vXVRyyZvSpsfwocfR53m7xWBf53DduSGi5lx8aEQ
 V2N6N8PPy7xTb+lgiSuvw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:J4bWUK9iFeI=:tHXRRCEf20BOUMrGmnys1r
 Bxd/E0qzVFn7nNZHL8tuvYjmmEtPqy7ttGs8oy70iHiqv2oB2K6VeZX50660n1TnYYVcIps0O
 vcKxbbKovBj95dp8ip1JAjQcx8O4nfPKt8/6PNbpqVlwmNmER5fOsiAlvxGFAOusgKKaBd56s
 O7CGHsARWjrwCr3qMFgQK4Vmp3LvNKQ077jRd3QDVSX8/RB6lBR5XKg9HeqlyE3PmjxmK5TeJ
 cH2UrthOtaHv4qP/iotuTENSZJ18cbDNEMsQma6wzOp0q6AmT51ER7Bpd0855+3K6RZZyziC9
 JSnfC3x58OpbOza9vd4vZOV5fhqmwKwZE7j+h1HQ5p6VUoBKStJ5czFgPe2EO/eHcjHdY9i/W
 Lq+9eTXXC8mXpkYDt3gTau006Li06p9pjesoGLBwzx9sCj2M3aulqJ2tcHD15wXa9dP7fRDUO
 G39NXUqSJ+Rh07gGgqLodKBOy7tPq7xM5io5xoViYj4m4/4Ayr9njFYwahU3uIDYDoWgfCJ56
 ozM6pT+6VfZecpPW6uZFpaNuVYw0dVW65UiABCC1SfKQmY3tlBjvZtor7BOOYc32BbQfK2LTM
 ifFgHf+RBgFXe/QqmU/Qx2pE9KIhz3xAgLyVEX6Vi5p5gNDsA5v7NyyBAiOgDkUoIRKr3YmnH
 w650f27Q0hBA3eWsDUw2pqSvpBN08QBVnaO+63SHrU6kh6n7+x0W3DKv4RoaIBkoUKKtxVzJm
 zJshbOxSjcK8Dnm7YiDGk0ioVlMeivwPBj16734bE++hdQMJn3SY+4cRC2hvfHYouXcIGbiLm
 3EhxBTpYKVCEPBoGBbSjWhkvNaNlPSIJP72MX6/A5EjB2TtMztkrvwjH5buQy76g2Rq9R/NHm
 VGOgGWtYhDna2UEg2nL5UuHsV0/K+YybSs6joFw3WFfYGWFCA1fj66JcHqJsAe+kZ51HUwDPO
 dp3+NzNI4F+o/9rdeDB4zUsiy854Uxaq6feaAoeQBW2SF6I/rmebsgdvCi3dk8UkS2tiMQUlF
 EG86ovpY+3FEJPnIFVdwTd4U5Ou5UzXTTtfhgubLFjX59WbiVn1a7HDZSuSLQQ5PhtLpKcrlf
 5xfUhtsthsonLW8kE/K1qSxDqPaGCyCLpY0Eimaq/djo9pU5BXlrl5Uy5DVKDPLWXBLcp+J9C
 462kUh/gUZ0ogLoo+I1Twlrz+W8fgZAE7INqgdDEEFIpqAvVw3lpBHgTTgEPcKwql5HrQjgXU
 c0VQqBnc4UGjYGOCv
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 10 Jun 2020 17:25:05 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 10 Jun 2020 17:25:01 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking software behaviour according to selected SmPL
 code variants
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

>> I hoped that my specification of a SmPL code exclusion should prevent
>> the presentation of assignments (independent from statements and/or expressions).
>
> (
> e = e1
> |
> *e
> )

@display@
expression e;
@@
*brelse(e);
 <+... when != e = ...
(e = ...
|
*e
)...+>


I would find it nicer if I do not need to repeat a code exclusion specification
as the first element of a SmPL disjunction for this special use case.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
