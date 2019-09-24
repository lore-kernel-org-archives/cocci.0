Return-Path: <SRS0=hgwh=XT=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D81BC432C1
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 15:40:47 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F961207FD
	for <cocci@archiver.kernel.org>; Tue, 24 Sep 2019 15:40:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="mq3cJ/qo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F961207FD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OFeXZv006955;
	Tue, 24 Sep 2019 17:40:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8328277AB;
	Tue, 24 Sep 2019 17:40:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 7A663779E
 for <cocci@systeme.lip6.fr>; Tue, 24 Sep 2019 17:40:32 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x8OFeWod011734;
 Tue, 24 Sep 2019 17:40:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1569339629;
 bh=DMWyxxVyIF/Yy5rVXJ09xb8Rjb1LQ3X/JJHkVZ1WAUY=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=mq3cJ/qoInY1XwuBPvzZkxNxawPOzB3gHpINFtdoO+AtccGawYet3WGtAeVz41EqN
 P8bz8KeuFJFobpy9JSxz8R/K96pjO3LvzwE+SSquF0Jr0TGada8y2aDu7E2e3eBS4Q
 KO1ILBYi94pXMjlvsaHHCwRm7MVQjxSW+PkFeiOI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.71.162]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MMEzJ-1iGLIW2I7p-0081wU; Tue, 24
 Sep 2019 17:40:29 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <e07ce253-8a13-0f90-3ee0-79c1a0e78b38@web.de>
 <alpine.DEB.2.21.1909231058380.2283@hadrien>
 <c4437d9b-8795-fdfa-7914-fc30ead14cf7@web.de>
 <alpine.DEB.2.21.1909241729310.2282@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <13e0efd5-cc10-b2ea-7ae5-14da2fe7e829@web.de>
Date: Tue, 24 Sep 2019 17:40:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1909241729310.2282@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:wt1wmQv2ZUT2co0o+HTF1hNLlnq8UEtjT4txnIYziq3ywIC9nAi
 6WVknXF06/8VOYEEKYGKvdv8mZvu6rEtc45I0gWQ0s/ILCFUxmMDSNGsjh12BKA2xNESBqk
 AIZGCYQ9UBr4ykERTwGweiAhiciXGnv0+GGzOAcwTFDFv1vAytZ8fWDXVviaRwsvsa1i5vt
 U42/qS4SRwftrGL3wMNLQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:zbVyu320IMQ=:63QcYSeN1weYvhxxiH1Q9S
 IalIfC4A9F/l0igoeBbPvdqYRWlEB1zGU1cghEwRcU0qJpZWFmXhzMi8pTbNsCqzixeMxGlXo
 A1LlFZqUcPt+0B743Ci5SZOUNZ9TDDZIJtCj4lxpOIGbeyA/9yAEFmzYZAUF+J7n9Ofz0Lu51
 GmMDxS6B9GIeb/DEPrEmf0B1wu+z9seTCjOkodnRWYt++kAK2FAigdf4p7X5xTTgcLdddp3kV
 Y0ZJdgvXl/hRO6vmSXFp6gOJbDgPzK6OIf+pGBgKIRm2OMknAnlus3pm6vGY2+F7am3OY5qbs
 Oyzl51CyjSv5X98EZZctHo/NPIpeqmN7JLf7WoV5DhQ6i6uky0DkIExccCtVxg7GvVcK0YpC7
 V5NNtgqPpGzgSgccEr4xeHYIjWh+KnCPCTV59L1F7F0eG1JPu/BGcnc4PNh3ZaBE5zS3hKzWa
 O3tfNsCPmK9qEIjB5LZs0mzLvrJBM0Xqs2Aj5XzAG3l5+UT3GKBg1nyxQ0Lih1AkKYbcERt4C
 PbQ7ECV/722ovhre3oDKDV25G7zlwgWDItIFgnW/Qn6W2Mz1yLR5faMLupnQvN2Dg2Br7QUG5
 lGllZuD3Id/2p/Sd2N4LQJnQudNNCeGCBbJldbuGsO69CVHYeGUXjCPRSPlQOxHDXWrn/wQhz
 nD/jZVBA8rpPfAs91W89hJ6jXagAW1Su6TxeuS+b4HAtPGlksJepanALpIFVbrZZsAYAnaKQ3
 CydJu7MLeQxEHxqyLb/U7LI/wjMK8XpmOcE034BJInVwaesBJW3Qb99Omtib7VOwyEMci6uOm
 HC5Rzk64C6Yg91zbwvA7U+Z/Fko6WYUI/ad7PGhLYy+h0p43VCv2oIDR/3ZYa0q9OgheMM+36
 qe079+VLaD0Ldkp00LWhb4cDOIFTskitlhht1QFK18GMeQ1GV6sppNPcqmXyfQ30aKWkCdHF+
 02OA8aV3TV9iMYHR8GHHQoccFuhBS/+kOxwawDltDoLnRv3WLu09R4Ni96m5cSOiRY6IfspoQ
 Y4M065bGi57eF3sILANCqRGxzsQ2of7/vtIw0DVkfUiEP7TzQLv5UZAcxWSAOERxzvSymk0Wz
 iw6is2CzPBKitffGphfkIWbsOSRYuCRneLyeMJqgjNxcaw+MW5jg90OoJX5VowlWFZDGP80Gm
 3B1LQCiLoTvYSGuJDU/cKRcRxUFMMc1vTvIEOFtQ8qhipWD5HahcYlYf7wlOpjBZ8hT4IcdWV
 jjlj6lPwsPw0JpHxw3kuiP3twlqGYjRKcKc52s9ZddFZOBJOGt2wqySb5EpE=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 17:40:33 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 24 Sep 2019 17:40:32 +0200 (CEST)
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

PiByYyBjb21lcyBmcm9tIGNoZWNrMSBzbyBpdCBzaG91bGQgYmUgaW5oZXJpdGVkIGZyb20gY2hl
Y2sxLgoKKiBEaWQgeW91IGdldCBhbnkgb3RoZXIgaW1wcmVzc2lvbiBmcm9tIHRoZSBzcGVjaWZp
Y2F0aW9uIOKAnGlkZW50aWZpZXIgY2hlY2sxLnJjO+KAnQogIGluIHRoZSBTbVBMIHJ1bGUg4oCc
Y2hlY2sy4oCdIGZvciB0aGlzIHRlc3QgY2FzZT8KCiogQ2FuIGEgU21QTCBzcGVjaWZpY2F0aW9u
IGxpa2Ug4oCcdiA8PCBjaGVjazIucmM74oCdIGxvb2sgYWxzbyByZWFzb25hYmxlIGhlcmUKICAo
ZGVzcGl0ZSBvZiB0aGUgZXJyb3IgbWVzc2FnZSB3aGljaCBpcyByZXBvcnRlZCBzbyBmYXIpPwoK
UmVnYXJkcywKTWFya3VzCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCkNvY2NpIG1haWxpbmcgbGlzdApDb2NjaUBzeXN0ZW1lLmxpcDYuZnIKaHR0cHM6Ly9z
eXN0ZW1lLmxpcDYuZnIvbWFpbG1hbi9saXN0aW5mby9jb2NjaQo=
