Return-Path: <SRS0=Cozf=YA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF079C352AA
	for <cocci@archiver.kernel.org>; Mon,  7 Oct 2019 11:13:43 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 00A7A2064A
	for <cocci@archiver.kernel.org>; Mon,  7 Oct 2019 11:13:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="UWVZgyQW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 00A7A2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x97BDMU2019742;
	Mon, 7 Oct 2019 13:13:22 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 81E6077A9;
	Mon,  7 Oct 2019 13:13:22 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id ABB9476ED
 for <cocci@systeme.lip6.fr>; Mon,  7 Oct 2019 13:13:20 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x97BDKx5022105
 for <cocci@systeme.lip6.fr>; Mon, 7 Oct 2019 13:13:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1570446799;
 bh=5S1K/81s+cAHtAnY8wFIO81izPrNEVpMQk4jAHrJheg=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=UWVZgyQWk8q8+NixcHmOsGV33cWZeC41ErVk/diVQ72BwE7PH8CXPG+7mfb09Z/as
 DUZLeLs3+9d5J5o62zLBGjkmvJGt/0IT/DKd6sjSqAs4vOhnqWd3evmY9K/2x85MVE
 dPOI0gxOf4E61O8rHOlHS30E89iSIJ3zbc0U/3WY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.146.95]) by smtp.web.de (mrweb003
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M6Dve-1hsrp72Mpu-00yDO7 for
 <cocci@systeme.lip6.fr>; Mon, 07 Oct 2019 13:13:19 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <88687baa-db7b-1c73-c219-05cffb167af0@web.de>
Date: Mon, 7 Oct 2019 13:13:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:UC9tjnnyE3K0FkjZ0cjyaI13PbZy1+2/bIRA+R5DwRBnz7H4g35
 Mq0VbGBKpTE4LTNHoZfWIAqCKRPpNdzfsbPUVlSQadFqjwH9iSjL8uSytf2ijJWSJTuA6lu
 2MvDMikpACwKB2OB13Bzhl0d7nBoYSY/lzLlD79QV8iPTI1wCdduvDmhB82+5ZK9A+ltqPE
 WzbuRssWLqU53YK/eT/zw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:3XEbv4LahdQ=:7D7yUBym6ISjA4e1QXeVae
 HyZaORXUhV+7a4feQxEokbW/zm5dmMYHK93TWFHqcWDaumNYFqKlelw14lj8+XkiSxpqPwfFk
 u7r/SAcye8BtS5OpsHcqrF9RIflkODy6eEhffpaxOX52UQhl7Dd1v79o065yq91va3BT55J/O
 8bzKP6rNZEpOR2TUjMDEn+hDm8XfrGrnT/W5jiV5jhSxG4Re9Gm+CrSmzuDoKPzyWRA4MCdjn
 +jpgKdd4xf4IDUgYrsDTeqEkVH7ii1Pf63qEoqP3MJfBpo/aWdbbyHfF6pp1WfC5Vs6snTFGb
 jezfLqA5X1XPBnVPqWba9pPk+VSJ32gnDRhXwyfXYJxb1/bU86rJx7mP+qgIEpWMdcxm6haS/
 Srx2nCJmEN3896nxw6QTqZoLLQB9lg8XdlbO6qmfcYolT478KZb8goh+zmeRlW4/qSWaezBtt
 YqFi2ny9t2MRH0R3oo/DwEOySq93wYZxUp012pbRk8BJoI9+XEPsZ/fo4zzA/19NEoT1CRJcZ
 XURXIhDyYt7jxo3YyRVsOBsMufQ8JBOWxccHL7ExgPxMqGgpmKvyMV6Uap5fBS9rrsUYkMRY6
 Cywnnccp3WHIpXykUU7aucO8jJKVd7+HvXQP08SFFx6KaMB/2GS6HQK01VkdYyMWE15EvDjrr
 VNqaHk72wzDI70Bpsj/7XpTXdDeF7R8zCWpz4wERKTZ8LoO5h+N30OCk1G1ogcqe2nd48dr5Q
 EkCKGkmykKFI1J0wZuHmJC01vkA9lJ8omfp/OuYKNqCU/sRS1rAsITzBPwMeI0doBBwxc7lVu
 IuJeYbH5cvIO4LEKdeQqEa5/EbOwPIg+IbismpkE87G6+FT+H4zn8CW+kMeJPxy6PrCGyU3YU
 ubOorpF7NRy+yMnKlu/jel9ufBlqVWC9qQra3bpfnYGd4vV4ilh8+y9OeGQ59lB6nL0d6ffgL
 qdrVS2KyPvRYw3c6m9ZfaVSyoEKzVSyAXEaRQqxSSjghN0LVuPmRLf1octGh60/OokIrFVy/V
 eHIpftaZ1G8WgWqlTDoLp0/WshmX3fuZ3nzjOq80PIZIMdFdGmbd24HbZ7zXo455dFB7SWFF1
 g+xQMfVBNQbvj9jHldovRau01jVd2Pf8nmbPZ/8z38A4fFO7H/lysTD17L51Vjy9DUI8hdtIm
 RBHBogDaoHrUlPMnYz7RbDdXMpZZI2bVczHeQPm3+slJjk6VF5ZLh/c9yB4GOkFtx7Qc41v19
 9kzDbvr7Ckgfkr31n2iMz2Cf0bMWCJ6NF8HsqDaVkGAzWFWnTVLnYYZolKt4=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 07 Oct 2019 13:13:23 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 07 Oct 2019 13:13:20 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] =?utf-8?q?Checking_the_parsing_status_for_=E2=80=9Clinux/?=
 =?utf-8?b?c3RyaW5nLmjigJ0=?=
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

SGVsbG8sCgpJIGhhdmUgdHJpZWQgdGhlIGZvbGxvd2luZyBjb21tYW5kIG91dCB3aXRoIHRoZSBz
b2Z0d2FyZSBjb21iaW5hdGlvbgrigJxDb2NjaW5lbGxlIDEuMC44LTAwMDA0LWc4NDIwNzVmN+KA
nS4KCmVsZnJpbmdAU29ubmU6fi9Qcm9qZWt0ZS9MaW51eC9uZXh0LXBhdGNoZWQ+IHNwYXRjaCAt
LXBhcnNlLWMgLS1pbmNsdWRlLWhlYWRlcnMtZm9yLXR5cGVzIC0tcmVjdXJzaXZlLWluY2x1ZGVz
IGluY2x1ZGUvbGludXgvc3RyaW5nLmgK4oCmCm5iIGdvb2QgPSA0NDQsICBuYiBwYXNzZWQgPSA0
MSA9PT09PT09PT0+IDcuMTclIHBhc3NlZApuYiBnb29kID0gNDQ0LCAgbmIgYmFkID0gODcgPT09
PT09PT09PiA4NC43OSUgZ29vZCBvciBwYXNzZWQKCgpXaWxsIGl0IG1hdHRlciB0byBpbXByb3Zl
IHRoZSBzaG93biBwYXJzaW5nIHJlc3VsdCBhbnkgZnVydGhlcj8KClJlZ2FyZHMsCk1hcmt1cwpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpDb2NjaSBtYWls
aW5nIGxpc3QKQ29jY2lAc3lzdGVtZS5saXA2LmZyCmh0dHBzOi8vc3lzdGVtZS5saXA2LmZyL21h
aWxtYW4vbGlzdGluZm8vY29jY2kK
