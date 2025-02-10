Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29045C02198
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 14:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   mime-version:content-transfer-encoding:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=0XowXm7G11XmcZtohrB11J3VkbpDZy0t4T4v+xqw9oM=;
  b=RlYOJzculJA+NFLHCbHSd+hWH6Y6Y/yIy2C6mOz1w9PIlF6Yspl8aPkF
   xOOcEga3knx79nAT066B/fMO7F5omX1Vp+N7pwjjYqHE81ots4U6rtmDL
   jF0gekxz4C0zVd4QpRzgtFw6Psjp/ugxR/M3mjbRpUb4IR+wrbjTCF62I
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="207511240"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 15:48:48 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id EDEE6E0D1E; Mon, 10 Feb 2025 15:48:47 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id A9A45E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 15:48:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:in-reply-to:references:
   subject:mime-version:content-transfer-encoding;
  bh=0XowXm7G11XmcZtohrB11J3VkbpDZy0t4T4v+xqw9oM=;
  b=vDT+80HLLiTSYMKGdQAMiw/FFjkR1eeoioOW2FdV5npMRq1+WswGj60a
   lyKB1d0MCx6tPlA9MAdsA9fmRSnix//ApP3NJZULq3qy0aDsR064e62gP
   IFP56VZeWZmw4/U72ZF/7nXRI0JyNVOFlubTFAZl+/y5C65Jz9ESExWEv
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,274,1732575600"; 
   d="scan'208";a="207511229"
X-MGA-submission: =?us-ascii?q?MDFkrq44Eze8bhzS7AF7lZoPRIO1I8Hj9700jy?=
 =?us-ascii?q?EJkfKEFfN2vv9B7itVZ2tyB9+WHooH24/uGm9tUMslGcrC6o2HALOqms?=
 =?us-ascii?q?kxZPzbH39sikKilfcI7Rf6Wuk6OTocmcTWj2m67smhcOgMoD8ZEiqIbQ?=
 =?us-ascii?q?n91EApfTZi6/w0ClauZfCLMA=3D=3D?=
Received: from zcs2-store8.inria.fr ([128.93.142.6])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 15:48:43 +0100
Date: Mon, 10 Feb 2025 15:48:43 +0100 (CET)
From: Fonyuy-Asheri Caleb <fonyuy-asheri.caleb@inria.fr>
To: Julia Lawall <julia.lawall@inria.fr>
Cc: cocci <cocci@inria.fr>
Message-ID: <1507041832.8850908.1739198923533.JavaMail.zimbra@inria.fr>
In-Reply-To: <b0221fbf-5e28-65c8-b5e9-9440e86bcd45@inria.fr>
References: <1579016749.8625707.1739185685318.JavaMail.zimbra@inria.fr> <74e89641-1819-e332-47c1-f1ba5fbc47@inria.fr> <1948830352.8646779.1739186619092.JavaMail.zimbra@inria.fr> <6a8d84cc-8bff-d68d-5d7b-fd567627149@inria.fr> <1932675609.8662032.1739187744210.JavaMail.zimbra@inria.fr> <b0221fbf-5e28-65c8-b5e9-9440e86bcd45@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Originating-IP: [131.254.23.3]
X-Mailer: Zimbra 10.1.5_GA_4724 (ZimbraWebClient - GC131 (Linux)/10.1.5_GA_4734)
Thread-Topic: Creating function definitions from function pointers in a struct with coccinelle
Thread-Index: Osg7SO0M5YJIPN7yD56LyYEc2+c1OQ==
Subject: Re: [cocci] Creating function definitions from function pointers in
 a struct with coccinelle
Reply-To: Fonyuy-Asheri Caleb <fonyuy-asheri.caleb@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2393
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/1507041832.8850908.1739198923533.JavaMail.zimbra%40inria.fr>

Follow up question please: 

How can i match function pointer calls such as 

ctx->ops.my_function(int id, struct data_struct data);

or 

ctx->my_function(int id, struct data_struct data);

I can't seem to get this working. 


Caleb

----- Original Message -----
> From: "Julia Lawall" <julia.lawall@inria.fr>
> To: "Fonyuy-Asheri Caleb" <fonyuy-asheri.caleb@inria.fr>
> Cc: "Julia Lawall" <julia.lawall@inria.fr>, "cocci" <cocci@inria.fr>
> Sent: Monday, February 10, 2025 12:56:20 PM
> Subject: Re: [cocci] Creating function definitions from function pointers in a struct with coccinelle

> On Mon, 10 Feb 2025, Fonyuy-Asheri Caleb wrote:
> 
>> Thanks a lot Julia.
>>
>> It works now.
> 
> Excellent :)
> 
> julia
> 
