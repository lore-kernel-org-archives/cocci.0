Return-Path: <SRS0=BkxN=P7=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53274C282C3
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 03:23:19 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 911AA2085A
	for <cocci@archiver.kernel.org>; Wed, 23 Jan 2019 03:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P0PTBJBC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 911AA2085A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
          by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0N3N38v007933
          ; Wed, 23 Jan 2019 04:23:03 +0100 (CET)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id 2593776E3;
	Wed, 23 Jan 2019 04:23:03 +0100 (CET)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 249C575F1
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 04:23:01 +0100 (CET)
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com
 [IPv6:2607:f8b0:4864:20:0:0:0:632] (may be forged))
 by isis.lip6.fr (8.15.2/lip6) with ESMTP id x0N3MxCd000165
 for <cocci@systeme.lip6.fr>; Wed, 23 Jan 2019 04:22:59 +0100 (CET)
X-pt: isis.lip6.fr
Received: by mail-pl1-x632.google.com with SMTP id w4so413339plz.1
 for <cocci@systeme.lip6.fr>; Tue, 22 Jan 2019 19:22:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:to:from:subject:message-id:date:user-agent:mime-version
 :content-language:content-transfer-encoding;
 bh=ButvpxVaJgUoujJpJkATUdIQjE7MDgtxXE+CCrMNwQE=;
 b=P0PTBJBCHb254nUQ3vbpAqPvsRG/8DI+MwIfixHqmWKaQo6meXfHaq3YdXWBend8oL
 x/xVg12WUyBAE2MYdCuiuv4w3ff1jbZ3YgGllr5zYK/I0aztmo5/YfXVmv2+b5op8jxh
 ANIZlXmwSAi3rz1nW9eRm4AyR5kft2Cc+S4PSDOrFQTogdm44sn5lgiJ6N5pEiy9rTH+
 XMvduLt0tRZnYLCwi3US0NHz/eBDmbIKnh8IymhNPKUmgpbrYC4T7N62mZ2TDr2Yr5XY
 ajpICqgyBlzoagdW0BTvNywpcycEAtvEvfC5YVADSav1l7pZkr7zVWVknHBHo5yWG0GS
 1bvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:to:from:subject:message-id:date
 :user-agent:mime-version:content-language:content-transfer-encoding;
 bh=ButvpxVaJgUoujJpJkATUdIQjE7MDgtxXE+CCrMNwQE=;
 b=LQGDgrau5+qF39S7c7RFCkr8Fn5HfL4cSFKYgH5YMgI3KTgdo7qi02bDvdKfNxOfMf
 R5aBJbOvOtZb31e3l8CpGx+dbJHKo2Vqvvx6Wf1Oh4FMRhugPwjlzF8Z91AOVE5So9eW
 IRnSkmDjCrRqvdvQ9s3+76+JZYAeoLICSlHLDuCWj9RKkDBDa5wC9Qvpc39HNp3knbet
 GLyLPueXtpJloEG3QdgtnSZCqECMWN/CdqW6RrSEvZUZnRawXghRvTGoqb9dBIeLqEyo
 qaCM6XzwcU78hS6ECTm+b9q/C7ZCuLIVYJUbdcGUbmOTh741r1LJbPhoRpz78Acrnt/7
 +DYg==
X-Gm-Message-State: AJcUukeRtxtpCoZu5G00CdomE0baRq2FqVSdgHbCMEeQmq4qFPkEa2S4
 D5ccmAtD0Sc/mSFJMXb5pLymoXIx
X-Google-Smtp-Source: ALg8bN7eSsppn/3d6ZvRvxIlPpu6uVh9cd1mjw+JwN969kW/eH3A2gcj66x8vD8pVRO57NiFRcPAhQ==
X-Received: by 2002:a17:902:3383:: with SMTP id
 b3mr570910plc.170.1548213777892; 
 Tue, 22 Jan 2019 19:22:57 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 k24sm24756162pfj.13.2019.01.22.19.22.56 for <cocci@systeme.lip6.fr>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 22 Jan 2019 19:22:56 -0800 (PST)
To: cocci@systeme.lip6.fr
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <405551ab-2417-dc55-f429-421ae79a5d06@roeck-us.net>
Date: Tue, 22 Jan 2019 19:22:55 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Wed, 23 Jan 2019 04:23:03 +0100 (CET)
X-Greylist: Sender passed SPF test, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [IPv6:2001:660:3302:283c:0:0:0:2]);
 Wed, 23 Jan 2019 04:22:59 +0100 (CET)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78
Subject: [Cocci] matching concatenated preprocessor tokens
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

Hi,

I am trying to match a construct such as

#define func(a,b,c) \
     some_call(a##b, c, NULL)

to replace it with, for example,

#define func(a,b,c) \
    some_other_call(a##b, c)

Is this possible with coccinelle ?
I tried several variants, but I don't seem to be able to match "a##b".

Thanks,
Guenter
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
