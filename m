Return-Path: <SRS0=SYYD=FC=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F6C3C63777
	for <cocci@archiver.kernel.org>; Sat, 28 Nov 2020 20:10:09 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 784B1221FF
	for <cocci@archiver.kernel.org>; Sat, 28 Nov 2020 20:10:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="KC22wuoK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 784B1221FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ASK9fee004463;
	Sat, 28 Nov 2020 21:09:41 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7A5125C34;
	Sat, 28 Nov 2020 21:09:41 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id D3F80454B
 for <cocci@systeme.lip6.fr>; Sat, 28 Nov 2020 20:11:39 +0100 (CET)
Received: from mout.web.de (mout.web.de [217.72.192.78])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0ASJBcYL021892
 for <cocci@systeme.lip6.fr>; Sat, 28 Nov 2020 20:11:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1606590697;
 bh=6FhEJiYKAsES0LrkCTIcbgAB6XwFjm5IO3aGO6kajso=;
 h=X-UI-Sender-Class:To:Cc:References:From:Subject:Date:In-Reply-To;
 b=KC22wuoKIMth/W5k7g6qkDWdEVzFVDzqHuhx/McrYbJlgOlj22dJ/nulei03ETgGI
 kUs9X0SjMSmv/4vZNAZ6JEaM/uKdwMG7QFlDLADrOvOhjGuPfgGFzXQ02fMhewP+cn
 J4dnxN7oi85G3CRSZxTs9h+bd7XM+ewGBWrh0y8U=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.132.189.227]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MFL6u-1kxNN726g0-00EN3h; Sat, 28
 Nov 2020 20:11:37 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <13b38013-8d4f-55fa-3c0e-ead782031659@web.de>
 <alpine.DEB.2.22.394.2011281844070.2725@hadrien>
 <feb351dc-537f-0f83-d9ec-cf16796ac0ee@web.de>
 <alpine.DEB.2.22.394.2011281959330.2725@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <d78a46b3-7035-8300-6e8c-b9e823574ad9@web.de>
Date: Sat, 28 Nov 2020 20:11:26 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.3
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2011281959330.2725@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:fNZmoI73iBf0UEpziWMKuONdcFE4RkX8SJvD/g/m7k6fk03ZwLn
 6aGVMtmhtlnaz25AAP2+2lfs61A4uR46zab4mJTFfmrd2qzRiKQaFIr1qb6lmrqKSM1DSjH
 dmnXa+hor9/AT7+nZQjTjgnKileSu+2r8HrCi+5NHEG7Uq/bZYfPTIJB1boDlnxfPmwFnCk
 6bkDb33WGSOezJ+Fwo1Rg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XZw+R+SxD68=:63tEYMv8jrRoX5OEPCGRDh
 R8gXkpchU3Rov2SyYIYS+LEUnS2cnUvVTq71UVfpJnO+rGIxK5SPKN4SLweWx/kCUejuM+uo5
 +sWdGmF+EjwPeThFSm6EEoNLpHWZ5om9mzqwXHCrUyuQpoT8497gssND1vZ/5CoF7KH75AENx
 tTDPfmYodDtmCr1O67y3gdON4WIhSA1saxABa+KT0MhoEi3re9MvtFSUr5gOiLSksJFQNXVBQ
 +ZyVii6qC4giSW3H2twHteTQiagwmKBcyc1RVR0kzD5hPAR9EM0AKbAu2noJntfxL5NyLK7YX
 S/ffJ9rcP+ad+pfUMcPPahHaWyJ4qIbscV0ck15lWywvjsWkK/dL0ri7rz9QTxym2NEytYu8S
 5EKXYijbCB93D3sAx9Fd8Ss3vX+DCYH6KfZf7Wr5WF2T6zm8DqrD/cgMWfXhxNXUDg+vNTLRU
 jYmaXiGIQej+K++MSZEDg8IFD7YGLvCuAw2DnAOaJvDGKFXIm+uiVnjFi8CIvhMBfR66rE7EX
 uh7/3ZTGPcrawL8nfzxbaBBhoFglgYBwq9iL/XqweMpMLIMCZiNC3pbfgGFV3qZgRoGkfyFf+
 +HcKqHeediP6wUadn6up83Qtrm6/6DjnhfEuJBVwxW1QGjdIMSNEkeU1jfPD8YI3/Utp7hpfH
 snh9BpQWrNEgkytNI/lN+0VQra2YI7l1TVf65Luw7m39ULpPkO3+jHGjqll4mqNdY3bEAyHgu
 568ddIbrDR9qIPVS+9eqY0jOsJ48cN/iGVX28EpndJj7egCSAPOWTuGHs2Uo4BZGOmQYy+rPa
 i5f5yJFcZjNyiVBmQ9vyV7rK50G303K6l7wyV88I21aTHSx0hQ8ZVw1T/z+FloaOtfXpZC8d0
 j5dejIBNOf4ysDWVEceA==
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sat, 28 Nov 2020 21:09:41 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sat, 28 Nov 2020 20:11:38 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sat, 28 Nov 2020 21:09:40 +0100
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

>> I have shown a transformation example where a function parameter should be replaced
>> by a previous function call.
>> Thus a semicolon should be intentionally be deleted.
>
> That makes no sense.

This transformation part is working as expected (under constraints) already.


> You can't have an expression directly following a statement.
> Only statements follow other statements.

This information is reasonable.

Does the Coccinelle software insist on the specification of another semicolon
in the SmPL script for the identification of an adjustable statement?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
