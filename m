Return-Path: <SRS0=wAiH=DY=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78993C433E7
	for <cocci@archiver.kernel.org>; Sat, 17 Oct 2020 16:46:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A31592074A
	for <cocci@archiver.kernel.org>; Sat, 17 Oct 2020 16:46:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="WN3IiTuP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A31592074A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09HGkKbp024166;
	Sat, 17 Oct 2020 18:46:20 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EFE5A778E;
	Sat, 17 Oct 2020 18:46:19 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 1B60A578C
 for <cocci@systeme.lip6.fr>; Fri, 16 Oct 2020 12:56:30 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 09GAuTlT021149;
 Fri, 16 Oct 2020 12:56:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1602845785;
 bh=U79/9SNqArg5DdaEoWXg6/5EyJMBfpR5WvTe1+Lq3I0=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=WN3IiTuPK0JkhvNjZEeKr9dYacfakOm7wFVgRintS0S8CHJj3UpSYlLUpFAjtFHuE
 nkKGumEnDeukgQuQYL9xIEv8fk7GdvoUqREVziOmQsH2lKbaSrw+EGN1y2iIoHFRI3
 MNXoHFnhwx1KnvdVa3vdnhYqSYP1/Cbuu8x04dFY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from sonne.localnet ([78.48.118.65]) by smtp.web.de (mrweb006
 [213.165.67.108]) with ESMTPSA (Nemesis) id 1MHVaf-1kgFa42KC9-00DaSv; Fri, 16
 Oct 2020 12:56:25 +0200
From: Markus Elfring <Markus.Elfring@web.de>
To: Julia Lawall <julia.lawall@inria.fr>, Denis Efremov <efremov@linux.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Date: Fri, 16 Oct 2020 12:56:18 +0200
Message-ID: <4952443.lvVLTPejtF@sonne>
In-Reply-To: <alpine.DEB.2.22.394.2010161202360.41305@hadrien>
References: <3528117.7ODa3CK5J5@sonne>
 <alpine.DEB.2.22.394.2010161202360.41305@hadrien>
MIME-Version: 1.0
X-Provags-ID: V03:K1:jUg7NzB2viPZdv9lfAY/N6Ryx244Tfki2pUxn+J4NRXyp0x2Kss
 x/z96eUxmhgkTiOkxfALuoz7oXnhc9gTACgySR95p8PPoaZ9wN2fkl5juOtMj7UzjPm1FBe
 wL+fOjnyWIjtMemjgUSheJywVYFwfQA65VIt62mNCm8NMJi61HZJT+legY+re+X1nvzBT9n
 5y4pCttf1/EAr45cGoZig==
X-UI-Out-Filterresults: notjunk:1;V03:K0:gCyEsqRkdBg=:1/1hKKxw6J5LxjYsclIEEz
 PDDd17krLKJtOR39B/sV3F4vbxM4VyKoPcUcZHsuIM4tImNTj6AfYgGifytbW8UDdW3FQpNpm
 fK1vzu9/xUNgQWKGvgkA8o4V5q5voM12GUzuOZMd+TGpFgJR38TPiFOolw2Y+QE2z0J7vaGW8
 djYtkmI7wTtvmdmKTp58SibC+1EY8qapLrYU6hWRylmaSCy3KMjhf1y3HIiWvxDGwSvashzdZ
 mIUfMp4Pro+8efKsi4HPGGK0g8DEOgyruLmaWotllgQ5/tQEJFxP8XjOIRcHb+T6KaKNWZWfJ
 O1QMlwsItdftSMPZUwRjmesott0/K9eFGdFs2pbhz0YoRCXn1FOBMyB39o6NSWCHzEtz9mNdn
 xz1Q2Welz+JeTBDcY3EEe8mLxgsHZe2iNgkmFrEi1OaEgVE7lywDg79TGC1eXL+AEuid99ofg
 kXWyvv2AmuBeC/b+IqLXe9tySsOjY3BaK/MlGgT739PvBj/Kg5SBlb5qOw2vRbk4+aEpuBgCE
 ryep37HpZ8wYzVVQKR3E0TJMiYiDIC6curRKGISi2PG4gvnHUQ21d8DKm/wy9+MvHYgOeG06L
 A2COGyMzYl5TsEVEayWTMCzhwgvMXEvuaWRUrHvYu+v7yHTVeyj/O8qKuD+nXr2TtBasvFtbX
 xNTKJrxAhqlZHhAWl/9b1hP/y0kVdrRA0ejHJU7CCC3xPgQY48S9nolrBbsADmfW4wf3G+Kzc
 +ToVEP63eOEohTU9hLVXc+H2XBV2QAKO3jc+02Y8nu+a+CtDXnN+5yZHcoQ25We6ejznxdN8r
 UswG6jPKLdOmt/vH9sk3LfFV1ZsNoe835Be/JAM0oJ+awCkI70cSR+yidtQEuCi8Q0AF4HU6Z
 zvLyEIrf0QC0kZ5tBeeg==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 17 Oct 2020 18:46:20 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 16 Oct 2020 12:56:29 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 17 Oct 2020 18:46:18 +0200
Cc: Michal Marek <michal.lkml@markovi.net>,
        Gilles Muller <Gilles.Muller@lip6.fr>,
        Nicolas Palix <nicolas.palix@imag.fr>, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Popov <alex.popov@linux.com>
Subject: Re: [Cocci] [PATCH v8] coccinelle: api: add kfree_mismatch script
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

> > How do you think about the possibility for any adjustments according to the order
> > of the mentioned function names in proposed disjunctions for the semantic patch language?
>
> Please think about this for 5 seconds.  Maybe there are 2000 calls to
> these allocation functions, and maybe there are a million function calls
> in the files that contain these calls.

Would you become interested to check the usage statistics in more detail?


> Microscopically optimizing the treatment of 2000 calls is not going to do anything
> to help the overall runtime, which depends on matching all
> of the above function names against the one million overall calls.

I got an other software understanding for the evaluation characteristics
of discussed SmPL scripts.


> > Can any additional identifiers become relevant?
>
> If you have other names to suggest, please do.  If you don't have other
> names to suggest, then please stop asking such rhetorical questions.

I suggest to look at further possibilities so that more function call combinations
can be checked automatically.
How do you think about approaches to determine relevant properties
in systematic ways (besides listing involved identifiers explicitly)?

Regards,
Markus


_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
