Return-Path: <SRS0=BYw3=AD=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC880C433E0
	for <cocci@archiver.kernel.org>; Mon, 22 Jun 2020 08:04:14 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 276EB2082F
	for <cocci@archiver.kernel.org>; Mon, 22 Jun 2020 08:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="B05aJafb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 276EB2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05M83pX0028677;
	Mon, 22 Jun 2020 10:03:51 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id B2F8D7773;
	Mon, 22 Jun 2020 10:03:51 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id E86493BAB
 for <cocci@systeme.lip6.fr>; Mon, 22 Jun 2020 10:03:48 +0200 (CEST)
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com
 [IPv6:2a00:1450:4864:20:0:0:0:344])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05M83ljQ011347
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 22 Jun 2020 10:03:47 +0200 (CEST)
Received: by mail-wm1-x344.google.com with SMTP id f18so2199404wml.3
 for <cocci@systeme.lip6.fr>; Mon, 22 Jun 2020 01:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to;
 bh=ywxvkE6q0cbrbXTJPKV3+AgmecGjcEiMLhxzggDoG6o=;
 b=B05aJafbS6ANDvwzCVLuomo34ddofnlUEe/dzFaae8H9n6l2rKJI6IrZm/zCfUTcG4
 OCLkNzJtVemG5dLrAysL/t/jVfGhLyhQTy382vmEjbizP4S+UajTShxqcx/D3Ekis/sx
 xjlHvyulEEeWN0OSkG4fYkV3K3HMQaRIBA0DdfA8Kz931INPhBaszFpcn02RhVs+MHbT
 UejiUNIdu5uDqXrb0p/vZjjA1o51htumX5Jv2W2cDFrlcJUf6NNfdCjp1NGj6emOae9i
 q4hwpXDA6BEg0uXpq9feIG9z6QgYtR0NfoQn0C5RgzJRgi4p8FemcfwKSmYpVKug8pAe
 Ky5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ywxvkE6q0cbrbXTJPKV3+AgmecGjcEiMLhxzggDoG6o=;
 b=Y84fuhEt0O7+7ItYS06/xM6ags6FZ8OaJSfmvU7NPbH8LvMOyx/hN/X2qBeyGkfAkx
 kUwYnioL8Yk6bTJFZF9GUlrn04KEN5+vaUqajVzVRFzPRRyvcZBHLwANd8bU/6a/TjsZ
 H/v/uSsiuz3AzQRVmTgJ/7rDNUK/CtvcTdCQxzus5aNAzz7uLamcOYz9LbkqU9/gE35a
 uBScn/ALu13wARXDbUlgjiV6SDnYY2KLq6VpBPTBufzBYZ4u0u4U6CiMjvgPhZmsek/P
 EONNYlMnQPH4+F+3QS59HDmWEfe7TC+O0BxjRA9HbKgg5CE6eamTro1+QXgn89sfZKBG
 BO6g==
X-Gm-Message-State: AOAM533+BFe1gytS0UgRbalMzrLQ/foelrDvyuUHoenNajIFNNodtws3
 7ie0ejiYVUnyvIKvgW7nrYXltw==
X-Google-Smtp-Source: ABdhPJyHIKw9WEzh6N3BXcgx11UwI1xf/377zz0nUKvGGyqiZiH4zAvWq3AiOlscznnhY/lIRP2Cng==
X-Received: by 2002:a1c:2c45:: with SMTP id s66mr17990066wms.40.1592813026778; 
 Mon, 22 Jun 2020 01:03:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:d:110:673c:7143:200f:54b7])
 by smtp.gmail.com with ESMTPSA id k16sm16791759wrp.66.2020.06.22.01.03.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2020 01:03:46 -0700 (PDT)
Date: Mon, 22 Jun 2020 10:03:45 +0200
From: Matthias Maennich <maennich@google.com>
To: Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <20200622080345.GD260206@google.com>
References: <20200604164145.173925-1-maennich@google.com>
 <alpine.DEB.2.21.2006042130080.2577@hadrien>
 <bf757b9d-6a67-598b-ed6e-7ee24464abfa@linuxfoundation.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <bf757b9d-6a67-598b-ed6e-7ee24464abfa@linuxfoundation.org>
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 22 Jun 2020 10:03:52 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Mon, 22 Jun 2020 10:03:47 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        YueHaibing <yuehaibing@huawei.com>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org, jeyu@kernel.org, kernel-team@android.com,
        cocci@systeme.lip6.fr
Subject: Re: [Cocci] [PATCH] scripts: add dummy report mode to
	add_namespace.cocci
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

On Thu, Jun 04, 2020 at 02:39:18PM -0600, Shuah Khan wrote:
>On 6/4/20 1:31 PM, Julia Lawall wrote:
>>
>>
>>On Thu, 4 Jun 2020, Matthias Maennich wrote:
>>
>>>When running `make coccicheck` in report mode using the
>>>add_namespace.cocci file, it will fail for files that contain
>>>MODULE_LICENSE. Those match the replacement precondition, but spatch
>>>errors out as virtual.ns is not set.
>>>
>>>In order to fix that, add the virtual rule nsdeps and only do search and
>>>replace if that rule has been explicitly requested.
>>>
>>>In order to make spatch happy in report mode, we also need a dummy rule,
>>>as otherwise it errors out with "No rules apply". Using a script:python
>>>rule appears unrelated and odd, but this is the shortest I could come up
>>>with.
>>>
>>>Adjust scripts/nsdeps accordingly to set the nsdeps rule when run trough
>>>`make nsdeps`.
>>>
>>>Suggested-by: Julia Lawall <julia.lawall@inria.fr>
>>>Fixes: c7c4e29fb5a4 ("scripts: add_namespace: Fix coccicheck failed")
>>>Cc: YueHaibing <yuehaibing@huawei.com>
>>>Cc: jeyu@kernel.org
>>>Cc: cocci@systeme.lip6.fr
>>>Cc: stable@vger.kernel.org
>>>Signed-off-by: Matthias Maennich <maennich@google.com>
>>
>>Acked-by: Julia Lawall <julia.lawall@inria.fr>
>>
>>Shuah reported the problem to me, so you could add
>>
>>Reported-by: Shuah Khan <skhan@linuxfoundation.org>
>>
>
>Very cool. No errors with this patch. Thanks for fixing it
>quickly.

I am happy I could fix that and thanks for confirming. I assume your
Tested-by could be added?

Is somebody willing to take this patch through their tree?

Cheers,
Matthias

>
>thanks,
>-- Shuah
>
>
>
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
