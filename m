Return-Path: <SRS0=Yxto=OO=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07879C04EB9
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 19:12:25 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95E6820850
	for <cocci@archiver.kernel.org>; Wed,  5 Dec 2018 19:12:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="Grrkf2xT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95E6820850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB5JCAWO027720
          ; Wed, 5 Dec 2018 20:12:10 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 4957176DA;
	Wed,  5 Dec 2018 20:12:10 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 8505976D4
 for <cocci@systeme.lip6.fr>; Wed,  5 Dec 2018 20:12:08 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id wB5JC0HX010609
 for <cocci@systeme.lip6.fr>; Wed, 5 Dec 2018 20:12:00 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 8924620850
 for <cocci@systeme.lip6.fr>; Wed,  5 Dec 2018 19:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1544037119;
 bh=fpK/0Tp6GNvv4sD5iwVmHoSOn80YboYTO/PoJqSC36g=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Grrkf2xTAGlBM2+a3Kii+nlM5x9rmw5c49MM+PetTK829QSII1H9pLQmfzuz2zj9J
 KDxL2RpaEgbd7pLS48wKpOeSKBGWyNaDiHQyshdAcdIb1s9dgyUDFwr8meeEOJT6+f
 ZxVBkIjqcJ2DYmuHAtRnTgrX6CJhOmNPpYACYTtc=
Received: by mail-oi1-f169.google.com with SMTP id x23so18528505oix.3
 for <cocci@systeme.lip6.fr>; Wed, 05 Dec 2018 11:11:59 -0800 (PST)
X-Gm-Message-State: AA+aEWbY6TtmlGSRQOtJLgjajPQFG7Gn6mAOSjOz+WXYQZ52FZ6iuGJq
 xEPIAAL4sNhJh3yQ+cZT8NdJpygAbRp/vbabqJ8=
X-Google-Smtp-Source: AFSGD/X/kcRELYE4FDCgNMQZ6e3s1Jjv0uQvV1ZthMhCtHkA+ZSCr7rX5dVO9NuAToSVjoZtdipIYBCxc+obj/TOsYM=
X-Received: by 2002:aca:5117:: with SMTP id f23mr16257979oib.72.1544037118888; 
 Wed, 05 Dec 2018 11:11:58 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXVLMv-5_u1uOq6re+1O3vADsrTK0+J3Fat-XN4_2DEp4w@mail.gmail.com>
 <alpine.DEB.2.21.1811151327420.2372@hadrien>
 <CAOZdJXWD0L4Qwh2raJLF25Ax0=DR06vhfGWhpQVf804YQJ5jeA@mail.gmail.com>
 <alpine.DEB.2.21.1812042124260.2383@hadrien>
 <CAOZdJXXMTrXXEKta-M0uYq3EpjVaSz2++OT1GOB5HYmx5h_TgA@mail.gmail.com>
 <alpine.DEB.2.21.1812050732260.2670@hadrien>
 <CAOZdJXX+0cVy0zC7xVgf2EE-YrP+qU_6QWJA_uhhiCqhbgAD7A@mail.gmail.com>
In-Reply-To: <CAOZdJXX+0cVy0zC7xVgf2EE-YrP+qU_6QWJA_uhhiCqhbgAD7A@mail.gmail.com>
From: Timur Tabi <timur@kernel.org>
Date: Wed, 5 Dec 2018 13:11:21 -0600
X-Gmail-Original-Message-ID: <CAOZdJXUxWV+v5UanQXRVLpOJbxA27a_zitCeUdW4uJaqX0jWgQ@mail.gmail.com>
Message-ID: <CAOZdJXUxWV+v5UanQXRVLpOJbxA27a_zitCeUdW4uJaqX0jWgQ@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 05 Dec 2018 20:12:11 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Wed, 05 Dec 2018 20:12:00 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Can the current function name be passed to a Python
	snippet?
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

On Wed, Dec 5, 2018 at 11:57 AM Timur Tabi <timur@kernel.org> wrote:
>
> @script:python s@
> c << r.c;
> c2;
> p1 << r.p1;
> @@
> import re
>
> print p1
>
> But that gave me this error:
>
> warning: r: metavariable p1 not used in the - or

Never mind, I now understand how the @p1 is supposed to be used.  I
have it working now.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
