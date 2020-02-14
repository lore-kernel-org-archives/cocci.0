Return-Path: <SRS0=ztE1=4C=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CE9CC3B196
	for <cocci@archiver.kernel.org>; Fri, 14 Feb 2020 11:52:35 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BEA4B2187F
	for <cocci@archiver.kernel.org>; Fri, 14 Feb 2020 11:52:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="XNbSYkjl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BEA4B2187F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 01EBqVd9015048;
	Fri, 14 Feb 2020 12:52:31 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 401197802;
	Fri, 14 Feb 2020 12:52:31 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id C591D77F4
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 12:52:29 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 01EBqTjt011168
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Fri, 14 Feb 2020 12:52:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1581681149;
 bh=l82InAov9OFaiPocTGLhGWaqpw7Rc607WvHNe1UpDLc=;
 h=X-UI-Sender-Class:To:Cc:Subject:From:Date;
 b=XNbSYkjl/4/xupWdqPjEmAF0gxgTGRLkyJ9+gA01wdRLlS43pejNOtiZmC+pArPTK
 aU1eYVqug2gTc6LhkciLFLdh5l8PAAvtrFtFAlbcrQE4PwCovYMVRSWN7Jiap7v/F9
 B/Q7rs2cw22ecxiM6xh2qtPOanFHReu17MGstbKY=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.73.52]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0M844f-1jOnAD3XYf-00vcz7; Fri, 14
 Feb 2020 12:52:28 +0100
To: Michele Martone <michelemartone@users.sourceforge.net>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <138939dd-ff5b-2b85-946d-891d028bb3fa@web.de>
Date: Fri, 14 Feb 2020 12:52:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:jGqasTr/3p1eDGXMYNVwXilUsGQsvtNCslmeqmME+hPpcTWoatQ
 3CXzigEbmvD613coGKk1oVByaDwbvIKc5FVFEn7PE7XhB2JdTl5xkxkrKTkAuUDVdAxU1o3
 YG99vHXpMhsPwZV4QrDXThC02l5XN8hAshcy5xSKNBrY1POvjXP0zhQBvju2jZhRMqLBrzE
 n6y9IzkeZEFD6CvOVldGQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:d+QvXv2S+l4=:5kEME6xPdUk0Zj9zgPlwCd
 Ml4KiwquXTyqGwwVAsonnnsKnkVtHgEjRiPMhuP2lKoi7yeRD+QdrdgGjZODMUUxoo6hWC7NS
 ElnssuqN5Y2/HxH3WOzCdkuH1/dEozrM/icfnshNYCJJgYyL0EMsnkedo+oCE/Q2ogVSjpOuj
 D0zNarr5d4p8JBoo0FnD/smyJOojLJcp+gpRFEizXJM2AlQVuXImNAWifALu/MwQsu5jpZerS
 0SFpCEwgcBq5ezpJ1ukLjg0L3a5uoCKdXZypbFMa3yTLeov4ncDX6rMxNtqhvfpj6Scq0xZAH
 oXIvmyumbEwiuXkzvNTUeoFtviNWeIBXyaGY84zyA0fgbjZ2p4s/VqtvexIOoM9MJauEDscWR
 6j7LvkyE80yFzrE4KnDaewAK8gcQ08tFbkGgLlPmOgX2wwGsr7kLN9HJ78LncozeAfRM473Nn
 6D6FGldF248VHCOVpajoD+doU6Pp+Wgu/kSniLOaR3JveiJZ10YO9xjKutPEQgolQPoe3ACxP
 0qnGgVsnQt/tx1qEuqxZZiqS+rJvnEmFyv6fPnZ28PaMS9RsHPg23GYKwwdOnXUCElKdtJdqG
 hEzs4FM39YQw+2uVYq4FVIAsnashhU1fareZwSxvdqM8bSxQNlZyrtGZ87+nyVdHAKzgqHCP1
 2C6OVD4PFBetxc/1rnugo9Y0tAnxEfoiJhzcPOK2hR8s8daU4I760/SneKcarl0vrmyLE41ul
 cjl9mmI0sjM2A48xG39xO1H4z5yJc5h1cx+Bf1XGaFV3VwMbZ5Fn7m3WvSvDG8tcvOAnDmjzG
 EaK1v79ZgOyVe+i4a9cRQ5tFFGAOG5LqzEDI9pItin7sAL591YBwxhYbjK0Jrg1UvQLQGwPNA
 qOd/11kL7Ks9AUcWb7hPRBeY8/i5Av7mTk2G+2kLZpBl+eRCEcLWWCHd6mU16/iRrIDMbDfTS
 hCQo1U94pYwt3BRI0ofQsPYTCo29blgR0ptECM70Ba2t+tYV+D5/6OxFyPr9SNmnUHDw2q/xK
 T+KGB6l4N1aNqCNoXo8q0jtb4tyMUDWLrObbwa1OW2hSR5lyUjk/81iMSu1eNhLamKJaWU3Jq
 aCqjTNoMRVrHSuwc05Py3eavJLSYWYRmMtFlvJY9yMqLztO2KNdsGUBvFXksU9i5W8O4mBOIj
 UyxS0KiLMMRtEbF2W8YDc0xMgcbBmFJ1U6DsO2wTXgFypGLV+UVDv1TL2lD677gvu8SYCjXX+
 X1nuW71Yr9ZEnXIGP
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 14 Feb 2020 12:52:31 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 14 Feb 2020 12:52:29 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Supporting Coccinelle software
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

> And because Coccinelle is free software, I could inspect
> Coccinelle and even adapt a few minimal things to my needs!

Would you like to share a bit more information about such adjustments?


>  And, dear Coccinelle devels, what we users can do to ensure
>  good health to the Coccinelle project ?

I suggest to contribute additional resources.

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
