Return-Path: <SRS0=dAPZ=ZA=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8019FA372C
	for <cocci@archiver.kernel.org>; Fri,  8 Nov 2019 13:05:45 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC6E4206A3
	for <cocci@archiver.kernel.org>; Fri,  8 Nov 2019 13:05:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=web.de header.i=@web.de header.b="arW8tKLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC6E4206A3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=web.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA8D5Oq9017254;
	Fri, 8 Nov 2019 14:05:24 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 8BCF377D0;
	Fri,  8 Nov 2019 14:05:24 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 2E94877C6
 for <cocci@systeme.lip6.fr>; Fri,  8 Nov 2019 14:05:23 +0100 (CET)
Received: from mout.web.de (mout.web.de [212.227.17.12])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id xA8D5Mp6021396;
 Fri, 8 Nov 2019 14:05:22 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
 s=dbaedf251592; t=1573218321;
 bh=HS+dWRPKtjyQgrg83Af43m55+PzVKF39pZtQuZ5mWc8=;
 h=X-UI-Sender-Class:Subject:To:Cc:References:From:Date:In-Reply-To;
 b=arW8tKLzaMoMQHDcg4ln+1O0nWgiTPSpa5pG9ob0Qy0kPptqW1fsjfyoOJdkBV+pj
 wNMFEHPZRHvwlBmnCsCs7c8b405LwIgf/wmSbWo0jzhCxBsrL1vaP5lifOvSMc3Klq
 Nev1I7RD2oPWLIgpKGzfDiAqr/F9lOOJWHpnlzWI=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.1.2] ([78.49.72.105]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0MQvsg-1iLoBL2VjS-00UJj3; Fri, 08
 Nov 2019 14:05:21 +0100
To: Julia Lawall <julia.lawall@lip6.fr>
References: <bfd990c8-1c1d-a6ee-7b05-e9f80160712b@web.de>
 <alpine.DEB.2.21.1911081350350.2465@hadrien>
From: Markus Elfring <Markus.Elfring@web.de>
Autocrypt: addr=Markus.Elfring@web.de; prefer-encrypt=mutual; keydata=
 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 FEE=
Message-ID: <9809f7a9-3a61-c926-2c81-eb31be07394a@web.de>
Date: Fri, 8 Nov 2019 14:05:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <alpine.DEB.2.21.1911081350350.2465@hadrien>
Content-Language: en-US
X-Provags-ID: V03:K1:iVhLTD8IYGaoSQMioIOfCf0irtHLsh9wb/zsuFRTKzMmox9JzLL
 CxGD0Vrdpw93/wrtRyR012rOaKrupzOXOkx3Z7BwO0j2BzxNmXF8dL07mPCDDWd8sHbWkeO
 yBx/5XOze7D8gffPrP9aUOi74Xk+XD4eBsRod7T5Rlrcc7lRmMbIx/r65WRXSGquUSsIFiY
 Sh6IGrsGZc+1+SqjqWLeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:CbYSX+trFx4=:wvJpM+hvQHCJefNm44oasD
 UeDmhIJ+HR/EE2jrji5Oz00XkcUiWdCsmyeWomeSmLEQ3WC8MAcnmE+Rd19z++PqAGI62Z5l+
 MufWkP4E0TDLqH+CbZSxsgMA+KReD18O3bvb7mDErHP1DkxEEy43rTdDyjBLNiHXY1eBFLUk6
 hV+SOq2UtR1oUXNcCQrRXFv+Duyf1qCd7n3MGcAprv0XPOVCB5/oqPOSDklbtUFJfX3VQvxf3
 Hy1Q/qenpRzirLKgxcYqNnJMmviqRF3n0MoSWm7MtB1rXcKHqD9TFR3GBXnGp46l3K6x/iqr+
 vIc+vToJwI1Qaf1NZrSmWK5qwMemiO+2Il5UOIelwwTB9OiLbYZ06Of1fEUyYeDxujsi60RS8
 hF83lIeb/aE92axYO7xYrxeGrYobGrr0Y+jbmHanL7jrcRVX9Rs8IXleATexwx+zxwlTTPLAJ
 p0Q/HfFYIgylYvzPuFnm/Oq0gkSJ+bEy1H+8AKET4Cnu6/PLAfK0UpyRBNQKF/32iL0T6c5F4
 ulXVCuH8UbgPH2a7GoaxRTRX4Spo6bqF9fI/gLjbPmP/7V9WiDonNx1SS1RRkCqNQtmulNlhX
 aiQLVVFMB+P5sODwQoNoGmbgVZxHis10y7cLTJBXWjGBNuNdNBahTGD7WoBdHJTXRDeQzjoRb
 5/x6IO1kucq64C7qRWc/ikkAjQTQiK0ceOnFQZlU99GUbPZEdmZ4+ZxrGSGFCjxkRAmeHDuFY
 kzB+JxBTx3s6oyPOEwC4RwKMbdSonsu4fDLXTjOJAWxtCTTzoC/MDOt7gp65HhoQRCTPKf9Yk
 l5KhRB+6XqjfYdS7zAcDUgWO5SpxVOuFpRmg2Ji7aouyD5E9eL43ngXixyF40oP9tVbWbsy7x
 Tz7N7l0k0pbrgWcUGtlzkv49bQnvb/vAzzJIq7eAsFb4m2566Ys7eIKc5DbSjj+gJCQoMiwvl
 t3Ce5UfuwljotZyD3Gqr9Cwm0qY+GhhEGozQCz6nB/s3f8Nn430rRmHnizI1PFuQkRki4AD7k
 PHrYYkUN81Ywb23J9g2/5syqsagm1JBQ3uM9N3kI+5ap/ZrX16g25OyWGfsWmP+ruW9Pg2grD
 zO54Od1/bRlgwEAIn6sMEOX4Q3BmNfwOIv+7rVZ+/4fsty8t2ZYYbQ9oJ4WighJZ+0SkbITwU
 jXxfgh+y2v/qAQfx4jLZkTG5cujxIrhVLenjx9MkcTLSltsM6x/OmLVt9fXsmlLNrC0i0ZEGA
 Y927Pde4vrjbuMZVrcRw0sv3aSGPxoTVKqCFCT+TH3xECzgHfRkrFtkEZdug=
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Fri, 08 Nov 2019 14:05:25 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Fri, 08 Nov 2019 14:05:22 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Coccinelle <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Fixing SmPL scripts for data output according to
 structured file formats
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

> make coccicheck uses --no-show-diff at the approrpiate place so that the *
> have no effect if the context option is not chosen.

Thanks for your reminder on this command option.

How do you think about to look at possibilities around the redirection of output
to files so that diff hunks from matched source code fragments (according to
SmPL asterisk functionality) could be directly used from corresponding variables?

Regards,
Markus
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
