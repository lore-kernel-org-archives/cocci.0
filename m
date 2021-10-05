Return-Path: <SRS0=2JM+=OZ=inria.fr=cocci-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4E8DC433EF
	for <cocci@archiver.kernel.org>; Tue,  5 Oct 2021 19:50:00 +0000 (UTC)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB26461371
	for <cocci@archiver.kernel.org>; Tue,  5 Oct 2021 19:49:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CB26461371
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=univ-grenoble-alpes.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=inria.fr
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="532239212"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 05 Oct 2021 21:49:57 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 175CEE0154; Tue,  5 Oct 2021 21:49:57 +0200 (CEST)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1FF8CE010C
	for <cocci@sympa.inria.fr>; Tue,  5 Oct 2021 21:49:50 +0200 (CEST)
Authentication-Results: mail2-smtp-roc.national.inria.fr; spf=None smtp.pra=nicolas.palix@univ-grenoble-alpes.fr; spf=Pass smtp.mailfrom=nicolas.palix@univ-grenoble-alpes.fr; spf=None smtp.helo=postmaster@zm-mta-out-3.u-ga.fr
IronPort-HdrOrdr: =?us-ascii?q?A9a23=3A59f7kqGCfiJCRMIOpLqEnceALOsnbusQ8zAX?=
 =?us-ascii?q?Pi9KJSC9Hvb0qynRppomPHbP4V57ZJhKo7+90ce7K0/hyQ=3D=3D?=
X-IronPort-AV: E=Sophos;i="5.84,326,1620684000"; 
   d="scan'208";a="532239207"
X-MGA-submission: =?us-ascii?q?MDHN+VlZsC7HQbr7sT0FChLwc3ZKlFwsh6aE9l?=
 =?us-ascii?q?07wMjuHD3MuFEPqgSvD4wXtVEsBfLiTuLuK46nbtrNRBMNnMGMQ8mguZ?=
 =?us-ascii?q?Rgm54Svtzgcp3d4s/ZjjqHUcQWLmNtSw2qCDuWLgzsGtS8s/ndEM0ZdX?=
 =?us-ascii?q?kQO4AviH9X7sBJzoQp0l6x7w=3D=3D?=
Received: from zm-mta-out-3.u-ga.fr ([152.77.200.56])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 05 Oct 2021 21:49:49 +0200
Received: from mailhost.u-ga.fr (mailhost1.u-ga.fr [152.77.1.10])
	by zm-mta-out-3.u-ga.fr (Postfix) with ESMTP id 4304640E1D;
	Tue,  5 Oct 2021 21:49:49 +0200 (CEST)
Received: from smtps.univ-grenoble-alpes.fr (smtps3.u-ga.fr [195.83.24.62])
	by mailhost.u-ga.fr (Postfix) with ESMTP id 37FE360073;
	Tue,  5 Oct 2021 21:49:49 +0200 (CEST)
Received: from [192.168.1.50] (lfbn-lyo-1-262-34.w2-7.abo.wanadoo.fr [2.7.102.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: palixn@univ-grenoble-alpes.fr)
	by smtps.univ-grenoble-alpes.fr (Postfix) with ESMTPSA id 0F44240069;
	Tue,  5 Oct 2021 21:49:49 +0200 (CEST)
Subject: Re: Build failures, possibly 32 bit only, with OCaml 4.13.1
To: "Richard W.M. Jones" <rjones@redhat.com>,
 Julia Lawall <julia.lawall@inria.fr>
Cc: cocci@inria.fr
References: <20211005121204.GQ7596@redhat.com>
 <alpine.DEB.2.22.394.2110051545350.6871@hadrien>
 <20211005140144.GB25685@redhat.com>
From: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
Message-ID: <05ed666a-6887-dcb8-458b-39bc9c30a525@univ-grenoble-alpes.fr>
Date: Tue, 5 Oct 2021 21:49:48 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20211005140144.GB25685@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 7bit
X-Greylist: Whitelist-UGA SMTP Authentifie (palixn@univ-grenoble-alpes.fr) via submission-587 ACL (40)
X-Greylist: Whitelist-UGA MAILHOST (SMTP non authentifie) depuis 195.83.24.62
Reply-To: Nicolas Palix <nicolas.palix@univ-grenoble-alpes.fr>
X-Loop: cocci@inria.fr
X-Sequence: 24
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
List-Archive: <http://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <http://sympa.inria.fr/sympa/arcsearch_id/cocci/2021-10/05ed666a-6887-dcb8-458b-39bc9c30a525%40univ-grenoble-alpes.fr>

Hi,

According to the log, it seems to be some warning about some deprecated 
function calls and the error was about Python integration.


Great if it is fixed !

Nico.

On 05/10/2021 16:01, Richard W.M. Jones wrote:
> On Tue, Oct 05, 2021 at 03:45:56PM +0200, Julia Lawall wrote:
>>
>>
>> On Tue, 5 Oct 2021, Richard W.M. Jones wrote:
>>
>>> [resending to the new mailing list]
>>>
>>> Hi Julia,
>>>
>>> https://koji.fedoraproject.org/koji/taskinfo?taskID=76740903
>>>
>>> I observed build failures with OCaml 4.13.1.  They manifest as
>>> segmentation faults.  Unfortunately it's not easy to get the core
>>> dump, but I might be able to get a stack trace later.  Apart from that
>>> you can look at the build logs by clicking through the red links above
>>> and going to "build.log".
>>>
>>> The common factor may be 32 bit platforms.
>>>
>>> We (Fedora) don't really care too much about cocci on 32 bit since
>>> it's a development tool and every developer these days has a 64 bit
>>> machine.  (It could of course be something unrelated to 32 bit)
>>
>> Thanks for the report, I will see if something can be done.
> 
> After saying all that I noticed there's a newer version available,
> and upgrading actually fixes it:
> 
> https://koji.fedoraproject.org/koji/taskinfo?taskID=76743322
> 
> I didn't notice any particular change that mentioned "32 bit".
> So that's .. strange, but at least it's fixed!
> 
> Rich.
> 


-- 
Nicolas Palix
