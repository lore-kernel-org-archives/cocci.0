Return-Path: <SRS0=4B11=3Y=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFFE9C2D0B1
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 12:52:27 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C3B02082E
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 12:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="eetY2Wxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C3B02082E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 014CqEoJ026132;
	Tue, 4 Feb 2020 13:52:14 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 3DE4977EC;
	Tue,  4 Feb 2020 13:52:14 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B6A6077E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Feb 2020 13:52:12 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 014CqCfo022987
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 4 Feb 2020 13:52:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580820730;
 bh=DF4j/igQ40pmFhy1SoRSoxYbYEc9gDV4eoMGDY2hok0=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=eetY2WxhffOhqPEwqMZxsBxnkVm3IwOa0N2P44pOvbcsPvZSuM067BZvy2lYRE4l+
 yxIB26H12DpQgDr9YkPcI4C6NIEd7G50L21xTMcZsuXxxxgLQvqVquhdsjMyOEOroF
 iDcvmWLblT2U0zJntISuYI96M52G/jV83wZZQAes=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.133.16]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0LqXBp-1jTdjX25AX-00e7kk; Tue, 04
 Feb 2020 13:52:10 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
 <alpine.DEB.2.21.2002032151520.3356@hadrien>
 <e1dd289a-c6d3-4c01-eae2-803aafd0cfb7@web.de>
 <alpine.DEB.2.21.2002041341470.3456@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <37e49b53-b55b-e22d-af6f-d5b27e79fd6d@web.de>
Date: Tue, 4 Feb 2020 13:52:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002041341470.3456@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:Nwc6Gspbf4w320qmDHQO1xSdN8MLCu472Acrjj+uY8VUEjxgUWP
 WeKk+a2BGqNyDC/LB29EGG2zfPb1Jp68km/121jdNfhMrw6KPZ+k1+NZ9XOso7RT5WuvDih
 0AiLppVp+s3WJ/UXNPY28p0H/0erfK/e3NeqhfPlQ0khQdcjhaNIUAcJtu1TCTP8vUaS8Ni
 d3LmiNW9MTrOyPrWVQZww==
X-UI-Out-Filterresults: notjunk:1;V03:K0:MiXhYoSQqLs=:p8EwH4eOVIomLp2x2ke5L9
 65Muhi+ePhxCCjyGnNHar44+wtTsL0w3MnAAa0yZB7rjSwJi3/mSzG7mAR20u6e3NCIvFHzJg
 TN091IBcWLEZ3NBMEap4XmwVuZqlbmwMBnGF9sPGWZFprF6+AcNBJ7lgLmY6qT+jk4g8fPtDH
 hf+z5E1Au7cabwnbTPvy0hlErHgoN0dLD8gHeXVEqMmyTCeEKxZffhVEFgGCQZfl5pbtjcpOn
 WeTZPgNkjsHDmQZC22JTD5WdmhpCQxj46qFVFYoLZY0wlID+bBbIc6AQJlGRxCJ32cAIZPEOG
 KAdKrIpbV/KArNGUq+XjAvTO3k1gAeGQLcEoPqOH/jJYmeFi/uYhOfnjRVfm7Sw6o8Zv9klSZ
 G01oBScF1QO84mQPLZtKbN1hwoYqGyGi/JuwCsck7OEmHSU6dGyq90QUDO+///S2MuZ9XjJdp
 DUXIBlmFFKjlA/+//kiYxYpIPBCLldAwzLAZiBd71LcaRfQMLdYflKOUZjQiK+smUIrtFqXr1
 S9BFb0KdMAFrU6R860R1dj0nBiYTE1Z3hfZSITM8+K/hGrIFI3PdXzdJvEjbTdHL0P3tRdZtu
 BtugEaTnlUVCUocyAW/uJCEOttUlbKfTLDcFRlpkNyir1knMAem07cpH4b3c66tqjvsidZ6FZ
 ahgocTvQYR6TL2iggtXt3G180Rc85/3pWh+thLo5KLJVdJKBcnbHUJreAjlCGaq9v59jaMPFb
 vURcnLRfW+XiUxJQE7xLa8JqwRbcQjbIDvXd94HBNvtN/P4qHL0+VjZFbKweJcRcImBUpPOQw
 VKgMs6r1NhKObvXjB4uyOE6b7hxKAsT+p0/A8E/Rd/kp2CCu+7T3DcWA05lUgZ1BItsjcjD8h
 N7638UncEiCv1lUMAPc79O+SeLAPF6NDmjd/MU6aH/IUG6m+pg6PgsftkL5XvR1FOrMdrsHIr
 wrnrXhoQ+XPitM3l7B5BotvTc2Tboz3rXjAtgFskFLIHrDU5ndtPkSWK0Jy0Rw8Px7EkkmdOp
 tvBjGtvxyiU3ZD+oGGdx3emAExivpiVS4Xnu5dtSJBxZS/VwGQK8Q9XR5xUJzNnyq9Ct5+dqR
 RTecPlnU8VUhV0NrwVRLJWPo/k5eFng1l/mm2+mtc3+J+GOU46zrbTPleTGKUQe4IMcEmTIDu
 AaRjZZ4qWa2+UwFk9GNW+L4Vaeuk+cDj6vKmpbY1swIn3L1NrWahtDxTHncX1GBp/kh4QZeR4
 moyTLLCtFT8EzRzbd
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 13:52:14 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 13:52:12 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Wellington Wallace <wellingtonwallace@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci]
 =?utf-8?q?Searching_for_usage_of_=E2=80=9Cauto=E2=80=9D_w?=
 =?utf-8?q?ith_SmPL=3F?=
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

>> meta: parse error:
>>   File "show_variable_definition_with_auto3.cocci", line 4, column 8, charpos = 46
>>   around = 'auto',
>>   whole content = typedef auto;
>
> I understood already that it was not meant as a type.

I tried your suggestion out if the idea can work finally.
May such a key word be occasionally redefined (by the means of the semantic patch language)?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
