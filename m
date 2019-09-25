Return-Path: <SRS0=ojky=XU=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EBF6C432C1
	for <cocci@archiver.kernel.org>; Wed, 25 Sep 2019 06:14:02 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 73FD1217F4
	for <cocci@archiver.kernel.org>; Wed, 25 Sep 2019 06:14:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="SEcRjzmr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 73FD1217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8P6DkVY002407;
	Wed, 25 Sep 2019 08:13:46 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 58BB0779A;
	Wed, 25 Sep 2019 08:13:46 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 9A00776D9
 for <cocci@systeme.lip6.fr>; Wed, 25 Sep 2019 08:13:44 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8P6DiGg028328;
 Wed, 25 Sep 2019 08:13:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569392023;
 bh=qDsfLBB0/mD3LQUs+tmQlTJvgG7z/h0GhhBcRogM8hc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=SEcRjzmrYKqP0J5AY3tvMbLml97kVMx0KuFi4UTw6f2NMTXcJRXN9TJipj9VAIHRT
 bwZTqKmx4NCKuqHY7p4yBUqG1wBLHFM8x+4gYMSC9JdtWbMEFvQHecSJVN+4ZYEsrc
 w+BqHCR1q32CqvLTJoj3krD3mgNpluZQ8fLtNftM=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([2.244.110.103]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LdF0f-1hmVNO3BhZ-00iTSc; Wed, 25
 Sep 2019 08:13:43 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <c4437d9b-8795-fdfa-7914-fc30ead14cf7@web.de>
 <alpine.DEB.2.21.1909241729310.2282@hadrien>
 <f41b8e72-9a79-e65a-a652-8a257d5fac71@web.de>
 <alpine.DEB.2.21.1909242215440.2589@hadrien>
 <b22031b2-2382-e629-a11a-09be7fc8e9c3@web.de>
 <alpine.DEB.2.21.1909242249150.2589@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <425463ce-d244-c86b-8a05-19b6511f25ba@web.de>
Date: Wed, 25 Sep 2019 08:13:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909242249150.2589@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:mhNA9cFH2GOHflGFj1DALwek9Q93hdH9hxQKrBu6/Y3TrYf2wCH
 0jU8EiFaA4xZ8txgPjp2UD9rt0xab4ba3MTFceVnkbQMdSDr7mim0c3kFV2sXWJ+fFZuWk+
 IzZQvbaTDoQzKuoH9FVrTQq0GK+kEA/FnBjSFT+jBdB3d+Ecz/c7lCqF1QB2rbru/lbFpmO
 RQPY70bpxN36XrUZfIIzQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:YLLqbx1lNIw=:Pf6RVsj15rE7P6KDw5v0FR
 OeTVIDDdPY/LHLbWjw6fsN/32UaJE2uGxzySWOqhTS7ynuRNXLHsB5Lqe2SuWgM+JHk8po+mL
 nVMKi337cvQMnLNvby8PNp7qLCIa+Nuf8otKZbFL+JalPmN8uuGyDzS3Jo+WelswaI5b19q51
 2LqlNjy8tnVi2yh6eFQfaa0O+wwI94mnZppSJjoI0cpR3FEYgI/TWayK6+fVY48+/kNWT8p0d
 uPjQ9bPo5GvVZnVbwTphIgh+wf8L9gCmxw1FdUAGid/TMe6V4EFHrutDvV5/ekq2QiQsprPpw
 2kBGnasV0zcTc2Y6uJw/wayyeznx72mXwOZj9uieox7Q3NLkNZns6S64Dh9S5Aa5Ul8ZLPSRW
 d/SeLhszJ0wLBl8Awjs7xwFicURmRrdvLK5ebmzaYDNDEpXzXA8LMuQimnRdj66gtjTk5xwe1
 3dCbK7bBpEDb4e/ZQ6EPtVWqAfFLtJREkw4UoncKan9taanZz4Sm1y8t2Fdz/KSuJI3hjwsIF
 i8vnqGDh97hbI6rnzmHKgC5HsodTfRbdYtuZFcnPxeMi8NpNT14jOTWftZ8NsNfUwS+sCO78c
 EQHbaeMWhdBptmQaptmWNP3ZllTUtSiV7Mq0EQW3eUygamp9uadnYMEo2/W1Qu7ydTtwEZqxH
 ZmnsCenx8smzIrsyNh+uB8Apm6dB4jELohnGb3m9Y3dRfK9LI2bTaz/S0nrV113bcF3qxZ2m6
 S9UccAwizBGwGXnpcvzJrjqW6WfE3jUBrhzXlkxhFlOvOdG/oMV+pHF5erpKEH1stonktTKJO
 5+erAJtjsJI79UH3NaujIVvzZLRqC/qjN6VtliDFOVSlbGg2Glw7pvdncLsLPJI/PL7xh/9Rz
 k1QSE1v9rF/nxRTk0F1UecNTjK2t/ea1Fyl6TFaKacoJbZgp9nTeev92/vUBQGxyHxRlDiUZP
 gNn5ab2UvZp54snF755jNaWeeAOkhTSMscQ+aFQbPnur7i4+PGDclDVEwq/elcEPY5gP1+w0D
 BtOCa8WgLH73tKuavY6FPPcCeGMwwg8zMUeKKUPs0BSXVYFDC+aTdSRjGkp9HEYvDijEn3XfG
 bTRuk0O2sICqj+rr7Lc+1nxUkNqP1u7YoAXsiD3DeyNA1ohyD1UjsIg4ESCkVIUgT6QWdRzPv
 Oi6ba5bB8v+yM613fZ19z3/lzvmche6Y12Ao3W45bZTLg99xvBPkRxmFCAvCXhwVqcaKTAzAQ
 QzyKn2UnCrWXAVh7zrSXFn0xUggF3P8NAnpfIBLDLb2Kd2lFdmxeNF+4Bk9U=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 25 Sep 2019 08:13:46 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 25 Sep 2019 08:13:44 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Reducing source code around return statements with SmPL?
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

> What is causing the previous uses to be removed?

Now I am looking for related software development possibilities for
such a source code adjustment.
Such changes trigger the output of diff hunks by default.
Can the display be temporarily switched off for specific data processing steps?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
