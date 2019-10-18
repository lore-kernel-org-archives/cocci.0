Return-Path: <SRS0=N+LH=YL=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C4EDCA9EA1
	for <cocci@archiver.kernel.org>; Fri, 18 Oct 2019 12:54:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA5CE222C2
	for <cocci@archiver.kernel.org>; Fri, 18 Oct 2019 12:54:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="h5bIjsVh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA5CE222C2
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9ICsRZo013453;
	Fri, 18 Oct 2019 14:54:27 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B416E77B8;
	Fri, 18 Oct 2019 14:54:27 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id B51FE77B4
 for <cocci@systeme.lip6.fr>; Fri, 18 Oct 2019 14:54:26 +0200 (CEST)
Received: from mout.web.de (mout.web.de [212.227.15.3])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x9ICsQhx020177;
 Fri, 18 Oct 2019 14:54:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1571403265;
 bh=X7BQMgI/77l+L2i1ihC58sug2j+k84YzHQ8zd/lQ5Wk=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=h5bIjsVhNglu8Dly7oaDaxGD2ASVGwBlTuNbLg0qx9oFTSF/VlDwTXLA4bFMC96IU
 H4PgEpQEvk+c/MUDLOwDrR0kgkTu4i1W5ARMQms/kBVOS+uyNlVK0MMYy0CXq/M/v5
 uvw++YYVkNyIznnOFtGbFLwiO0ROo+GEz6cdsPco=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.48.164.145]) by smtp.web.de (mrweb004
 [213.165.67.108]) with ESMTPSA (Nemesis) id 0MfTx5-1ifa1q3AgV-00P8WY; Fri, 18
 Oct 2019 14:54:25 +0200
To: Julia Lawall <julia.lawall@lip6.fr>
References: <24130ec6-4a20-7be4-755f-a6dfffcb6c97@web.de>
 <alpine.DEB.2.21.1910101509370.2305@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <45be389f-23f9-cbff-fa5f-8ad111124f94@web.de>
Date: Fri, 18 Oct 2019 14:54:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1910101509370.2305@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:eiuZP9h0Kwl9Cx1xAweHnrzIZS89FKPlWvQ30PjtEwiN9n/2L0w
 IiiIQdyR6Bf7/z5SGcsijsCK5AZSFJ1ZzTZVcY0EU71TXgbJfgdkw0eqSf6B5TcZYOh5RT4
 UKHHSLY8iVkmeHz6oK7zH7NYRxOfT2+PpTetCitg9pn2Q+y9hdPmm3xqNpoCQfxpQjrqYwo
 QL9qCe2+Oy9YEuC+tTDjw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:F4eBQQ03j1c=:XFJ5kGyCMaeGw9frbvF1tZ
 iDxwrY7Nx5qESrw+xWB6VtTLyUUjhU/RKhuQPgYo6uVeswuinC4VPhmia0bsE7acQhpE8LtSC
 LYYQX9vd1395ryS43gYKQ3S/d69DXxFb7Z85JQmvIn6Pyh22tfP50N4GedFMBumibf1CQY5wM
 q+vPhjBvhkcNkZ5t+cl5cplIguIL9eQViMd97Hk3jDXHPpCUIRKqJHVGCeK4l5+X1opefWWZU
 ADtpx+oP4jDJAoGgDljkgIwx+BhmIgaN4ZyJP7GFGi10vvRw5E2xcqVtDIpV1ojvlzC8pHPvW
 hKKZJdKdIIrWO4ta5yGC3Rvp9EzI05PawtIqWV4eA/Vn7Fo66hDID/KLnLE0AoqgzH2s0aGDL
 hhcbpoR7aBFfbNoe+VLgzXRA46NXYFSbjqZdmrG17PMdoMmhE2r8ibfKDE7xd2JkOHKfmnzxw
 zoFejAFZahxXCUUDgiau1su672gc9dtq3YEJf0WUMp8iucJ2F1WbQopxcA3VY3lzN0yQiLGSh
 5lqUkqoKRoxEv/F2oEoPdCvdSBzrk6eBTkxNzaOaEI1UdAHZQLbLg6UiH1ZIf/PZ2lQMBNVQh
 UB7334/YbtHbMpZhgG3C8y+M1LN0X2F9MsKiQa//FXPijae4tKJbyvAybmY+arKTNaA41zYyP
 DZycx20rdJWyhcdlcgZJgMUnFt+vqdLbrMEhIgN/5K74unyoOOn3JdpFSI6gXKpkEh1eMsBWr
 3YlYHclAWx5UyJ6tgIYuvy8jE/zaCC6A109wowaUTVb39IaP7pN7VFb6b/3kxUENhgrVPPXD1
 TvnkNEM0FLXcXlxOmUBWoXU+GYkt8mgR/7V+rh99W+ngycKtigthtaMW5eZ+wtMOs7nKNXKlc
 QDIxnwwwMprq+2bij0tk8S0bT6VV4X4VbPLPei/EFxZSrqr/AGYyuvBfn0z/fOW4+f6AK8yvB
 AilWMX7BW6IcnrpvwEOwJbatOZKtKfQNH/74Xc1j5rVv44Bu3zoC3iENb5gBwEp8/cjzu9ClL
 B9HSoqTBZrM2HVBzzqJ0n+7JkENi7hIpAcOTX9GwqhLAzNXZbqU7TnaPM6/atuCrAH9SNklZv
 sgugfIVtnsG5fJRIAWDiZeBhv4hJqWQ2casJduN9V8zEUKrWZRm/CDoFRNgPNDP5Bt3UsuaSH
 D0hs9F9feiWYuahdUqZ3fJuUXeAGYVGyeIRPqos/K/dxo5LB7F8pdkTKgbj9IvqC6EZsac86w
 JXZ6AP3UndoUGUGjYRKesTlClaDuJfnR7yX0Za+xgKIKA5I3pQQp0guaMbDs=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 18 Oct 2019 14:54:28 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 18 Oct 2019 14:54:26 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Software analysis with SmPL around unchecked pointer
 function calls
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

> Why not just

@display@
expression x, y;
@@
*y = (x)(...);
 ... when != y


It seems that such a source code search approach has got a high probability
for false positives, doesn't it?
Thus I am trying again to restrict it in reasonable ways.

Which would be a simple way to find only calls of functions
which have got a pointer return type?

Do any function signatures need to be taken into account
if you would not like to store a long function name list copy?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
