Return-Path: <SRS0=4B11=3Y=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DFCBC2D0B1
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 08:39:49 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D136A2051A
	for <cocci@archiver.kernel.org>; Tue,  4 Feb 2020 08:39:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="QTpMYIVQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D136A2051A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 0148dapL015390;
	Tue, 4 Feb 2020 09:39:36 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5EA3E77EC;
	Tue,  4 Feb 2020 09:39:36 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id A464677E8
 for <cocci@systeme.lip6.fr>; Tue,  4 Feb 2020 09:39:34 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.15.4])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 0148dY4Y002974
 (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO)
 for <cocci@systeme.lip6.fr>; Tue, 4 Feb 2020 09:39:34 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1580805572;
 bh=AtX9T/VmcblJu+9QllbSmpHDuLLPNeRwfX0EK93gzWY=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=QTpMYIVQhL7bEQw9hrTBnKWqjeFRcyQ9uatE/kE/BHqEPMrrpNPTyyi3UGuQtkpXn
 u3h2QVzSIN0VzF+X4pPxKpGIYnKTLPP3wZUCt0lKE05VcrESn8DdNO5p5LHG2IYJR4
 T6QdSxzhPRVUyPLKc4vMU0f8fh1OaAEKdE0KgvyU=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.133.16]) by smtp.web.de (mrweb001
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0Lk8Ow-1jWZnq2gf4-00c5ja; Tue, 04
 Feb 2020 09:39:32 +0100
To: Julia Lawall <julia.lawall@inria.fr>
References: <72729ef6-f8df-942f-57aa-4b3fac75a20d@web.de>
 <alpine.DEB.2.21.2002032151520.3356@hadrien>
 <b318a372-2f31-f57f-4684-62ac2b82bff3@web.de>
 <alpine.DEB.2.21.2002032226260.3356@hadrien>
 <f0ccaf84-1b37-4936-3a7a-d5c11e3ef1c3@web.de>
 <alpine.DEB.2.21.2002040913290.3236@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <be104c82-34bb-e11b-e2b7-caccd0a101fc@web.de>
Date: Tue, 4 Feb 2020 09:39:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.2002040913290.3236@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:LUha4R3RSi9QomsQzJq2kOOmkTdCaVcEGH4sl3yfYEA5OXWNl9Y
 dL8Owyx1s965fMGVhHMYMHb91IvarE3+65S223iHdwEJQJovdUPNRguFkdSa11s0Mxp/mhl
 XtIDusY44zL3bAqhCDdRCcUWDD0LT9/Ly8srbLXmCSahtyUJorke0Z6BRuW/TqfWAdso14A
 +hodtqc1o7LFy/2yzzsDw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ipczbNavp6E=:kmbL3FnEVhD/LlihsGq3II
 MxpSQ8+bEsO8GT0PXmqTaBddEyjRar4StuEsWMtaPjjD+AuhHpK1Wp1iiZjgqhTwakxL/aJat
 7S/a/KzITFFmzszf9PSwg9KNxwpe3qDaT18VccnAxlQwj7UKdnmfXq9ysx5Mcenk6th0YyoWB
 +wi9Es4ZvLmeXy3bcerdrxLcTlQHCfRLACCh2C6+h0qyBpm58z5imiN4rvv8ixEYwBWUt54Gl
 KVu9v/aVtX8t67rY0Y7Q5t+HjFpxwKsBPtLK6HokKwhLZplwNp+38mpp/WmMXxoAJQjB4+hS9
 82/3WjgEqDVN1p45VJy02QW6omEdtTIyBy+V2EGx1bBmo0kCm3yfu48U5nZfkrHhBeqpw9wgO
 cwACAN7D6ngVLaOtGoRSVb+VWGntJYBcdD4WoNtfpJ9n1+KxUa3GhS09oYBVlcJhL2rWh30vo
 /YLcBub33yORxQYZNagqnj736BUBMP6Fhe9wPqcCGAqvxPRKidEyWxH74YptFZAywC1/ijPdF
 CCcHKRzxaqWAz4v2njjqoKn2X0DSOYFGvVc5KKBUHv6oNci7ViAcRutx5DaXNeDgLym6Ec2lq
 RRC98k1mN/b9BmkkguSoJUgtgYyCYNvQa/ipTcVOxXAAVhx295QrA+R912RBdJpnbcsbuYKIZ
 Rf6JsMmwvIqoc/3huSaVLhMWG38SKg8RspJ31R15ymwuIFdUJaxzOoBbYSp3atp8O63A3beMB
 LX4U4o3cBXHH+/YCP7zdlqd6qHUnRWd/Nx7UEnX3zX29eiylAmd4hVT7jQZ93TmqBydUpvvDj
 heK13mq6j/vbqwDEPwmcuxg4J/KsqwbNM7+J4wDlCwfcDqbdAaRnRnSbDwJbJQenZekSks0aK
 UNH95ZdsjNp/ej/n6ElqYq4t/U4sSvuZVAAWOx8zoHoJvnT9pnclnJD8MTlFk/RtfncJgw2pp
 wTtxbu7729odGZC+aOcIYv67cNCA/e7THcaAehLFeS12EFd7JpPm+nItRpqNcFoADkCSpjxmG
 Acoivyo9KL0Qm55NxgaG8fTfHABCmWurf/PwzDAFJ7jeSMFKYHXjcnPI8PIZUvDa7yVjJ2cUp
 3UG5/csGYudSD8ovJdlZBFCrQ3DIXWNI5d6t92MPkkWI7qbr/ptq34AiqkdFDnqXOt1MTRMp1
 f8c+GNcjF1vORzFRx1aksKmmN1dWKM+5rt7fXVrWjnfxPKr5leEX5JBSYG0C7Tny4QDi7HXKo
 esdyk6NS3BI6iYptX
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 09:39:36 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Tue, 04 Feb 2020 09:39:34 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Wellington Wallace <wellingtonwallace@gmail.com>,
        Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Replacing a std::string check by strcmp() with SmPL
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

Pj4gQGRpc3BsYXlACj4+IGV4cHJlc3Npb24gWDsKPj4gaWRlbnRpZmllciBJOwo+PiBAQAo+PiAq
YXV0byBJID0gWCguLi4pOwrigKYKPiBJIHRoaW5rIGl0IGV4cGVjdHMgYSB0eXBlIGFzIHdlbGwu
ICBJIGRvbid0IGtub3cgaWYgdGhhdCBpcyBhIHJlYXNvbmFibGUKPiBhc3N1bXB0aW9uIGluIEMg
b3IgaW4gQysrLgoKSG93IGRvIHlvdSB0aGluayBhYm91dCB0byBpbnRlcnByZXQgc3VjaCBhIHZh
cmlhYmxlIGRlZmluaXRpb24gaW4gdGhlIHdheQp0aGF0IHRoZSBvbWlzc2lvbiBvZiBhbiBvdGhl
ciBkYXRhIHR5cGUgc3BlY2lmaWNhdGlvbiB3b3VsZCByZXN1bHQgaW50bwp0aGUgdXNhZ2Ugb2Yg
4oCcaW504oCdPwoKVW5kZXIgd2hpY2ggY2lyY3Vtc3RhbmNlcyB3aWxsIHRoZSBoYW5kbGluZyBv
ZiDigJxwbGFjZWhvbGRlciB0eXBlIHNwZWNpZmllcnPigJ0KYmVjb21lIHJlbGV2YW50IGZpbmFs
bHk/Cmh0dHBzOi8vZW4uY3BwcmVmZXJlbmNlLmNvbS93L2NwcC9sYW5ndWFnZS9hdXRvCgpSZWdh
cmRzLApNYXJrdXMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KQ29jY2kgbWFpbGluZyBsaXN0CkNvY2NpQHN5c3RlbWUubGlwNi5mcgpodHRwczovL3N5c3Rl
bWUubGlwNi5mci9tYWlsbWFuL2xpc3RpbmZvL2NvY2NpCg==
