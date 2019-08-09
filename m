Return-Path: <SRS0=BmBQ=WF=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DB25C433FF
	for <cocci@archiver.kernel.org>; Fri,  9 Aug 2019 15:08:30 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6DA14204EC
	for <cocci@archiver.kernel.org>; Fri,  9 Aug 2019 15:08:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="s3KNFIBz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6DA14204EC
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x79F8CtX020544;
	Fri, 9 Aug 2019 17:08:12 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 02458778F;
	Fri,  9 Aug 2019 17:08:12 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 95EE27788
 for <cocci@systeme.lip6.fr>; Fri,  9 Aug 2019 17:08:10 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.17.11])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x79F88tc025405;
 Fri, 9 Aug 2019 17:08:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1565363286;
 bh=gdmSlYrS9mPx0q81J259b6PSTFQGD3sk1wQnxKLp/HI=;
 h=X-UI-Sender-Class:To:References:Subject:Cc:From:Date:In-Reply-To;
 b=s3KNFIBzrAZDzHWoUBLiXu/z+8dVi8iCBF3u2e5bQNx/Ik56PlNDiUeXxjc1rSNkc
 G8+kPgUptVWwHLVwWXdWXhAMr/RonOKwJQv6nNnelLOb4Z0dwolxaVQdZl4rfTNrJR
 /S/ky96VRfi264Pg9i8cPqSnG/RRSTtSiC3i8rP4=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([93.135.93.105]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0Lj2Dy-1iSP7234ZS-00dHlN; Fri, 09
 Aug 2019 17:08:06 +0200
To: Julia Lawall <julia.lawall@lip6.fr>,
        =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>
References: <alpine.DEB.2.21.1908072337230.2601@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Openpgp: preference=signencrypt
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <30294acc-faa0-4d29-55c1-f1710ca88037@web.de>
Date: Fri, 9 Aug 2019 17:07:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1908072337230.2601@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:x+n/uFTlnPG0cSWREXz5Ot3Ch83uL4BzZrBQsweKeWTpoPye6qw
 ljj3VCxzE0779AJm/T9iTVYD6pa/7gtuhNn4JqGesf/cVj3bBBIT9EwpEzMNomBtOLkunAS
 m/8R0mqWAhOeYG6z/QBZYWqrWshKoHfx1VWG9dPDzCcesUFasnx4E7TeGfQgWyv7CLwWlCA
 DENzwZOn93F5+YB0mqrZg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ee1mT/gVE8g=:3fFQZvUhqK6VHj3GBDmBUh
 cFPRawttzlY+unqXcAE/OtWnzs2/chjdPlArpnwWbmC7D4pGv5hrEcdcACL8vUHvJVQuw4Zur
 XPewUwy21biqPUceFNSCZ3+35UNBEXZqAqIP4ePXJD//pw+QBT/CqR3lUFgmIR93dxhUbAU5/
 lshk4KX/l/ZZrKHoWYizL42+uK7QXAdT+2higzSZIJQgkLMBJ0K6kHEYE9s5vdsl8/C1Qpndp
 XuskaFjGFcVnXuTEYgnc8DQ4f8VL0E1ENX9A339/fH0JuO31oM5GfqSrttwJCtiDfO+RXjSLW
 29sOQYidFuhO3H6YZB0c4CCEMP0Z7hWDddXHgXthhAx5JeJtySqy7bS8ZQ471uH7JgUaI4140
 Y5fH3y6u5difXYAvkZoXNFJXrjA1Rr/tcNXDwgee4Vm6Xw/0/DgL95NESu0JF49+DVvNT6JM8
 UbrYdKFx9w599NU8ACeQ3zXy9vzGu5/Q3Wk/pFzjZSzta0hxOeh+DxjB02oACXXTWkFhgjxci
 hzKbRnpEDGF8+74jyrwQ0g/qYsWv5/T9KPtvjP1tOqOSorRg/2Y2XECnsHEyPfjneFB8DP4Sh
 glHItlMs6X2HySnOGPROHN5zC28tn80raBEQL5sqGBQGj6/CMnehUAznQErifM5XJkcHcNyy6
 gla5sh6kVcnsAmpzjVNTvTFJW692JHezvjmn++nrTC3l9090dUbRcF8F6rOMSNah15qx1M6kM
 H2vRURrLTxV4Fe37GRVWee/5g2jpcAHBnveEPVVhY6jmECDos7wM+ZTuYnwmjbZ/MtaZ8FvWZ
 KYkrPCgEiBcqyYf8XaOYe52dvz94tOmrj7BLgY/3RlcVsC0I4z8sIS61s/wineeG1W5+OLEaP
 vqYBegt9YBWJsaHMJ7EB4CaI6zg4Hk+SGmxQd5tqT0HiCr57CQxrkrtMiiEaF33/P86fe2/XH
 fNNwC9XQe38QU2muEFh+0rGd5V49WY3sLhOzfI0ox2yEcknOYiNIbI0JCy4dhIxCmzWG0+iB0
 vPP0GdW00qHU787K7w8PVhuwRkMYiW6s7dD38R4fHGbxYOSQ/zReVm5WAy5HZtFYccMK+GHOr
 e9EsttBSXoCml0bdwmf+lOgULUZI9grmYtRv6Z78cgxl8d3osGYF+J0sRQ7+14mwLBPqGRPg1
 byOWk=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 09 Aug 2019 17:08:12 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 09 Aug 2019 17:08:09 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci@systeme.lip6.fr
Subject: Re: [Cocci] Make rule depend on comment
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

> If you pull Coccinelle from github, you will be able to write the following.

I am curious how the support will evolve further for scripted SmPL constraints.


> The second scriptcan use ocaml or python as you like.

How do you think about to clarify the following SmPL rule variant?

@addition@
km;
comments tag : script:ocaml ()
 {
 let (_, _, ca) = List.hd tag in
 match ca with
 [] -> false
 | _ -> let xa = String.concat "" ca in
        if Str.string_match (Str.regexp "kmap compat: \(KM_USER[01]\)") xa 2
        then km := make_ident (Str.matched_group 1 xa); true
        else false
 };
expression context;
identifier fn;
@@
 fn(...)@tag
 {
 <+...
(kmap_atomic
|kunmap_atomic
)(context
+, km
 )
 ...+>
 }


int foo()
/* kmap compat: KM_USER0 */
{
void *addr = kmap_atomic(page);
// ...
kunmap_atomic(addr);
}


Can such a data processing approach ever work in the shown direction?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
