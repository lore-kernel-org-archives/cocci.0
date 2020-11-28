Return-Path: <SRS0=SYYD=FC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99181C63777
	for <cocci@archiver.kernel.org>; Sat, 28 Nov 2020 20:10:18 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05DA5221FF
	for <cocci@archiver.kernel.org>; Sat, 28 Nov 2020 20:10:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jXDPLg4F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05DA5221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ASK9rZn024125;
	Sat, 28 Nov 2020 21:09:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id D7CDA5C34;
	Sat, 28 Nov 2020 21:09:53 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3DE8F454B
 for <cocci@systeme.lip6.fr>; Sat, 28 Nov 2020 19:56:14 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ASIuDwb005245
 for <cocci@systeme.lip6.fr>; Sat, 28 Nov 2020 19:56:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1606589772;
 bh=ZMVxVAVF77W1lVdiakquBzY+MjE6S7x/vVOC7lyvafQ=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=jXDPLg4FI7V1cApLDsji6CoGFd1qG1bONnMtzLFucK3xBS79xAAtEerzNKlSBq57S
 fUH9vqdkB1E+y6/lVo3DB7ka/5AlVIFjduL/Z2hSBmrij+XXIpot2sbKAE+30oyNMD
 kDyhdkV3XkuY+1V0WI5grX3xOMq21cX/bstDpl2g=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.189.227]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0M3jwL-1jsUjl2Hpp-00rK81; Sat, 28
 Nov 2020 19:56:12 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <13b38013-8d4f-55fa-3c0e-ead782031659@web.de>
 <alpine.DEB.2.22.394.2011281844070.2725@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <feb351dc-537f-0f83-d9ec-cf16796ac0ee@web.de>
Date: Sat, 28 Nov 2020 19:56:11 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2011281844070.2725@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:Am+hhDMNVyqcIlZg1P/9/TToJANv4yurdmQVPBxIOeUKzTW1O3n
 KxO1cLRHzjgYWbjKjlsEos1i9xiGbJHeqSvFw4shnN2tHJt1UBJl6/q3+SL4sdWHx4Stdpj
 WhQHyly5ECoR1FMrn2VSPhNpRlENLFr0RUULywtEnYth3Uo9LEc2A2By4xeOniF+51B7V8n
 lXHD+7PJzHKfz6QODJK9w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HsRz+RkGXKc=:8JuiksvkHzFxkXPeOFT+NJ
 MSEF900CiCgNjlWoBkZvNS+2x1Hdxya8rBCjJK5QRkztiMwB94bQ+0SnM9TqRg2SCt8F9GF04
 yw6bZPiWNZqIgPEuIZHVLqlWOVJrrjc1e2NSmntEAfE6dv/ATbPsLOMBQxvQxXQgcIqwlvcDk
 UfQqZS1BdQdgZFAiE/5sX6QBdeJkP3Drq7dFlbJ9qzR1FRbMWhEq0E3UXP4Q5OM9GfBKNHoBf
 IvfaPbuhh9nqiBUJWcEtCsnOmkzNKjUvm+VYEDvpg5x4oYs0iHgt/jlJVwM8eU1iYejEZbfZW
 S32zM8jnN/lbMMyk7+9XLB50g1LdaVEpA3Cs9ifdiFQ4KW/0dFMkU+IHnUB/scVbiLaQajqEH
 WJikRRzq4cpvsQks2rXgWZtNkr4t7DMF9PePbUHwyPDJww9lgm5/YQg4TACrT1CatRX4+8iaF
 t7/uGhC1GyxDRv5DvX2H253VdLnfJnmcrulLusGLQq1NihWun0ZvCr9bASGFwh7yaODPhcZmC
 kNlPQ6Ty5reYUEMEjyFfOM6XKztVsYKVLNs1cVMXVHoq+mystovtlU9nM9g0wj9jeToD4foGT
 wgnBQCHA4Etl9CRReS1bNubTeYEJgV3/kLQaEZDdDj0UIws/gs5LyMr5tmgkJYIgV1VViQDHi
 LwFVhyFH3Ougde31RTD+1mo8MjypApOgSi3iVZng1sAecjdJpguioisWgRPWYtV/T9at5CbM/
 mKn9ZnV9LaDfMApa6dsfMKwXweu/WE5lOvk3wkkSQOgRnPbAPyynQIBHm2DN+MUttzWs2wJ4S
 6meDrDMx/fqZlghJeBI9QJ6TcJgSvYOC2JH3okqs3JfHuNTRF1sbJZIGCXhKYpqP/zsYP0//n
 7NVnejcH7QSeVKQ+ItJg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 28 Nov 2020 21:09:53 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 28 Nov 2020 19:56:13 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 28 Nov 2020 21:09:52 +0100
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the influence of an omitted semicolon on a
 code adjustment
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

> Why do you want to remove the semicolon?

I have shown a transformation example where a function parameter should be replaced
by a previous function call.
Thus a semicolon should be intentionally be deleted.


> If you want to find the call somewhere in the next statement, you can say
>
> (
> S
> &
> call(
>   ...
>   )
> )
>
> where S is a statement metavariable.

This SmPL specification variant can be also interesting.

I got just interested in the possibility to omit an extra semicolon
in my simple change approach.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
