Return-Path: <SRS0=6oUL=AH=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7B0C433E0
	for <cocci@archiver.kernel.org>; Fri, 26 Jun 2020 18:34:23 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90113207D8
	for <cocci@archiver.kernel.org>; Fri, 26 Jun 2020 18:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="huOT8KqK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90113207D8
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05QIY2N1009636;
	Fri, 26 Jun 2020 20:34:02 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 7BB457773;
	Fri, 26 Jun 2020 20:34:02 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C56B13D0F
 for <cocci@systeme.lip6.fr>; Fri, 26 Jun 2020 20:30:38 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05QIUckK010150
 (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 26 Jun 2020 20:30:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1593196237;
 bh=IsVDSs89/LEn2EFQO+3BPYjNXfpKBcK8UBUMT8p4Tsc=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=huOT8KqK+Cd/xtNongFqfna0t/PV/EX2/4Eq2Srmi3M6F/gfW20NmQ0HI7mnG9Mta
 qWFGSKWDefZM/KZe4lJzeAL5FmcEGy+RirNKSSb3qxC1ogsdEzVyksvKy6xKgSoqFl
 pv/11JZc0+kacLfcDakSSJUIoLSYF1kF12fo9V/s=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.143]) by smtp.web.de (mrweb103
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MgOCo-1jRHhL1FXa-00NgAE; Fri, 26
 Jun 2020 20:30:37 +0200
To: Julia Lawall <julia.lawall@inria.fr>
References: <9725bf1f-06ea-63f3-2322-ffcce21cb218@web.de>
 <alpine.DEB.2.22.394.2006262019430.10382@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <c5ef6ff2-2ea5-ba9c-82be-305ecc9ab877@web.de>
Date: Fri, 26 Jun 2020 20:30:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.22.394.2006262019430.10382@hadrien>
Content-Language: en-GB
X-Provags-ID: V03:K1:t7q+I5zPBJXRrQEuoYeaIdQXj0JjsztPpI2KKmXI4BZ87yFs2Pb
 dc9y8qNWEFbGvc80swuuZ+cZYs4b93hUAayxzzP7hqEnxco1PN9Susx3TxAEnSPLPVU2TPk
 lWp5lVjNQez3MZRQ3lY8g9rLclWT3x/ZzUfeQplltbbBcMEJF/IuwLMtrkF9TpwnZQlQkbP
 LSPOPsdW0y187+Ca77IGA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DwEIgJsBlaE=:BOqyaRYMoh/dML9ItSYxg2
 1xIuvgFr79rf/Rs6IX0OubAzSNaKhKOnW7hnE1geWsWJ3QR6zYIIUjC705lbhgiFgdkHSzjyF
 3VzbMBzwDhGh5sfgXyiteRyZdlR5guTkxYc0hj5X61Pqo9ZLtwPwzzrQMpvrsEuo0ZNzN5fFH
 jAA7Pk1LkqwjDlexjTwPGDOCvS59j21OLN9weMNeM10pXozUv4A9eDrJnoceG1j8ZdUeBuM+x
 wLarbaslM18KMp1Ph4uQeL0ZzIPmJD79GpQjp7Ld0QQpWH+LFtUsGuO1YuGBUiUMmffkCCfZj
 SeH8a6pI1P9zbuyZAHvkdn8INAc9bobPad7iaGue3ZjXxJ4+gbZl/JtE6f3zySu7nezaua6yN
 7UCUWxc1WP2QfTGWDbnhoDh1GdMNa/8kTWHLTHnxCu8W+f55OUsy81ZkXAY03z5XVVIx9frBs
 EgEWOhnF+dZz378oFXrBGrH4LhKg92mOXFWRxyrRLMVqNJIVhf306KeTSn3nM697vK3StuRLZ
 8IGbeSPNGJavsOl5jY187ERXbMD5rgors6ZYGJdV8aqPB4VjQAhU1DGxbdvk5DzrG10lJ40q8
 mbFHFcXt+ZJIDyS6sB3ZQ9ljzDitITiHoemKMTetuskF3YPMwwLxhtfR997m+r+ZC2yeWUAlX
 CeZtdBvd1E4Gm4N6T/XUB0UUHlIMqIJRTGFFBzSqhXVkJCzmerMlhP8cB041AuyAb9VYwVsBr
 Q2gs/X+7mndD/ohH/wZmDLchsQq0L/KUhBq7XropC5Ked28L+uyArESGBeOVdDfJH85Vs/tuI
 0S+u4hM8XSTyVR49oUnNqUBDKIlvXQst/iW9uVjq+QW4j+/b41AWme1FelrvDVQrRbX51encX
 j/a9H1wDTDkpJNxxrhfpCeB0+nC9pmZjpnqWoz3JOgPeQv549Q54/39aZijUDDl8z6whRea//
 g5GE/EYF7jIH2p4qDH1eN9QeigbbsYm01r85dXRc37TfrILxaQbK9mEDVit/EeG3fdNHZ1YDg
 a4WnrK8a4IP40UMHi+BakZ5q5VId5HcgEl7uiSaXbwD462uDKbq7zrbcwyeFoocX+pcKFdoPQ
 qmAWcI/ErNNDPvByBfA5HEnj6k3gHtvsRshSnmDVPYzJa1EeFGDiBMl4fdGSlReQnzEGZXKpJ
 BK9JhRHdRiyAp6/nLUubUJ83P7rb2MFKQ0lXjPD/DKNZJltdCan7dxV8gI5GM6xQEmiO4XqtJ
 3NEJpbCWZUlkZVGsk
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 26 Jun 2020 20:34:02 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 26 Jun 2020 20:30:38 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Fri, 26 Jun 2020 20:34:01 +0200
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Checking the parsing for a nested SmPL disjunction
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

>>  <+... when any
>> (t2 y = <+...
>> (       sizeof(*(resource))
>> |
>> *       *(resource)
>> )       ...+>
>
> You are missing a ; here.

I assumed that I may omit the semicolon in such a SmPL code.
Can the specification of a SmPL nest construct ever be sufficient here?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
