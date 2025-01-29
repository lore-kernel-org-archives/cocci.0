Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C19F0C02192
	for <cocci@archiver.kernel.org>; Wed, 29 Jan 2025 09:51:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=nZMMrtTMI7zmm6JbHCMQpOFuA/Odui5O1E7ucxY9VgY=;
  b=K678bfDYMtuHCyFB8z2VI55QqDH8cxZgFzsoCmQ82lnKUmdQKXfHUQzL
   ojf5EEPrpWBQo/xZnEV5LEnwxbd9HOJo+PGViTFEb0GAEUdGiI1zXXSsx
   Q5pjeMpJMvdRixBMb9Zkt1pJpoys6lfvZk3sPpUyM3rMXbIsIIbodhcpx
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  include:mailout.safebrands.com a:basic-mail.safebrands.com
  a:basic-mail01.safebrands.com a:basic-mail02.safebrands.com
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="scan'208";a="205538985"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 29 Jan 2025 10:51:22 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 40153E0D21; Wed, 29 Jan 2025 10:51:22 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 118A0E0260
	for <cocci@sympa.inria.fr>; Wed, 29 Jan 2025 10:51:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=nZMMrtTMI7zmm6JbHCMQpOFuA/Odui5O1E7ucxY9VgY=;
  b=Qt53ijwNCqXg72CQUXreits+Ex1uxpjMz1/1OLR2Rzkpg2uW1l7hnBnr
   VyrzWskWwiAH8vyiLKu+ePIIOvMDOIw2pjPX8IEDLl5Fo5JrWVIuvA7pP
   DP56Zk37GXhXSW541n87/U+Yit6VZNsYeZj6chGaoH9jCWNX78iUJoUmn
   A=;
X-IronPort-AV: E=Sophos;i="6.13,243,1732575600"; 
   d="scan'208";a="205538979"
Received: from ptb-02008469.paris.inria.fr (HELO [128.93.66.153]) ([128.93.66.153])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2025 10:51:21 +0100
Message-ID: <35764b92-edf0-490f-beea-c36207de4cc2@inria.fr>
Date: Wed, 29 Jan 2025 10:51:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Markus Elfring <Markus.Elfring@web.de>,
 Ricardo Ribalda <ribalda@chromium.org>,
 Easwar Hariharan <eahariha@linux.microsoft.com>, cocci@inria.fr
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Julia Lawall <Julia.Lawall@inria.fr>, Nicolas Palix <nicolas.palix@imag.fr>
References: <20250129-secs_to_jiffles-v1-1-35a5e16b9f03@chromium.org>
 <fe13604a-2626-4641-908e-87eeaca53288@web.de>
 <CANiDSCvufe0nK_NLykSRLb9RmttNOhw3-mm6aiC=gj41Hxtgiw@mail.gmail.com>
 <fce88885-8c10-4f22-a19c-3b04430aec3d@web.de>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <fce88885-8c10-4f22-a19c-3b04430aec3d@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] coccinelle: misc: secs_to_jiffies script: Create dummy
 report
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2306
Errors-To: cocci-owner@inria.fr
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <mailto:sympa_inria@inria.fr?subject=help>
List-Subscribe: <mailto:sympa_inria@inria.fr?subject=subscribe%20cocci>
List-Unsubscribe: <mailto:sympa_inria@inria.fr?subject=unsubscribe%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/35764b92-edf0-490f-beea-c36207de4cc2%40inria.fr>

Thanks for the patch :)

On 29/01/2025 09:46, Markus Elfring wrote:
> I prefer to avoid a temporary workaround when a more useful solution
> is actually simple.

Markus, this is not helpful. Either provide a fully working example or 
stop nitpicking useful patches for projects you don't maintain.

Victor


