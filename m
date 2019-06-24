Return-Path: <SRS0=9PSZ=UX=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74DD7C43613
	for <cocci@archiver.kernel.org>; Mon, 24 Jun 2019 12:51:24 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2CA1212F5
	for <cocci@archiver.kernel.org>; Mon, 24 Jun 2019 12:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="HTiK4Zwi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2CA1212F5
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5OCp8Qk021152;
	Mon, 24 Jun 2019 14:51:08 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 9E18176AC;
	Mon, 24 Jun 2019 14:51:08 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 073F27482
 for <cocci@systeme.lip6.fr>; Mon, 24 Jun 2019 14:51:07 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.14])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x5OCp4Ip013737
 for <cocci@systeme.lip6.fr>; Mon, 24 Jun 2019 14:51:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1561380664;
 bh=Xtu1fkRDH5hzHZDZOV9Y3m+aw3ChrpWa+1hOy/YonPY=;
 h=X-UI-Sender-Class:To:From:Subject:Date;
 b=HTiK4Zwifh0n9RS8OnyPcVM7KST3kgY50vworcsHv/RSOardRcAgZnO2yarsUamtr
 sIdX8bsJ3njbIhb6D2yUyOUCtiZmWAa68juDEg2WZm7JZh07ajR6WKehkAZuog0+DK
 /2SYlBd/kZ290vh2FdhWE9PZiv6q0wKTg3ivK6TI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.131.148.79]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MODW0-1hc6dv3r1Q-005Wwv for
 <cocci@systeme.lip6.fr>; Mon, 24 Jun 2019 14:51:04 +0200
To: Coccinelle <cocci@systeme.lip6.fr>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <43dc8f93-4c20-32da-f5c2-6f26bc4ef627@web.de>
Date: Mon, 24 Jun 2019 14:51:03 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Language: en-US
X-Provags-ID: V03:K1:af1ixxH7XzrqYq8xq0wnAiqrupWgvFboBgbXL2mB0FT02B5bhmj
 W7FIEgA5D2+r45mvT+Arm9xNslQ19vll7RcUQfghTcWafk6DmVvJ7stbxWZREyLAqpluYZi
 7zhBlZXD3cpoEtoJGEVgi9aw9LEpejp7R7va6RqBFECxSzdIl/Z5a5JQBXwKHLVmOAcdjy4
 wHh9TprYwZeQs2QoBvnTw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:kuMv0i9qocA=:WgmiHPCknlX2wa6aByG14i
 2+jMoiCC5XkdmSXWzB8Bl8OhVsCBIoJGuMArF7TJtg2E6gBHjYKy+bTR75z3RiuAMWgZjMSpb
 7CFyuF9dqsX8OfAhpCjqsmtTKUuffgKZIrYl97AbRbwJUWr5e7SrxYGOjudhwzQp49I8CZxE2
 GQdIrot42QlgMe5sQPvRdBl+dTUbBciJzTMjpIho5jSz52aOvLDQ50nCR6UjoE/Mxmqcd7TkZ
 57q2as/FBi+1MfWoPoqMO0U9aOJ1yldpmN5XbzGyimY8W6tUGUXY459HgsmvF6nBNAB6CEd2g
 X2MGBJoPf/NkpyE/e9orMQwuka7ZQ7s1ad2CAa7OgSma9FrLTt0cfn3AwZpDaUqZKn8bAru0v
 vPQaNbe/f3cgUnc00x9pREejFkBfv1TWSWkDW2aCqB3KfXKWqV2o8QhcaBwLeudFR176dktVf
 uZnNH9QZ6hUtUMRQgG1EgIrIhgBXueoZqK23HvUS/e/I0gTxEXGe8WUUhNNYjJKcgxbmqdHU5
 sNlqhQgVi6codBhDduGejD+xtMRRL59tFa6ChVLm3RpwCQwxdme24aV/jT1LmqjGQg4zxrtbe
 ZabhbrL/ClZvEfG3/zGjwm+vryph01uo/yWQ5hRRmNtXHpn1PTypTthjoDZIQM/IM9thCUWZ+
 t5ZzRpssv3V3WrjfF71eLkmGNMu+xMnUuyiEkstsgeRyqgqDaYVeRcSLeV8m+v7p9P12C2oet
 ueHOXbqxF1KuCPXaeX4xpBj6P6e38/pF1TnSiDuuPYeZ+E7TwpnGWrgMTTUp+dnxvi1DqtTqJ
 6a1chaYpdeEbBmPWdP9Ef4rTAGQEfHc4w5fY5ChNhMTHgzK84P5ATj2dICp8tBC5ANcdSmH+L
 DgDqm3z0/syjKr8fqjtvqxx1dAMuSFdnj+HoLkljIHZhgpKDdJmtTeRw+LnPLYjZLQUdkXlTd
 Q4NR57nSpwJU2427MKpofzhLtLxT8UUP6G2YOTBoCVm0kufrPhk7q
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 24 Jun 2019 14:51:09 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 24 Jun 2019 14:51:05 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Subject: [Cocci] More precise distinction of types for source code searches?
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

The semantic patch language supports metavariables.
It can occur then that a source code search should be performed for items
which should be different while they belong still to the same data type.
(If these items would be identical, the software situation would provide
opportunities to simplify corresponding source code.)

The expected difference can trigger the need to express this detail
by the usage of two identifiers based on the same metavariable type.


SmPL script example:
@display@
constant c1, c2;
identifier x;
@@
 x =
*    c1
 ;
 x =
*    c2
 ;


Source file example:
int main(void)
{
int x;
x = 1;
x = 0;
return x;
}


The used constants are integers and additional properties can be expressed
for such numbers. These properties can eventually handled with scripted
SmPL constraints.
But I have got the impression that other metavariable types provide even more
software development challenges for safe distinction of relevant items.

I would like to point the detail out once more that also these metavariables
can be of the same kind then with the consequence that it is not guaranteed
that such metavariables will only match different source code.
The support for the introduction of additional subtypes on demand might be
too limited by the evolving software.

How do you think about this use case?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
