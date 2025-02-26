Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D95C021B8
	for <cocci@archiver.kernel.org>; Wed, 26 Feb 2025 08:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:cc:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=BFPE5nqMT5TV/F32YTt+Q2sFqdqX3HzV4emGmVK7HJw=;
  b=FKTPn/v/V0whxGY9cylvgm/67vSnTEIOvAbtSDRy1/KEeZaz4JoTzJw3
   4JGKsst/CvoWh326SmbFRifE0tP2NGOQ96swHmkmbbh1EyfW8qRUvHUPo
   5j9XT5ay8eZ1l95qUiUwFXFhS6gtX9kTN/tY5TXu7Anqn9CJ5qraPwExK
   I=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linux.microsoft.com
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="scan'208";a="210104133"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Feb 2025 09:59:03 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 7A5D6E0D25; Wed, 26 Feb 2025 09:59:03 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A11AE0260
	for <cocci@sympa.inria.fr>; Wed, 26 Feb 2025 01:02:48 +0100 (CET)
IronPort-SDR: 67be5a28_a0XklkRyk1THxPuA8dwbXUsp5MAsif6qFIWNyZYtcY73+3h
 uXT++Bnyt1FUeg/pPslkkWuUN7jcf7jIpVpMC9g==
X-IPAS-Result: =?us-ascii?q?A0EYAADiWL5nhbaaTQ1aHQEBAQEJARIBBQUBQIE/CAELA?=
 =?us-ascii?q?YJDgVczBwhIhFaIHYlWE4tgkiGBQD4PAQMBTgECBAEBAwSFAAKLEgIfBgEEM?=
 =?us-ascii?q?AkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBAhABAQEBQEmFew2CY?=
 =?us-ascii?q?gGBJFENSAEBAQEBAQEBAQEBAQEBAQEBAQEBAQEBARECDV4BAR4BAQEDERIPA?=
 =?us-ascii?q?Q0BATcBDwkCGAICJgICVgYVAQGCfoJlBgKTJok9AYdgAQECiyOBMoEBggwBA?=
 =?us-ascii?q?QbcIIFlCYEaLgGITgGFaxsphDMnG4FJRIE8CwOCdT6EWINGgmmCM0qBJIM+p?=
 =?us-ascii?q?3ZSexwDWSwBVRMXCwcFgSlIA4EPI4EjBTQKNzqCC2lJOgINAjWCHnyBHYEOa?=
 =?us-ascii?q?gQFgSqCN4RDXC8DAwMDgyqFUoIRgWADAxYPAYMfdxyEf4N6HUACAQttPTcJC?=
 =?us-ascii?q?xtDoWeEPoI0gQIWkyWDUI8AoQSEJaFNBg8EL5dYkn0uh2WQaoErp1SCGDqBX?=
 =?us-ascii?q?EYHIxWDIk8DGQ+IAIYhGYNhy3MiNTwCBwEKAQEDCYVGAQGKVIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 wRAO0QDOXk=
IronPort-HdrOrdr: A9a23:OoYWj6ulXaqSaD45RLnNxB9i7skDRtV00zEX/kB9WHVpmwKj9/
 xG785rsiMc7wxhIE3I+OrwQZVpIxvnn6KdhLN9AV7MZmbbUQeTXeVfBM7Zslvd8k7FmNK1t5
 0NT0EWMrSZZmSSz/yKhTVQeOxQo+VvnprY59s2g00NcT1X
X-Talos-CUID: =?us-ascii?q?9a23=3AvdNj/Wn0YX+3vUQDV4oliNceSGvXOW3Z13HqeEC?=
 =?us-ascii?q?xMH1weOepRgLB6aE8s9U7zg=3D=3D?=
X-Talos-MUID: 9a23:7IKNlAoCKsstdXWHDpAez2pTFJlNoIuOMUsctJ8UntmkDzdyIjjI2Q==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,314,1732575600"; 
   d="scan'208";a="210057521"
X-MGA-submission: =?us-ascii?q?MDHfBQ6RG/VCFYTz9RZ17TOh7tR7dPWaEIS/g4?=
 =?us-ascii?q?o5tdXuC221QNEIy7Y+yuwGc+ngHSr6lKHFOOIGa3BVtmvcf45jRuxnIz?=
 =?us-ascii?q?Bvo56mjAa+T0LYYq/FaN9IqG5uDkT3w9GUV7KSlhWPEAMH8RWFC9Gn5i?=
 =?us-ascii?q?PNSqx4PZL4og70E+I/fNi/Ew=3D=3D?=
Received: from linux.microsoft.com ([13.77.154.182])
  by mail2-smtp-roc.national.inria.fr with ESMTP; 26 Feb 2025 01:02:47 +0100
Received: from [100.65.162.92] (unknown [20.236.10.206])
	by linux.microsoft.com (Postfix) with ESMTPSA id A62F5203CDFE;
	Tue, 25 Feb 2025 16:02:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A62F5203CDFE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1740528165;
	bh=BFPE5nqMT5TV/F32YTt+Q2sFqdqX3HzV4emGmVK7HJw=;
	h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
	b=HuaKl3qdKUi413qXmLg1j75aNN8MijOcIeKtJu18EQJFDjoRXls3deulMv1TJVsSW
	 65ILxLiYMFv1sS1yCqPvEvTeMb7w5g4ew6OAxy2dKtMZrrLZYy7Kf0E371zAONpm5r
	 c4JAQrpBSBxtsQowW5sxR9dgfpM5kWSNcx4MfN/8=
Message-ID: <df0c2400-147c-4104-a2e6-d1038ff31524@linux.microsoft.com>
Date: Tue, 25 Feb 2025 16:02:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: eahariha@linux.microsoft.com, Frank.Li@nxp.com,
 James.Bottomley@HansenPartnership.com, Julia.Lawall@inria.fr,
 Shyam-sundar.S-k@amd.com, akpm@linux-foundation.org, axboe@kernel.dk,
 broonie@kernel.org, cassel@kernel.org, cem@kernel.org,
 ceph-devel@vger.kernel.org, clm@fb.com, cocci@inria.fr,
 dick.kennedy@broadcom.com, djwong@kernel.org, dlemoal@kernel.org,
 dongsheng.yang@easystack.cn, dri-devel@lists.freedesktop.org,
 dsterba@suse.com, festevam@gmail.com, hch@lst.de, hdegoede@redhat.com,
 hmh@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net, idryomov@gmail.com,
 ilpo.jarvinen@linux.intel.com, imx@lists.linux.dev,
 james.smart@broadcom.com, jgg@ziepe.ca, josef@toxicpanda.com,
 kalesh-anakkur.purayil@broadcom.com, kbusch@kernel.org,
 kernel@pengutronix.de, leon@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ide@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-pm@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-sound@vger.kernel.org,
 linux-spi@vger.kernel.org, linux-xfs@vger.kernel.org,
 martin.petersen@oracle.com, nicolas.palix@imag.fr, ogabbay@kernel.org,
 perex@perex.cz, platform-driver-x86@vger.kernel.org, s.hauer@pengutronix.de,
 sagi@grimberg.me, selvin.xavier@broadcom.com, shawnguo@kernel.org,
 sre@kernel.org, tiwai@suse.com, xiubli@redhat.com, yaron.avizrat@intel.com
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
 <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
From: Easwar Hariharan <eahariha@linux.microsoft.com>
Content-Language: en-US
In-Reply-To: <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 06/16] rbd: convert timeouts to
 secs_to_jiffies()
Reply-To: Easwar Hariharan <eahariha@linux.microsoft.com>
X-Loop: cocci@inria.fr
X-Sequence: 2457
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/df0c2400-147c-4104-a2e6-d1038ff31524%40linux.microsoft.com>

On 2/25/2025 1:09 PM, Christophe JAILLET wrote:
> Le 25/02/2025 à 21:17, Easwar Hariharan a écrit :
>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
>> secs_to_jiffies().  As the value here is a multiple of 1000, use
>> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
>>
>> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
>> the following Coccinelle rules:
>>
>> @depends on patch@ expression E; @@
>>
>> -msecs_to_jiffies(E * 1000)
>> +secs_to_jiffies(E)
>>
>> @depends on patch@ expression E; @@
>>
>> -msecs_to_jiffies(E * MSEC_PER_SEC)
>> +secs_to_jiffies(E)
>>
>> While here, remove the no-longer necessary check for range since there's
>> no multiplication involved.
> 
> I'm not sure this is correct.
> Now you multiply by HZ and things can still overflow.
> 
> 
> Hoping I got casting right:
> 
> #define MSEC_PER_SEC    1000L
> #define HZ 100
> 
> 
> #define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
> 
> static inline unsigned long _msecs_to_jiffies(const unsigned int m)
> {
>     return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
> }
> 
> int main() {
> 
>     int n = INT_MAX - 5;
> 
>     printf("res  = %ld\n", secs_to_jiffies(n));
>     printf("res  = %ld\n", _msecs_to_jiffies(1000 * n));
> 
>     return 0;
> }
> 
> 
> gives :
> 
> res  = -600
> res  = 429496130
> 
> with msec, the previous code would catch the overflow, now it overflows silently.
> 
> untested, but maybe:
>     if (result.uint_32 > INT_MAX / HZ)
>         goto out_of_range;
> 
> ?
> 
> CJ
> 

Thanks for the review! I was able to replicate your results, I'll try this range check
and get back.

Thanks,
Easwar (he/him)
