Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C33CC3ABB6
	for <cocci@archiver.kernel.org>; Mon,  5 May 2025 11:59:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=e+Fhqtz1UDQzwoSuDPXBeJUnfd4TvVG0NynjuL9f8Sw=;
  b=jNxT48s0MlF3GwitYSPBEw5ejD0lYgorE6542M0lLIp+bjpinJw4IC1E
   8mrRPlvnSXhUWoQraUsHQ1NYTdnuVHChon6ij3Ye18aVIoeyVL1iTVMaH
   LGHMDCVMRVHsUmMpB5P9Mp2elm+hlAk62Zj9mdL+1DPu36q8fTzzDhTSR
   o=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.15,262,1739833200"; 
   d="scan'208";a="220639704"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 May 2025 13:59:15 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id A6F94E0AF1; Mon,  5 May 2025 13:59:14 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 1A388E0157
	for <cocci@sympa.inria.fr>; Mon,  5 May 2025 13:59:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:subject:to:references:from:
   in-reply-to:content-transfer-encoding;
  bh=e+Fhqtz1UDQzwoSuDPXBeJUnfd4TvVG0NynjuL9f8Sw=;
  b=ixTDTS6e8s67Em8de6syAj+lHi62yMIDpNt/Q7lV/OnRw+i9ep560sQr
   QDnIy8qYagL0Oyw/h/kaL/fN7iw5qR1508ABGAuR8l7yfww6XASYTbr2/
   WFXILtG2Ne9o7DQD/cHtO0UNykObLVWY6/OKO1B1/XAaMsXeRaTViK+E2
   c=;
X-IronPort-AV: E=Sophos;i="6.15,262,1739833200"; 
   d="scan'208";a="115841013"
Received: from unknown (HELO [192.168.1.42]) ([176.187.152.82])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 May 2025 13:59:09 +0200
Message-ID: <1f445001-75f9-40c2-adea-e342d5121bf2@inria.fr>
Date: Mon, 5 May 2025 13:59:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: cocci@inria.fr
References: <160e1382-a7d2-4204-a6e1-09e6e4035b82@mykolab.com>
 <alpine.DEB.2.22.394.2504262300230.3375@hadrien>
Content-Language: en-US
From: Victor Gambier <victor.gambier@inria.fr>
In-Reply-To: <alpine.DEB.2.22.394.2504262300230.3375@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Missing annotated tag for version 1.3
Reply-To: Victor Gambier <victor.gambier@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2736
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-05/1f445001-75f9-40c2-adea-e342d5121bf2%40inria.fr>

Hi,

Thanks for the report. I added back the tags 1.2 and 1.3 which had been 
previously replaced by tags 1.2.0 and 1.3.0 - this does not seem like a 
good idea in hindsight. Now all four tags co-exist. We'll only use 
semantic versioning from now on.

Victor

On 26/04/2025 23:00, Julia Lawall wrote:
>
> On Thu, 24 Apr 2025, Michael Stefaniuc wrote:
>
>> Hello,
>>
>> it looks like the annotated tag for coccinelle version 1.3 is missing from git:
>> eris:~/work/coccinelle$ git pull
>> Already up to date.
>> eris:~/work/coccinelle$ git describe
>> warning: tag '1.2.0' is externally known as '1.2'
>> 1.2-195-g4093aad2d
>>
>> The lightweight tag for 1.3.0 is there though:
>> eris:~/work/coccinelle$ git describe --tags
>> 1.3.0-83-g4093aad2d
> Thanks for the report.  Will look into it.
>
> julia
