Return-Path: <SRS0=8Il1=QE=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A4BAC282CD
	for <cocci@archiver.kernel.org>; Mon, 28 Jan 2019 21:52:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB3522148E
	for <cocci@archiver.kernel.org>; Mon, 28 Jan 2019 21:52:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="1GnI3mfK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB3522148E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0SLorGq000767
          ; Mon, 28 Jan 2019 22:50:53 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 64B7876EB;
	Mon, 28 Jan 2019 22:50:53 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 4524576CB
 for <cocci@systeme.lip6.fr>; Mon, 28 Jan 2019 22:50:51 +0100 (CET)
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0SLoncd025302
 for <cocci@systeme.lip6.fr>; Mon, 28 Jan 2019 22:50:49 +0100 (CET)
X-pt: isis.lip6.fr
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 960872148E
 for <cocci@systeme.lip6.fr>; Mon, 28 Jan 2019 21:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1548712247;
 bh=YCL0mJ/DIN1VMwlbbe6vhMx+sweVNuGfm6F5MrQ5OHA=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=1GnI3mfKqvYHV4zi7GYtIfvIkoKlIXrI2ykNiX78lWZt0UiKR/WsJ2Y8DStCHv53Q
 7GDVravm/wZ/ZM0vjMpC+AeiqgJM1iUzViCJ56AObkLoKPNRfJxRq9burneDlO3nMG
 avCAoXJMLVFYdAFcK8dkFJQdPfaurYVwuCKdLVO8=
Received: by mail-ot1-f48.google.com with SMTP id u16so16074764otk.8
 for <cocci@systeme.lip6.fr>; Mon, 28 Jan 2019 13:50:47 -0800 (PST)
X-Gm-Message-State: AJcUukcv0K/OjMXVtwkVlwb948ead2itaTk1cs+aIVPRkQyAXtDlRDXt
 NIzZvGs/vziYul9NaTenfO2DvpQ4ut0J0OfDSe8=
X-Google-Smtp-Source: ALg8bN7uswMhcEhNnl5BNRs6Zu6+UfSYYATA8HVsKAFrenUYVniNXEErzP9F/k7fVMnagJHumcW7tU7mgYIjPJ8aXYs=
X-Received: by 2002:a9d:491e:: with SMTP id e30mr18363124otf.131.1548712246939; 
 Mon, 28 Jan 2019 13:50:46 -0800 (PST)
MIME-Version: 1.0
References: <CAOZdJXUg+1M-ii-tEtYdjDyXuEUYbmHYSf-EqfzFh+OtuWLP7A@mail.gmail.com>
 <alpine.DEB.2.21.1901242119310.2415@hadrien>
In-Reply-To: <alpine.DEB.2.21.1901242119310.2415@hadrien>
From: Timur Tabi <timur@kernel.org>
Date: Mon, 28 Jan 2019 15:50:10 -0600
X-Gmail-Original-Message-ID: <CAOZdJXXnehJLkM1aV8PMxqKmPuW2n-tf0B+UXywhLTTD_Sj=PA@mail.gmail.com>
Message-ID: <CAOZdJXXnehJLkM1aV8PMxqKmPuW2n-tf0B+UXywhLTTD_Sj=PA@mail.gmail.com>
To: Julia Lawall <julia.lawall@lip6.fr>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 28 Jan 2019 22:50:53 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 28 Jan 2019 22:50:49 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: cocci <cocci@systeme.lip6.fr>
Subject: Re: [Cocci] Blank space in front of function definition name
	confuses spatch
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

On Thu, Jan 24, 2019 at 2:20 PM Julia Lawall <julia.lawall@lip6.fr> wrote:
>
> This should be fixed in the version on github.  Please try again.

Yes, it works, thanks.
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
