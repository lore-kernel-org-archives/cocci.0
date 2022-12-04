Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3E3DC4332F
	for <cocci@archiver.kernel.org>; Sun,  4 Dec 2022 12:56:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:date:mime-version:to:references:from:
   in-reply-to:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=+tPhSbwbXGZmeet1R4rmKOlS0RC2bMx3D51MknA9CWI=;
  b=hnqQwWh03FB/ho5B5hOIPnwUAbQftstjvBkABeksIFFmJpCM5VLRa030
   AMZ2uJgv2TzywKOHYzVkxOFdEuyfVT4jdY18mSb09kRX8zwwqFFJT06uF
   gYdP47yMz9tpGN89voJmB4j+z9AuMZqHTcHPPnfArp3ed4aJLKqRBQ+oq
   4=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr
Received-SPF: SoftFail (mail2-relais-roc.national.inria.fr:
  domain of cocci-owner@inria.fr is inclined to not designate
  128.93.162.160 as permitted sender) identity=mailfrom;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:192.134.164.0/24 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="81591564"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Dec 2022 13:56:30 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 9D248E019E; Sun,  4 Dec 2022 13:56:30 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 8A4BAE013A
	for <cocci@sympa.inria.fr>; Sun,  4 Dec 2022 13:56:28 +0100 (CET)
IronPort-SDR: 638c98fb_s5ifMzIcu0IdQGCsKlsbmKEBeqhVqJTJEQXkefYePgWp9mS
 G4/coquy1tcklQbwYWPoeeHOLeSo4jc7hautc8A==
X-IPAS-Result: =?us-ascii?q?A0HZAQD2l4xjmBOg6VVagQmDfIEFVi4HCEWET4NPjVCfM?=
 =?us-ascii?q?w8BAwENNQ8EAQEEA4ILgnMChQ8CHgYBBDQTAQIEAQEBAQMCAwEBAQEBAQMBA?=
 =?us-ascii?q?QUBAQECAQECBAQBAQIQAQEBAQEBAQEVCRkFDhAFIoVoDYI1IoIELA1SeAECA?=
 =?us-ascii?q?gEjFUYLCxoCJgICVxMIAQEXgmMBgn8jAwSubYEygQGDFpxBgWEGgRQskRgXE?=
 =?us-ascii?q?BYGgg2BPAwDgnQ+hRGDCoJnBJZ3YiUEDgMZKx1AAgELbQpDNQkCEUwQGxwbB?=
 =?us-ascii?q?4EMKigVAwQEAwIGEwMiAg0oMRQEKRMNKydvCQIDImEFAwMEKCwDCUAHFREkP?=
 =?us-ascii?q?AdWNwEEAwIPIDgGAwkDAiJUcwIuERUFAwsVJQgFSQQIOQUGUxICChEDEg8GJ?=
 =?us-ascii?q?kUOSD45FgYncg4OEwNdgWkEM4F7XZhUg0oQggOTHpAGjCSTdoNzi1GUdAYPB?=
 =?us-ascii?q?C6DZZMLFJIWlz+neoF5I4FcTTQEgyJPAxkPjiwNCYNQil5BNDsCBwsBAQMJi?=
 =?us-ascii?q?h8BAQ?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 u3yNpE90tZdD32pqSsuCiSHvNpa
IronPort-HdrOrdr: A9a23:0u2h56ta4hh6qBQOUGTqfBuZ7skDddV00zEX/kB9WHVpm7+j9v
 xG+85rsyMc6QxhP03I9ursBEDtewK/yXcx2/h0AV7AZmXbUQmTRr2KPbGSpgEIcheWnoVgPO
 VbAstD4bbLY2SS4/yb3OD1Kbkd/OU=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.96,217,1665439200"; 
   d="scan'208";a="41668175"
X-MGA-submission: =?us-ascii?q?MDFXxvDtE6HFbUAb+dDWJURv3uImGInlEomktg?=
 =?us-ascii?q?8FtTqCcVGQwa1cjDDS9GlDfbH2DxrNUkHmPR3bCh5qnlPExDJI7QEDwj?=
 =?us-ascii?q?R2xKKa+GoYiGgcllLbb/ydU+NVbO+ZkigTzzZlQVYqYNQFww5voilS4T?=
 =?us-ascii?q?/yIKsih362a07WzoO83bsYMQ=3D=3D?=
Received: from smtp.hosts.co.uk ([85.233.160.19])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2022 13:56:27 +0100
Received: from [152.37.86.21] (helo=[192.168.1.100])
	by smtp.hosts.co.uk with esmtpa (Exim)
	(envelope-from <derek@knosof.co.uk>)
	id 1p1oXi-0002OB-Bo
	for cocci@inria.fr;
	Sun, 04 Dec 2022 12:56:26 +0000
Message-ID: <e9d8231c-9b98-6603-4786-7b61809af4d0@knosof.co.uk>
Date: Sun, 4 Dec 2022 12:56:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Content-Language: en-US
To: cocci@inria.fr
References: <a9cad00c-ede3-338d-da7d-801dab7d51c2@knosof.co.uk>
 <alpine.DEB.2.22.394.2212040832050.3337@hadrien>
From: Derek M Jones <derek@knosof.co.uk>
Organization: Knowledge Software, Ltd
In-Reply-To: <alpine.DEB.2.22.394.2212040832050.3337@hadrien>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [cocci] Searching for ++ of volatile variables
Reply-To: Derek M Jones <derek@knosof.co.uk>
X-Loop: cocci@inria.fr
X-Sequence: 762
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2022-12/e9d8231c-9b98-6603-4786-7b61809af4d0%40knosof.co.uk>

Julia,

> For the assignment operators, you should use:
> 
> assignment operator b = {+=,-=,&=};

Thanks.

> But the much simpler and efficient solution is just to declare the
> metavariable with the type you want, ie
> 
> volatile int V_1;

Good idea, that works.

I was hoping for a solution that did not require me
to enumerate all the different volatile types in separate
rules (to handle the different names in the Python script).


-- 
Derek M. Jones           Evidence-based software engineering
blog:https://shape-of-code.com
