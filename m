Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE8F6C19778
	for <cocci@archiver.kernel.org>; Wed, 26 Feb 2025 08:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:references:from:cc:to:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=ZqGB3dHEkHXDAW5t23ZRy/tk7CvQyYHBVX5yXFeysoI=;
  b=tm3R4p8R/FSjPiJk5lhLM40ost5XknBMeIqFel0BeVpqLLY4/o1H2ijc
   Q5Aq1AwGnxxvXZuRE4+gk7VYk30uaDByMM3EeXlw9qI/CPY4qwKzU6brs
   NEQPpPJGv5iISViv/qmTSWwb3Na4bEegFGAR/+VcAHZq54++uLlQzRqvR
   c=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@wanadoo.fr
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="scan'208";a="210104211"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 26 Feb 2025 09:59:05 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 0F4E4E0D37; Wed, 26 Feb 2025 09:59:05 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 5F35CE0260
	for <cocci@sympa.inria.fr>; Wed, 26 Feb 2025 09:10:24 +0100 (CET)
IronPort-SDR: 67becc6e_0sSmeyrKs7J26S5r1XXjvvnSNrrv9v6wcjtejeR74tGtak+
 JvtlfjuQAP7qJRSxafnlNa0OGjJzr7rku1SUbQQ==
X-IPAS-Result: =?us-ascii?q?A0EDAABWy75nj0HyDFBaGwEBAQEBAQEBBQEBARIBAQEDA?=
 =?us-ascii?q?wEBAUCBPwYBAQELAYJDfVozBwhIhFaIHV+IdAOEO5lZgUA+DwEDAQ07CQQBA?=
 =?us-ascii?q?QMEhQACixMgBgEEMAkOAQIEAQEBAQMCAwEBAQEBARABAQUBAQECAQECBAYBA?=
 =?us-ascii?q?hABAQEBAQE5BQ47hXsNgluBLGUJOAEBAQEBAQEBAQEBAQEBGwIIBV4BAR0BA?=
 =?us-ascii?q?QEBAgEjBAsBBQgBATcBDwsYAgImAgJWGQIBAYJ+AYJBIwcNBq5Sen8zgQGCD?=
 =?us-ascii?q?AEBBtwggWUDBoEaLgGFa4JjAYVrRIQzNoFVRIE8gwM+gmEEhTmCaYIzgUAug?=
 =?us-ascii?q?z6oEVJ7HANZLAFVExcLBwWBKUgDgQ8jgSMFNAo3OoILaUk6Ag0CNYIefIIra?=
 =?us-ascii?q?gQFgSqCN4RDXC8DAwMDgyqFUoIRgWADAxYQgx93HIR/hAUdQAIBC209NwkLG?=
 =?us-ascii?q?wY9oTUBPINKdIE5ex1lkzsUEAGDK5pzlF00ByuBc4IAgWMMiimVNQYTL5dEF?=
 =?us-ascii?q?Is6h0Muh2WQao4FmyuBZzqBXHSDM08DGQ+IAIYhGYNhgT7Je0I1AgE5AgcBC?=
 =?us-ascii?q?gEBAwmQHIFLAQE?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:ZrWhDqEjE72uhFQrpLqEK8eALOsnbusQ8zAXPo5KOGVom7+j5q
 eTdZMgpGLJYVcqKQsdcLW7UpVoLkm9yXcY2/h2AV7mZnichILKFvAA0WKB+Vzd8kTFn4Y36U
 4jSdkbNDSaNykesS+V2njBLz9t+qjkzImYwcPzi19wUAACUc1dxjY8LireP0VqSGB9aqYRJd
 65yo5nqz+nEE57Uu2LQl0oG8j7zuekqK7b
X-Talos-CUID: 9a23:gjwF72/Q95GtChSOBJiVv0cuApkYaCOG9lKOZGmUKFpqS5CITWbFrQ==
X-Talos-MUID: 9a23:xLhVnglha/4ESCPcvCe5dnpnGsVWzomVGnwJgKwotMrfCDdsNwy02WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,316,1732575600"; 
   d="scan'208";a="110078450"
X-MGA-submission: =?us-ascii?q?MDEMvNm3XRbca7IhBunLD6UCSmb7INGWPYMBx/?=
 =?us-ascii?q?ox6l///mmXYK52vnCQUdBW9LNkUYmr8blednt9x22XpDKOjKvDXgd4ZS?=
 =?us-ascii?q?QmYCAkvUwv610QgqEL1i3K8dvRr7alCowg3M49aHxFeT3Hq0GpXCeFGo?=
 =?us-ascii?q?xNlc6cVYwYJZalFFzictEG7Q=3D=3D?=
Received: from smtp-65.smtpout.orange.fr (HELO smtp.smtpout.orange.fr) ([80.12.242.65])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Feb 2025 09:10:23 +0100
Received: from [192.168.1.37] ([90.11.132.44])
	by smtp.orange.fr with ESMTPA
	id nCUZttGc7xgLFnCUctj4sa; Wed, 26 Feb 2025 09:10:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1740557422;
	bh=ZqGB3dHEkHXDAW5t23ZRy/tk7CvQyYHBVX5yXFeysoI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=eN5Aq4eovmdL2fTfqQhqmyNlSDtRmJIyRo9BV90ujHdViAKnbjtHr7qbLtUGcLRlZ
	 sm6a7gFroiFb3USkdQ363fe5J2nBAhWrC7vKq9Gr98LlhArejaCxQtmS/g1lQfI49r
	 0aIAOKfoRo4tNDooG9At7xMG826jfO8nyaZlknhJmJI7Jeype1X6hRb1E9umLPEZG2
	 XbWU654Orv/crOsdG/XuK2GvaB+YBDki8U4i31RNmbRUpE2c+df/ckkinYznub6VnQ
	 yhVMeiNx7yCwm+qgQ83RKYb4GoAOEUYS84Jpg4YkW7VlX71dQkYv0MO6jlmI4MTa2U
	 +sFJCwiWciqJQ==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: bWFyaW9uLmphaWxsZXRAd2FuYWRvby5mcg==
X-ME-Date: Wed, 26 Feb 2025 09:10:22 +0100
X-ME-IP: 90.11.132.44
Message-ID: <7b8346a1-8a7d-4fcf-a026-119d77f2ca85@wanadoo.fr>
Date: Wed, 26 Feb 2025 09:10:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
References: <20250225-converge-secs-to-jiffies-part-two-v3-0-a43967e36c88@linux.microsoft.com>
 <20250225-converge-secs-to-jiffies-part-two-v3-6-a43967e36c88@linux.microsoft.com>
 <e53d7586-b278-4338-95a2-fa768d5d8b5e@wanadoo.fr>
 <CAPjX3Fcr+BoMRgZGbqqgpF+w-sHU+SqGT8QJ3QCp8uvJbnaFsQ@mail.gmail.com>
Content-Language: en-US, fr-FR
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Frank.Li@nxp.com, James.Bottomley@hansenpartnership.com,
 Julia.Lawall@inria.fr, Shyam-sundar.S-k@amd.com, akpm@linux-foundation.org,
 axboe@kernel.dk, broonie@kernel.org, cassel@kernel.org, cem@kernel.org,
 ceph-devel@vger.kernel.org, christophe.jaillet@wanadoo.fr, clm@fb.com,
 cocci@inria.fr, dick.kennedy@broadcom.com, djwong@kernel.org,
 dlemoal@kernel.org, dongsheng.yang@easystack.cn,
 dri-devel@lists.freedesktop.org, dsterba@suse.com,
 eahariha@linux.microsoft.com, festevam@gmail.com, hch@lst.de,
 hdegoede@redhat.com, hmh@hmh.eng.br, ibm-acpi-devel@lists.sourceforge.net,
 idryomov@gmail.com, ilpo.jarvinen@linux.intel.com, imx@lists.linux.dev,
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
To: neelx@suse.com
In-Reply-To: <CAPjX3Fcr+BoMRgZGbqqgpF+w-sHU+SqGT8QJ3QCp8uvJbnaFsQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH v3 06/16] rbd: convert timeouts to
 secs_to_jiffies()
Reply-To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2460
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/7b8346a1-8a7d-4fcf-a026-119d77f2ca85%40wanadoo.fr>

Le 26/02/2025 à 08:28, Daniel Vacek a écrit :
> On Tue, 25 Feb 2025 at 22:10, Christophe JAILLET
> <christophe.jaillet-39ZsbGIQGT5GWvitb5QawA@public.gmane.org> wrote:
>>
>> Le 25/02/2025 à 21:17, Easwar Hariharan a écrit :
>>> Commit b35108a51cf7 ("jiffies: Define secs_to_jiffies()") introduced
>>> secs_to_jiffies().  As the value here is a multiple of 1000, use
>>> secs_to_jiffies() instead of msecs_to_jiffies() to avoid the multiplication
>>>
>>> This is converted using scripts/coccinelle/misc/secs_to_jiffies.cocci with
>>> the following Coccinelle rules:
>>>
>>> @depends on patch@ expression E; @@
>>>
>>> -msecs_to_jiffies(E * 1000)
>>> +secs_to_jiffies(E)
>>>
>>> @depends on patch@ expression E; @@
>>>
>>> -msecs_to_jiffies(E * MSEC_PER_SEC)
>>> +secs_to_jiffies(E)
>>>
>>> While here, remove the no-longer necessary check for range since there's
>>> no multiplication involved.
>>
>> I'm not sure this is correct.
>> Now you multiply by HZ and things can still overflow.
> 
> This does not deal with any additional multiplications. If there is an
> overflow, it was already there before to begin with, IMO.
> 
>> Hoping I got casting right:
> 
> Maybe not exactly? See below...
> 
>> #define MSEC_PER_SEC    1000L
>> #define HZ 100
>>
>>
>> #define secs_to_jiffies(_secs) (unsigned long)((_secs) * HZ)
>>
>> static inline unsigned long _msecs_to_jiffies(const unsigned int m)
>> {
>>          return (m + (MSEC_PER_SEC / HZ) - 1) / (MSEC_PER_SEC / HZ);
>> }
>>
>> int main() {
>>
>>          int n = INT_MAX - 5;
>>
>>          printf("res  = %ld\n", secs_to_jiffies(n));
>>          printf("res  = %ld\n", _msecs_to_jiffies(1000 * n));
> 
> I think the format should actually be %lu giving the below results:
> 
> res  = 18446744073709551016
> res  = 429496130
> 
> Which is still wrong nonetheless. But here, *both* results are wrong
> as the expected output should be 214748364200 which you'll get with
> the correct helper/macro.
> 
> But note another thing, the 1000 * (INT_MAX - 5) already overflows
> even before calling _msecs_to_jiffies(). See?

Agreed and intentional in my test C code.

That is the point.

The "if (result.uint_32 > INT_MAX / 1000)" in the original code was 
handling such values.

> 
> Now, you'll get that mentioned correct result with:
> 
> #define secs_to_jiffies(_secs) ((unsigned long)(_secs) * HZ)

Not looked in details, but I think I would second on you on this, in 
this specific example. Not sure if it would handle all possible uses of 
secs_to_jiffies().

But it is not how secs_to_jiffies() is defined up to now. See [1].

[1]: 
https://elixir.bootlin.com/linux/v6.14-rc4/source/include/linux/jiffies.h#L540

> 
> Still, why unsigned? What if you wanted to convert -5 seconds to jiffies?

See commit bb2784d9ab495 which added the cast.

> 
>>          return 0;
>> }
>>
>>
>> gives :
>>
>> res  = -600
>> res  = 429496130
>>
>> with msec, the previous code would catch the overflow, now it overflows
>> silently.
> 
> What compiler options are you using? I'm not getting any warnings.

I mean, with:
	if (result.uint_32 > INT_MAX / 1000)
		goto out_of_range;
the overflow would be handled *at runtime*.

Without such a check, an unexpected value could be stored in 
opt->lock_timeout.

I think that a test is needed and with secs_to_jiffies(), I tentatively 
proposed:
	if (result.uint_32 > INT_MAX / HZ)
		goto out_of_range;

CJ

> 
>> untested, but maybe:
>>          if (result.uint_32 > INT_MAX / HZ)
>>                  goto out_of_range;
>>
>> ?
>>
>> CJ
>>

...
