Return-Path: <SRS0=AA88=74=systeme.lip6.fr=cocci-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8ACFCC433E0
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2020 18:35:38 +0000 (UTC)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB25C206F1
	for <cocci@archiver.kernel.org>; Mon, 15 Jun 2020 18:35:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB25C206F1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=linux.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=cocci-bounces@systeme.lip6.fr
Received: from systeme.lip6.fr (systeme.lip6.fr [132.227.104.7])
	by isis.lip6.fr (8.15.2/8.15.2) with ESMTP id 05FIZPq0016542;
	Mon, 15 Jun 2020 20:35:25 +0200 (CEST)
Received: from systeme.lip6.fr (systeme.lip6.fr [127.0.0.1])
	by systeme.lip6.fr (Postfix) with ESMTP id EDCFA7577;
	Mon, 15 Jun 2020 20:35:24 +0200 (CEST)
Received: from isis.lip6.fr (isis.lip6.fr [132.227.60.2])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by systeme.lip6.fr (Postfix) with ESMTPS id 514E3402B
 for <cocci@systeme.lip6.fr>; Mon, 15 Jun 2020 20:35:23 +0200 (CEST)
Received: from mail-lj1-f193.google.com (mail-lj1-f193.google.com
 [209.85.208.193])
 by isis.lip6.fr (8.15.2/8.15.2) with ESMTPS id 05FIZMFS028874
 (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128 verify=OK)
 for <cocci@systeme.lip6.fr>; Mon, 15 Jun 2020 20:35:22 +0200 (CEST)
Received: by mail-lj1-f193.google.com with SMTP id i3so15888095ljg.3
 for <cocci@systeme.lip6.fr>; Mon, 15 Jun 2020 11:35:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:autocrypt
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=XYZnCuTnMeODEbt1oiAtKlVlzjooe69rwI+J7FRfpms=;
 b=nEHGsFhJiMW03XbD6cprzsgny8I8ToL5pVlVwE1W1FIEsBc5ljPo4M0TpiXr9el4R/
 SarHtOU4SHVBmZYqkdpRlQDxP+xkteGPk41UPBzS9dkOcRFYcJT/BTL/WCecmn/oBC0L
 UnffUtz9ExFneZJkFXCVsxbI8dv0U0VUhH9g99tYQLgVAQUB41KOmduOYZ0KdRrw3w/Z
 CQeEq3uOfub5ZslssPrX5L9ve//Yk+iIzSKA1mbaKCPZjCeSDDNb3UU4KQvmQDAvQX6U
 G7OG2xuqWhSu74cJHpKp3RlpRGo4QOpmLmYpp0aPsV3zja07fA1KMVj/R8D0Qd40odQj
 2nFw==
X-Gm-Message-State: AOAM530/oYf9inCsaigs18aEGjWrs783PPV/9SPRcnWrfnxS/SKQqjvi
 WUJTOKQnb2Zkb1dLBBmqc54=
X-Google-Smtp-Source: ABdhPJxRmYTtDovjnGO1j0MjpX/FkQV4NMGA/rWY9IsjWVU0PrxehgerpX9xU8BMZQA/yaNJYz9kpA==
X-Received: by 2002:a2e:9b4a:: with SMTP id o10mr13616475ljj.278.1592246121876; 
 Mon, 15 Jun 2020 11:35:21 -0700 (PDT)
Received: from [10.68.32.192] (broadband-37-110-38-130.ip.moscow.rt.ru.
 [37.110.38.130])
 by smtp.gmail.com with ESMTPSA id g22sm3358696lfb.43.2020.06.15.11.35.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 15 Jun 2020 11:35:21 -0700 (PDT)
To: Kees Cook <keescook@chromium.org>
References: <20200615102045.4558-1-efremov@linux.com>
 <202006151123.3C2CB7782@keescook>
From: Denis Efremov <efremov@linux.com>
Autocrypt: addr=efremov@linux.com; keydata=
 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
Message-ID: <a28543e5-4f93-bf16-930b-42d7b24ab902@linux.com>
Date: Mon, 15 Jun 2020 21:35:20 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <202006151123.3C2CB7782@keescook>
Content-Language: en-US
X-Greylist: Sender IP whitelisted, Sender e-mail whitelisted, not delayed by milter-greylist-4.4.3 (isis.lip6.fr [132.227.60.2]); Mon, 15 Jun 2020 20:35:25 +0200 (CEST)
X-Greylist: Sender DNS name whitelisted, not delayed by milter-greylist-4.4.3
 (isis.lip6.fr [132.227.60.2]); Mon, 15 Jun 2020 20:35:22 +0200 (CEST)
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
X-Scanned-By: MIMEDefang 2.78 on 132.227.60.2
Cc: Julia Lawall <Julia.Lawall@lip6.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
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



On 6/15/20 9:23 PM, Kees Cook wrote:
> On Mon, Jun 15, 2020 at 01:20:45PM +0300, Denis Efremov wrote:
>> Detect an opencoded expression that is used before or after
>> array_size()/array3_size()/struct_size() to compute the same size.
>>
>> Cc: Kees Cook <keescook@chromium.org>
>> Signed-off-by: Denis Efremov <efremov@linux.com>
> 
> Oh, very cool! How much does this find currently?
> 

opencoded expression before the function call:
./drivers/net/ethernet/cavium/liquidio/request_manager.c:98:34-59: WARNING: array_size is used down the code (line 103) to compute the same size
./drivers/media/test-drivers/vivid/vivid-core.c:1120:26-34: WARNING: array_size is used down the code (line 1122) to compute the same size
./drivers/scsi/megaraid/megaraid_sas_fusion.c:5184:11-31: WARNING: array_size is used down the code (line 5191) to compute the same size
./drivers/scsi/megaraid/megaraid_sas_fusion.c:5200:2-37: WARNING: array_size is used down the code (line 5207) to compute the same size
./fs/cifs/misc.c:853:17-39: WARNING: array_size is used down the code (line 858) to compute the same size
./fs/cifs/misc.c:863:17-38: WARNING: array_size is used down the code (line 868) to compute the same size
./drivers/scsi/fnic/fnic_trace.c:562:25-48: WARNING: array_size is used down the code (line 566) to compute the same size

opencoded expression after the function call:
./net/ethtool/ioctl.c:1976:55-66: WARNING: array_size is already used (line 1957) to compute the same size
./net/ethtool/ioctl.c:1921:55-66: WARNING: array_size is already used (line 1909) to compute the same size
./drivers/net/ethernet/cavium/liquidio/request_manager.c:111:29-54: WARNING: array_size is already used (line 103) to compute the same size
./drivers/staging/rts5208/ms.c:2309:55-56: WARNING: array_size is already used (line 2305) to compute the same size
./drivers/video/fbdev/core/fbcon.c:642:52-53: WARNING: array3_size is already used (line 638) to compute the same size
./drivers/video/fbdev/core/fbcon.c:679:47-48: WARNING: array3_size is already used (line 638) to compute the same size
./drivers/usb/misc/sisusbvga/sisusb_con.c:1229:54-56: WARNING: array_size is already used (line 1226) to compute the same size
./fs/afs/cmservice.c:271:45-46: WARNING: array3_size is already used (line 267) to compute the same size
./drivers/mtd/ftl.c:270:49-65: WARNING: array_size is already used (line 266) to compute the same size
./drivers/scsi/qla2xxx/tcm_qla2xxx.c:1608:6-42: WARNING: array_size is already used (line 1605) to compute the same size
./drivers/scsi/qla2xxx/tcm_qla2xxx.c:1613:8-44: WARNING: array_size is already used (line 1605) to compute the same size
./drivers/net/ppp/bsd_comp.c:439:13-37: WARNING: array_size is already used (line 409) to compute the same size
./drivers/net/wireless/ath/ath5k/debug.c:957:20-21: WARNING: array_size is already used (line 934) to compute the same size
./drivers/scsi/fnic/fnic_trace.c:575:3-26: WARNING: array_size is already used (line 566) to compute the same size
./drivers/scsi/fnic/fnic_trace.c:592:32-53: WARNING: array_size is already used (line 580) to compute the same size
./drivers/scsi/fnic/fnic_trace.c:504:30-51: WARNING: array_size is already used (line 492) to compute the same size
./drivers/staging/rts5208/rtsx_chip.c:1475:17-18: WARNING: array_size is already used (line 1458) to compute the same size
./kernel/kexec_file.c:917:8-25: WARNING: array_size is already used (line 913) to compute the same size
./drivers/rapidio/devices/rio_mport_cdev.c:984:8-25: WARNING: array_size is already used (line 978) to compute the same size
./fs/reiserfs/bitmap.c:1463:22-37: WARNING: array_size is already used (line 1459) to compute the same size

duplicate calls:
./drivers/media/test-drivers/vivid/vivid-core.c:1125:59-60: WARNING: same array_size (line 1122)
./drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:142:36-37: WARNING: same array_size (line 138)
./drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:129:41-42: WARNING: same array3_size (line 123)
./drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:146:40-41: WARNING: same array3_size (line 123)
./drivers/media/common/v4l2-tpg/v4l2-tpg-core.c:146:40-41: WARNING: same array3_size (line 129)
./drivers/net/ethernet/cavium/liquidio/octeon_droq.c:289:27-28: WARNING: same array_size (line 284)
./drivers/net/ethernet/intel/ixgbe/ixgbe_lib.c:857:59-60: WARNING: same struct_size (line 854)
./fs/f2fs/super.c:3478:34-35: WARNING: same array_size (line 3478)
./drivers/net/wireless/zydas/zd1211rw/zd_usb.c:1637:45-46: WARNING: same struct_size (line 1634)
./drivers/net/ethernet/netronome/nfp/flower/cmsg.c:221:49-50: WARNING: same struct_size (line 219)
./drivers/staging/rts5208/rtsx_chip.c:1458:36-37: WARNING: same array_size (line 1454)
./drivers/net/ethernet/neterion/vxge/vxge-config.c:2664:59-60: WARNING: same array_size (line 2654)
_______________________________________________
Cocci mailing list
Cocci@systeme.lip6.fr
https://systeme.lip6.fr/mailman/listinfo/cocci
