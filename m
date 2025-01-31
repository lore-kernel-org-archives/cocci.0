Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB495C0218D
	for <cocci@archiver.kernel.org>; Fri, 31 Jan 2025 10:24:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:cc:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=AL+bEEFEbxOnnAfvsrxNXAc1nSXYFfUB4jhOEv46nTw=;
  b=h4VsMEq9Sjcd5E0QWASxqe2hPo8CK8IPXcMNU+4q06dNZyMsVRx5NqDw
   fPfKxV2bKuvoRNYnpuTrYPVcvmH83DfQ60geCZ9DUo5P2DqHjFSK5/2kv
   OKyicBThhthBvNGNoUXo7Awsbwsdy6kTVe/t56BrfTw7YWTtbi8fvs9s1
   4=;
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
X-IronPort-AV: E=Sophos;i="6.13,248,1732575600"; 
   d="scan'208";a="205931705"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 31 Jan 2025 11:24:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id B4E65E0264; Fri, 31 Jan 2025 11:24:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id F2D78E0260
	for <cocci@sympa.inria.fr>; Fri, 31 Jan 2025 11:24:23 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=AL+bEEFEbxOnnAfvsrxNXAc1nSXYFfUB4jhOEv46nTw=;
  b=OcC2yZoqb3VAq0DZ0Ve8sZBdltHM7dWzUrW3ObGqDMAq6rlA6X+Ueyq/
   ZsyqUaWP5Mmz2sa/cQkd5RoTNqVdQo6cpTmx9wUoBLXdjHZRSaCVA7T0G
   Y0wAU9Iqkxb9gBBZ6/qF1k/mVAeEMjdm8x6BQm7BISpZj6qTXf4XgraPx
   Y=;
X-IronPort-AV: E=Sophos;i="6.13,248,1732575600"; 
   d="scan'208";a="107846251"
Received: from lfbn-idf2-1-396-176.w86-246.abo.wanadoo.fr (HELO [192.168.1.11]) ([86.246.108.176])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 11:24:24 +0100
Message-ID: <c3546d21-b6ff-4890-8d12-6cb76e3e7013@inria.fr>
Date: Fri, 31 Jan 2025 11:24:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jani Nikula <jani.nikula@intel.com>, Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <87plkrhqu9.fsf@intel.com>
 <40a550cc-984f-8d-6c3b-8c9c0a7fa5c@inria.fr> <87frlmj38x.fsf@intel.com>
 <4ebe30f0-d7b3-59de-4a8b-22668cba59c3@inria.fr> <877c6yirab.fsf@intel.com>
 <19e808d6-9c84-4582-88db-7917ccec96ee@inria.fr> <878qr1mzrn.fsf@intel.com>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <878qr1mzrn.fsf@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] [cocci-mirror] spatch #include statements and include
 search path
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2326
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-01/c3546d21-b6ff-4890-8d12-6cb76e3e7013%40inria.fr>

The issue should be fixed in commit fb9a33. The idea is if we can't find 
the included cocci file in the C directory, then we start looking for it 
in the cocci directory.

Thanks for the report!
Victor

