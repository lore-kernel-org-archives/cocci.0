Return-Path: <SRS0=ND+5=5W=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2802C2BA18
	for <cocci@archiver.kernel.org>; Mon,  6 Apr 2020 08:20:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A61820672
	for <cocci@archiver.kernel.org>; Mon,  6 Apr 2020 08:20:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="e1i75mQ9"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1A61820672
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0368KPQe020868;
	Mon, 6 Apr 2020 10:20:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 721CC77FC;
	Mon,  6 Apr 2020 10:20:25 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 778AD3CA2
 for <cocci@systeme.lip6.fr>; Mon,  6 Apr 2020 10:20:23 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0368KMa5015265
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Mon, 6 Apr 2020 10:20:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1586161220;
 bh=2ySBH0KpLyk4WqBlXGdSWAKjtqZahuGrVedG3KmpHt8=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=e1i75mQ9zIIZ4ld6RPfPHITi5uXQ0x2y9HRf+VZZfZE7/p4MHAVjWMCyIm1Lz+k4a
 m3zDSy+USw0QFdDxaO1ycBDf4TOiu9BC1RhfI+FN0uiRLnrnYjyESUnfs50mufPxb8
 FgAP2oYbN7lfrAnpjppBDQH4TkuuxEQVCPUvcZYw=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.3] ([2.243.176.200]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LgYOH-1j0aZt18hp-00nzTy; Mon, 06
 Apr 2020 10:20:20 +0200
To: Markus Armbruster <armbru@redhat.com>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <eeb90865-05a7-cdf3-fd27-cf190c2d53ca@web.de>
Date: Mon, 6 Apr 2020 10:20:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:PWTpcNF2FNY8UlTL9EboRYr0JPdn/FhLkhmE2veQHKNyTnbekUQ
 kmzyM7eylwlcdcU6+iswOE+PtWDToZZyAq3xRzLIKmKF0T18+8uUqOZrdB8SQv24dnAMI6b
 AT5PvsKLcqSiRzHSLj5NfiULl5GNAKqh9zMo/6MVP9QBkKp39qL3x0UlLBWoi0Wia85ZLIx
 o+1/dSj3FfD+7RUhLTyyQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2UCyJ5F2Jk0=:0fO9+aiOE9w9t2uI50hE9V
 SberBeS8uFyjO7FbIOvuNGFgrdowx9OEf55e6G5TH+OIazAWMS6ivnT2Sn73SYd4wPe2WtrMF
 S++75zZyX5GjqXfz6YsbuuA1XGBTxbuJoatpEZ752JlPl+bI4PbhlglwP61i9urGaPdLG7kA4
 1fMWzrjYoYQQCAAFD+iPZruKyuFMtx12rTJqm4J3r4Uswu+DuGGTX2cmClf7LxZVjp1ZX26B9
 oeLDpv2FMeYoZ2GTXkU2rXi5LDBD79OgJJtDTL131f+eN4qy/dr+t+3K6W4KrtqnB13HRNjCd
 NBeAE5kU3JE9R+x7pPvi1SPqnhIRpTMmdIJoFRYHr8DI8yfkjdYVk5cLKBtGqZXzzTqZIGXAD
 XYN+vndbjHEEHQWtiwr+GtaVqDSL+74BEOubjnppbN3fs00zHau4RMC+QqzpD3WKuPBbqhxYb
 ZPLU3eXK/9UYvvt8wke9mNNhLlsO2E2025Nbn3ySKuK64R1ZJOdyICoEzqQn4qJMprWuYeUNk
 5M0MyCgoxOMibo7kvAlsbKNAsZomC5V+0pMYeigmDCdRofhyRGkN76niKReVWfMkDBkQteo8+
 N0O1kWQRVwXNlYS2iIc8VILjZLeg6FkX9o2P8DL0tTLNXdM2AYWgA8hWAeDo9mmCo7L/smCjA
 PN/qcHideGEMZn2/e9JwqDXBpN6qMtwIwxa9Bgj31v6/8GSllivXAfO4VVm77kYnBQUbBkRCu
 Wvkfd32IUBHFJxMvfLDy7ibPQffhE08APXRaD59jjMwsZH54zT2rwGJ55RcA8xb43YmPBzhtg
 0O1WY+lZctcLDVU5XhAbSNfr3JiVBCHl3YpPLp+J5ellEc+pmr1FvGbSOYYxLH8o6KBaSvmZX
 Omyp5zN2RRWWExsug7Ty6uDqQ+pv0bjoYmd/bUf0jEJ75MMuN8Ky2RhWa0P4v3KLQCS0FYXlc
 +xQ8rmVanrD5uOWHvqaeFUJY81HEEFi6bJH1O9DMrb/eos3VFmryKzI6iPWtvjqwE3xEIYWum
 Izy2DVh47NQ6LbohS77tztBqtV09z/F7nSKi5eZHRb9hrKrrGrSN10o42hP40fG6I6vf96llP
 sBSjgdIWYf+Ro4UT54zwImZ7XjqaRPb3UvKqcFg+tNN7EqNpu6wRTwJ1sHSKd6BpYUIj2a3jD
 m3kndHTrcPt36Lr5QtCujkRcAHKlPhCT9q77qdcVJYwo5L0DxHvXTWwg1I7yWhpi1XZly8mbM
 Pq4kS9qXeUcVujW5h
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 06 Apr 2020 10:20:25 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 06 Apr 2020 10:20:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Function-like macro with the same name as a typedef
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

> * spatch seems to have trouble parsing
>
>     ARMSSE *s = ARMSSE(opaque);
>
>   where ARMSSE is a typedef, and ARMSSE() is a function-like macro.
>   Yes, I know that's in rather poor taste.

I am curious for the safe handling of related software development challenges.


> * Workaround #1: rename the typedef to ARMSSE_

Will adjustments become more interesting also around such name space issues?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
