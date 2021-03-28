Return-Path: <SRS0=v4mC=I2=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48910C433E0
	for <cocci@archiver.kernel.org>; Sun, 28 Mar 2021 09:16:37 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D7A16197E
	for <cocci@archiver.kernel.org>; Sun, 28 Mar 2021 09:16:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D7A16197E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12S9GXDX008971;
	Sun, 28 Mar 2021 11:16:33 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 5B76777C4;
	Sun, 28 Mar 2021 11:16:33 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 3C35D3E8A
 for <cocci@systeme.lip6.fr>; Sun, 28 Mar 2021 09:19:09 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 12S7J84V000080
 for <cocci@systeme.lip6.fr>; Sun, 28 Mar 2021 09:19:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1616915948;
 bh=LOk6RaZcazawHvUEp47uW7DUlFD7kEu5ywG88UgRSQQ=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=BCpSSyREliTLfULMhnHw/02yx92r6+taireqaJDK7Rkst4vnIaVPzpzwb+g7PZtCn
 ZymV9h3qP5Cl4vdVhspsBvDbAbSvvBwAsbWYqGyVQ23LB6vJqc6jN37iNoabpzzU88
 J1mSyN0wfh3cdacAM2xRH10KZxGBgEgV/JYl4FfA=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.133.73.126]) by smtp.web.de (mrweb002
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MKJEM-1lS3rO2HeY-001lGS for
 <cocci@systeme.lip6.fr>; Sun, 28 Mar 2021 09:19:08 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <0756b630-a2d7-f300-3b11-59af33b48631@web.de>
Date: Sun, 28 Mar 2021 09:19:07 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
Content-Language: en-GB
X-Provags-ID: V03:K1:SB2X1zKauVzMplYcWbUyQUno1mpyRH2dIKsR6ORHZRtmlAflVx2
 6xXpW4BEFLlAZ3gESEiszYUNFj9haf1LYVx7ANCnQ9sgQzmC6Pwcj9/wVh5I2JmPRAJCWvp
 TGuui1ao+lTqYLBrhrsGwcUGVBZUC2mKWNKfWu9o3VseK+10BObR3WKRyTs5U6nwkuz7/5s
 R3vEkC/I8KrLnJutOlbrQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:GnYXfCPiji4=:wdVUzys7xAwBYK5Jv4Z4hN
 TaYw61jpYNTh54tI16RSa411yv3LzU+HgcikSt9aqNQYbQjlqQME5aJbhNW3BKHT5P7d80RIi
 hqf68//gG970GMOFwTXHx1d/w3d4hBXRcKKEcL3TOzec6uE1OeJE0Z1mHnLi5hBzzdTx+ipX3
 D451/DMIxGFQWYw7YmfRM2KahFhzWYN7KW4Wc49rSQttQTd3wPo0saI7NfyYLNtBE+c5m8MEa
 hp4EvcSzMLTMUgCW+ZI036tebNXin2npHZoTbTNVDCPhygkSGCk0HLL9ESVdhFP85BDNs4Mix
 KDXGa8xn1nbUOX+W8ids85q/YUG67n6CH2mWjNbgeyR3rXiH2zafwwbBOsGYAJiMUePQ5YNWR
 i0hlnKTrW9pIlPQxghyQbTKUUl6C/K7rqtwvy8kncrcaF0c14B1iw0pdALb+wCIaIDsrihIBN
 HzyxcY16EWh+OUaN0TT21n/PabE+8QA6eoVQgARO4VNoCTcoA8mYfnSrdy2+PtvswDI4SxdMW
 QuM+VtRkX0hhKqcuCaS67MI5is+OLjtdZ3PVG9jMh6kIpNBdZhNjuj0BWJPqA2U2pjGlDphbg
 Ey/VYmLlF3XZhXVaMbyD9ofh1UR+glMVt6+La271qnzQQ46t1I9XC3VGekv2YsfSacl2N2Rq7
 8IELguWw2ewLgUVHjeIzhiNNjW5tiV3FR4HaVHfkKJ+wolTb3tUKu3xV/QwcNNgXelMUtcFWQ
 gehvFiqw1b+NK1vx0fio6XHhhyMby5LRug0aADm5OIoMK3QPzkrSjOPzPlIIMGkN4N70m8Faq
 ZM5tvj5dV95E/uhezk3GQMv166D9Yg3KjmV1w58DD4EsWcq6DUOYicKAip5f9VdNNBi6GSDJT
 b4MRprIC6K3JaGj4K7ZellHEmObB2HXvkTwM4rp/qyYb0xXjvr8L2X2mHs/iiYv93AH3DLo2b
 CXJRUXoyUb9f/Nng57fzkyH6gsq/VxWNyGObwJFmtBKJgaEMIxmoOAq2XI8X889+ql0/RadYk
 6Qm0PpY8UT8UtYQ5I1KhilGI5mucE44nEcDv87RMXwDKP7TlihmJt5E7zuD9O0vhnnDDSKYkz
 vejNoQ2TJM1dm5Eh2cJq6QkLTXk+D3LFY9EdVOMCaVsiSnzkOMOsQi0AxMYZOVe1f7x2SvCVc
 1IHOj+b5f1T3+mSWDIWi8PtDZl2HUiy0NfJ+8z8KzXYhX9Fv8XzAzfwL6DLmkNTUy9k3A=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Sun, 28 Mar 2021 11:16:33 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Sun, 28 Mar 2021 09:19:08 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Mailman-Approved-At: Sun, 28 Mar 2021 11:16:31 +0200
Subject: [Cocci] Replacing #define directives with the help of SmPL
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

Hello,

Will the software development interests ever evolve in ways so that #define directives
can be replaced with the help of the semantic patch language for special source code
analysis and transformation approaches?
https://github.com/coccinelle/coccinelle/issues/139

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
