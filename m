Return-Path: <SRS0=mNwD=XV=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6A84C432C2
	for <cocci@archiver.kernel.org>; Thu, 26 Sep 2019 07:09:41 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0828921A4A
	for <cocci@archiver.kernel.org>; Thu, 26 Sep 2019 07:09:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="jD/T5xqf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0828921A4A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8Q79Sh4025426;
	Thu, 26 Sep 2019 09:09:28 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 61D6677A2;
	Thu, 26 Sep 2019 09:09:28 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 756C277A1
 for <cocci@systeme.lip6.fr>; Thu, 26 Sep 2019 09:09:27 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8Q79RJZ002713
 for <cocci@systeme.lip6.fr>; Thu, 26 Sep 2019 09:09:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569481766;
 bh=xfKUcXkDOKxSBzLI4FQiaRLqjs6pWpBcspK57vtQlqc=;
 h=X-UI-Sender-Class:To:References:Subject:From:Date:In-Reply-To;
 b=jD/T5xqfKIXUqN1KdKyuMByiMLm4Jq5LIpNkABISiQMWlMkqmyW+0k7v5BoHctWYe
 hPWFE+0EyCTT1O4YTkPEtReu649DlyorBTOfB12SBsfhp6RBxhECK1MgGMkJD9tGTi
 +AgV8lOVxiAULtZvHodxWjKG6c4Q/b3sPagHFCW0=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.81.241]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MK233-1iCYYV2rTx-001Pqz for
 <cocci@systeme.lip6.fr>; Thu, 26 Sep 2019 09:09:26 +0200
To: cocci@systeme.lip6.fr
References: <alpine.DEB.2.21.1909260502560.2599@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <7d7e4199-b546-dd31-6a34-f76d2e3c2aff@web.de>
Date: Thu, 26 Sep 2019 09:09:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909260502560.2599@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:akgb3HjpSt3rIlCA4Idf3O08bUqmmS/UhHUCel/bDNet+M51Xpg
 U7jbPQd2a+/MY8dLwq25H5MKAFeiqfhNVO2lxxQGGueFf+yjyssXCf61KgIChbck5sy1bU4
 vPMgo7wj+BRfmAQgemMZ55jw7qynryisDprRiWCcMbd2JId6FrjfsUJt9ez9rTUtTqo6zy/
 bl4MIl5+2eChgvK3CuoDg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d5NJVHFobRg=:2ARS0irqIsV8NLBBFat/lz
 SNksyDHaDr77qPnBF2fr8DhCFL+ZlB/oAWmLPBv472dygwJ5TSmo6I/1C2MPjoiHgUgtqGDXz
 fT5xABp/bylpclBrCJeW2wGTMuuGW7cVjmB7poUF0FHxB6MccYmdJcSrM828kJMWdfJ9ueQhi
 X1IHb4aS0Aa2JKS1HwR4Wse7WyXUvEu4gF6fOjXXU/B8O/uPJ/hN9ghx3p0P7hXRAouF6YiuP
 537lD5ea77Xbxf4BldoIRlDvcG2qPBaz8aPNOrGgjek4PsEpNi8PNUU6YMazJy5gMz8hgPUun
 g4j1jjAuSje31xLZITcKNatLXxaRptqxTb1R75tfAfzA534C3UkMjuO2bDzGU09e9+ZU+C+Ku
 7EOEzV8cvEdpMYuqkJXvDAg0/A9yAqoGokGDzgvuXT73tcSkbDgZ+G4s9PyPHy9bl0JhizObx
 OxX36s2vyj5X4OIH7sG1nroATFxksZCUAtjGAefMSqK3mp01Kp4QF7gyzhlyEjMlSizaYfRnw
 Aloj1fX85QDinQHN0b2cxT1maTqIDPBrVA9mRbXrUbrL0HDXjMfPf6AHbtmAjfC/evcnlWpOs
 S7Vsy4WCM4mOqP//XKrURO16G1GuuV52abXSyEx2Hu7pEFGEjo1lwIBPqFZT/d2GJvmV2KGdo
 kg1DqOWS7jLEDqi14YduPTCHP5JmG54lTkHIfpfpeUxaUA0k8PL1TVirqy4BH/SEjx5y0SgnN
 1cRdWVd1gjQGEnpF/nfop8cKCweK7j/L41+v9uUrc6AvbqXBCr9cg2eAc0IuF4YhhWEig6QMc
 vdvGalaEPw8pWPTQMyh6uf3sjKaNGcHPpxkBDuH7+vOmH4dHxT7fhhGGH68tDc0G+GQxEWLtN
 pbPIogk1j+ECaaDIA4Fk914TIhhMcAUE85rIshpIAToQrvOKE5kWqK/AEU4rMTDL6gcOsqhyF
 l379TV9tJLNTYeVahAUugJVEQwUYir+hhUtEIF9QFTrCSpOVHM614LBUPYQAXhCC8dbVTGwl4
 Jwh9rJmQ2SzsKzsbLSnguEzn17qu9rq/uaj9Y7cmew5NU/c9xYNFohyqRUSiU3vhiSuN91f7a
 k9Q/x0rSswsGF2zFkQwoPBNXVnh0PP1YnZCsbZuh/hzhhEJp1UFPQeNtMx9DQ5gh0dzML+wH9
 ONn+ivmOuMjuk2Kmw3bu79l1nP65TBcMOBF8zweN9SolhmgosoDXbpnVaMax6/Evyzsqc2pPb
 +hpYrkNR1kE/qAvHmLyMaj72kgbDOzDeX6siqIx5FYM46zPrzQlV+7/gYwAk=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Thu, 26 Sep 2019 09:09:28 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Thu, 26 Sep 2019 09:09:27 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: Re: [Cocci] Progress around Coccinelle 1.0.8
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

PiBJIHdpbGwgdXBkYXRlIHRoZSB3ZWIgcGFnZSB3aXRoaW4gdGhlIG5leHQgd2Vlay4KCkNhbiBz
dWNoIHNvZnR3YXJlIHJlbGVhc2UgY29uc2VxdWVuY2VzIGJlIHN5bmNocm9uaXNlZD8KCgo+IFZl
cnNpb24gMS4wLjggaGFzIGJlZW4gdGVzdGVkIHVwIHRocm91Z2ggT0NhbWwgNC4wOCwgaWUgd2l0
aG91dCBvY2FtbHA0LgoKV291bGQgeW91IGxpa2UgdG8gYWRkIGFueSBpbmZvcm1hdGlvbiB0byBh
IHRvcGljIGxpa2Ug4oCcTWlncmF0ZSBvZmYgY2FtbHA04oCdPwpodHRwczovL2dpdGh1Yi5jb20v
Y29jY2luZWxsZS9jb2NjaW5lbGxlL2lzc3Vlcy8xNzAKClJlZ2FyZHMsCk1hcmt1cwpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWlsaW5nIGxp
c3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21haWxtYW4v
bGlzdGluZm8vY29jY2kK
