Return-Path: <SRS0=BekO=WK=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: *
X-Spam-Status: No, score=1.2 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DF08C32753
	for <cocci@archiver.kernel.org>; Wed, 14 Aug 2019 12:23:15 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39B932084D
	for <cocci@archiver.kernel.org>; Wed, 14 Aug 2019 12:23:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="q37Ffb3Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 39B932084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7ECN0Wa020769;
	Wed, 14 Aug 2019 14:23:01 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id DD6C076C5;
	Wed, 14 Aug 2019 14:23:00 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id DF957768E
 for <cocci@systeme.lip6.fr>; Wed, 14 Aug 2019 14:20:40 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:32d] (may be forged))
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id x7ECKecD006083
 for <cocci@systeme.lip6.fr>; Wed, 14 Aug 2019 14:20:40 +0200 (CEST)
Received: by mail-wm1-x32d.google.com with SMTP id m125so4270938wmm.3
 for <cocci@systeme.lip6.fr>; Wed, 14 Aug 2019 05:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=z7PDsmqgxBW6PvZLG8xYLdy1sfA/Oa3ZAdP99NTWenE=;
 b=q37Ffb3Q5Yt1jtBOrfOAOhWErenMqe93fL10MInRxbEP2oauHQiVX/Lb5eo+QMqAQK
 7SFxd4qFB42GNt+wc/4MtpgVkrNdm3wuXepnS/dxelAUwxp1A6rNGpP423+rAmPqE3t3
 XBM80XbwMlmhnZlADKyChXoz1mIxdekjWUINvVDkYuCkabpKjZDjYvWqi9x261b+VWmL
 U9D/ZVUoOH5CmvWzq8q/AbziZu7xfIjaq6lYdMyrscxkQoaTTCSJC9nugNLEYkh5qTki
 AtH3UCjXe8Ys4GvGQzfk0aacLH2x5QattWrSuaS4lL9aVeUY5LjK6BbV/LgxeocIyUP8
 7uww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=z7PDsmqgxBW6PvZLG8xYLdy1sfA/Oa3ZAdP99NTWenE=;
 b=Eey6lI7B0mDdysSSAJ496nmpI5Bj4om0A55FTgaGjBofShEV41PkcOa7gu0z9PTGwY
 Ssh2NFzvd2MYwkxLqEgCgF28WyXYbZyf500UxBsbnyx6TCOFSYWW75A+ipL678w4RsOa
 p54zpLkNOI2o70ERM0Gr/y9JLl7VuOJuW8JAWkVA5yU7S6rvf5T1bUtKTzUmP9pWo+WQ
 pV7CAXGCTaZbMz/FuQtLg0K9vx+Rb38UOv80ZTJhnr6hIR7+F3jj0YOmghTnvndkkZ6k
 S/BmbE2UzgBzIWT/Vu7P9UPlf/s42adS+iL8P4fDEFdLtpzSuUr48SwpgmBW8MStOdD6
 XHiA==
X-Gm-Message-State: APjAAAVU2MdW50zqin5bYwR9RSa+eNJlH8B0VHLKlYJU/6224Yq8UG3f
 DioEfNxDEUresyMHENyaw1XSgQ==
X-Google-Smtp-Source: APXvYqy6Q/0HzA3PVySlpkjNw9NKaaUg+PfpbY5Q7Cfxof7OoVYlEY3Gh3xqm/5uPXFrXP/Mscu19w==
X-Received: by 2002:a1c:9a46:: with SMTP id c67mr8294185wme.152.1565785239762; 
 Wed, 14 Aug 2019 05:20:39 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:210:e8f7:125b:61e9:733d])
 by smtp.gmail.com with ESMTPSA id r123sm3340862wme.7.2019.08.14.05.20.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Aug 2019 05:20:39 -0700 (PDT)
Date: Wed, 14 Aug 2019 13:20:34 +0100
From: Matthias Maennich <maennich@google.com>
To: Markus Elfring <Markus.Elfring@web.de>
Message-ID: <20190814122034.GA117054@google.com>
References: <20190813121733.52480-9-maennich@google.com>
 <d3c852b2-0e41-1a7e-2f98-d8fd23cb8c1a@web.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <d3c852b2-0e41-1a7e-2f98-d8fd23cb8c1a@web.de>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 14 Aug 2019 14:23:01 +0200 (CEST)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 14 Aug 2019 14:20:40 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
X-Mailman-Approved-At: Wed, 14 Aug 2019 14:22:58 +0200
Cc: Kate Stewart <kstewart@linuxfoundation.org>, linux-m68k@vger.kernel.org,
        Oliver Neukum <oneukum@suse.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        usb-storage@lists.one-eyed-alien.net, kernel-janitors@vger.kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Sam Ravnborg <sam@ravnborg.org>, cocci@systeme.lip6.fr,
        linux-arch@vger.kernel.org, linux-scsi@vger.kernel.org, x86@kernel.org,
        Lucas De Marchi <lucas.de.marchi@gmail.com>,
        Ingo Molnar <mingo@redhat.com>, Alan Stern <stern@rowland.harvard.edu>,
        Geert Uytterhoeven <geert@linux-m68k.org>, kernel-team@android.com,
        Sandeep Patil <sspatil@google.com>, Arnd Bergmann <arnd@arndb.de>,
        linux-kbuild@vger.kernel.org,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Nicolas Palix <nicolas.palix@imag.fr>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Martijn Coenen <maco@android.com>,
        Michal Marek <michal.lkml@markovi.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, Nicolas Ferre <nicolas.ferre@microchip.com>,
        Martijn Coenen <maco@google.com>, Jessica Yu <jeyu@kernel.org>,
        "David S. Miller" <davem@davemloft.net>, linux-modules@vger.kernel.org
Subject: Re: [Cocci] [v2 08/10] scripts: Coccinelle script for namespace
	dependencies
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: cocci-bounces@systeme.lip6.fr
Errors-To: cocci-bounces@systeme.lip6.fr

On Wed, Aug 14, 2019 at 02:00:23PM +0200, Markus Elfring wrote:
>+# This script requires at least spatch
>+# version 1.0.4.
>
>How do you think about to avoid the duplicate specification of this identification?
>

That is a good idea. I will reduce the patch to

+# This script requires a minimum spatch version.
+SPATCH_REQ_VERSION="1.0.4"

and use $SPATCH_REQ_VERSION when diagnosing this issue further down.

Cheers,
Matthias
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
