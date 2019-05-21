Return-Path: <SRS0=7mCU=TV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6310C04AAF
	for <cocci@archiver.kernel.org>; Tue, 21 May 2019 05:54:44 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 168D120856
	for <cocci@archiver.kernel.org>; Tue, 21 May 2019 05:54:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="TmFD8X6D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 168D120856
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4L5sURX000080;
	Tue, 21 May 2019 07:54:30 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7DBDC7747;
	Tue, 21 May 2019 07:54:30 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DEC177741
 for <cocci@systeme.lip6.fr>; Tue, 21 May 2019 07:54:28 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x4L5sRvx013403
 for <cocci@systeme.lip6.fr>; Tue, 21 May 2019 07:54:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1558418066;
 bh=mZJEo5RINmZFFULqu+pu9HVWECJKSQ4EHIxrrgv+PMg=;
 h=X-UI-Sender-Class:Subject:From:To:References:Date:In-Reply-To;
 b=TmFD8X6DdqEKOAqjkx1rHgzyhVXtLp0KeGEo/jogMgMy/vZ3XLzX/0UuXjCXxEufW
 yf2MaNqjA4MqInDkEc+J6um9AZTXgfH4Rlo2DCQ/uIsoNwkiNtPLqVwVosaDkyRj5i
 t7wQ9LwVHJH1fCTlkBzba2hVZ/oxEp+vYEB4LJ4Q=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([93.135.93.135]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MhUbO-1hFGMK35ow-00Mfve for
 <cocci@systeme.lip6.fr>; Tue, 21 May 2019 07:54:26 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Coccinelle <cocci@systeme.lip6.fr>
References: <a639ce38-81a1-8825-73b0-2b7ba53e6588@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <78de5a84-1651-c5eb-4fbd-35362c93abef@web.de>
Date: Tue, 21 May 2019 07:54:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a639ce38-81a1-8825-73b0-2b7ba53e6588@web.de>
Content-Language: en-US
X-Provags-ID: V03:K1:P7rV7th44BsyNa1I1/omRl5SaEPyZUtSJy7Cn1D4cXHOOVZSHnQ
 yt/72QfFVNote9W4bR8rRdAzFJSylcxaVekif0ddNLgQxsU6GJeaNpusYBkHpZQ+ilWlJya
 LPtQ83zGAg3tuqy2yOE0sHQw4vbuWa35O9Opfu88c8VHVmqB2PuCtdzLvMj6GlIJ0LnG66q
 sDATIhwOpsoyrRqay8TRA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:nZoyQYHEcJc=:5XiVivvJ/qUCsE7eP5wDdY
 rjCd6YDB04FRvHbz4kQK4/8H01kA6W0+EKZAiZ/gb9BzEL1BjdVAeoSBdant6q3aV7Y6rN3D6
 RXYqb4Vf+waiV8PerJzpguA6KkMNA5YKthule4qsqia2gmamCY8g7esHcDH9blq/AoIcBgx03
 PkTbJ+GtPy0LBAhbttiv051v5cvTqBtABHzIbmH8fafJ5AmKfiNVmbkrtPTCZzFEAKdJ3jlQO
 MEvT/8719/vR/GZf+EMRvzoC1i1V5zTqGvvlVI7skzccY4G3mUAf0iVNX0J33IGlmXcmVsIUx
 sjK5P6te4k0dKZVnrx8kTruydc6ABrEItzK/Zf8X7Af9vsvVtjgqDG2FM3/pvuQ+ihBNnS+QE
 a5navMuNp2JipQ1WoL2WQ5OajoWkLVjKMbUa/pbuPa4AuBP+siDE6GsGsE3YAjPR/ihF6/roH
 4J3v5MvTOnvCuADNfuXd2hl7u5jLCevpH/zZHWJO9UDal2EP2II9y1dm1uj/jKZ+7awLskROc
 d3EfJarJEE3teYPl67oMzSsQ91Zvw+Pkklmqfv/nErg5+QH4gpyQZqlM3hXs3gdQw15NpHFs1
 h2BWj6oJILwqPQrPjMr9Fjdn0J4LmMApIn/DKK2SnTwasu7gKwGSLNx1wkL72JMNOkxxeb51N
 DRK2eGFavKrjlEAXlIvstghQHznGXnMwgR1toNe/Ig4jQarO+Z+dNWvEh4VhiQzdy1EFZ9pkm
 u4PZjglQa1oyBlzI53ZkY7tdq19jIQqNSS4ItWZ0fwrTjeEX21SIJcnPX0JD5x+ZCBNm65TfQ
 SVvcZPuUncOmpynXch0ol41xY+VldRjF6ftcGYzNUHsBETQhmcoyxVmCYjmrf2cVw7srL0XA6
 bSygNsUvNT7qWGsrCFMx/8DYg9Wv/dAA6iD7lnADcq8vtP6LUEvMfe6HdY7u5lHy8q2pU28Jo
 ERIMZ5pyMVSW7ruiUMnYmHuoI4+FyYT5FF05aD2tqBfyKj4iS46cc
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 21 May 2019 07:54:31 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 21 May 2019 07:54:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] Continuation for a code search after a common SmPL rule?
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

Message repetition from 2019-05-16 because of a temporary technical difficulty
with the mailing list services:

=====

Hello,

The semantic patch language can handle several rules which can contain
remarkable amounts of source code search specifications.
It can happen then that a few of these SmPL rules contain a bit of
common specifications.

Example:
@one@
@@
code_area_1
code_area_2

@two@
@@
code_area_1
code_area_3


Now I would like to clarify possibilities again to reduce unwanted
code duplication at such places.
The common code part can be moved to another SmPL rule.

@start@
@@
code_area_1


Subsequent SmPL rules can refer to metavariables from previous rules.
But how can be achieved that the code search will be continued at a place
after the position where a previous rule ended its search
(without extra code repetition)?

Can the splitting and recombination of such rules become more convenient
with extensions for the Coccinelle software?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
