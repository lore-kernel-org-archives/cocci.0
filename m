Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39274606A883
	for <cocci@archiver.kernel.org>; Thu, 12 Nov 2026 12:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inria.fr header.i=@inria.fr header.a=rsa-sha256 header.s=dc header.b=N83IdQzH
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=mime-version:date:from:to:cc:reply-to:in-reply-to:
   references:message-id:content-transfer-encoding:subject:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=vF6ygMplxEfg9TSyNg7blFkazl7g4DSfr6nJUdQRy+U=;
  b=N83IdQzHyD1C47vb8yj38Ld+B/bcHczRAyraXykWWFyGjFvfme4xH1Sk
   XniyVISeF1ovTkge7x5ts4FkJoEBY8tqoYqLxVI6VLS7tRNNMxtHmXjz/
   vXlOZyeVNXV4ksdPVihcXHAXyV2Ui5yNFUGrNLFWlDfRZVce/wWbWUJXC
   A=;
X-CSE-ConnectionGUID: RYCQimb3TOG4dfvbXsh8Nw==
X-CSE-MsgGUID: GcsWPUW8R/imTCQ6RSByAg==
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@prod-sympa-app.inria.fr
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.27 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:128.93.162.3 ip4:128.93.162.88 ip4:128.93.162.27 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@prod-sympa-app.inria.fr) identity=helo;
  client-ip=128.93.162.27;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@prod-sympa-app.inria.fr";
  x-conformance=spf_only
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="305075228"
Received: from prod-sympa-app.inria.fr ([128.93.162.27])
  by mail2-relais-roc.national.inria.fr with ESMTP; 12 Nov 2026 13:26:36 +0100
Received: by prod-sympa-app.inria.fr (Postfix, from userid 990)
	id 8B75C81BBD; Thu, 12 Nov 2026 13:26:35 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by prod-sympa-app.inria.fr (Postfix) with ESMTP id 35D2C813A8
	for <cocci@sympa.inria.fr>; Thu, 12 Nov 2026 13:26:32 +0100 (CET)
X-CSE-ConnectionGUID: Ya52CG6AQRa1PIZu6JC56w==
X-CSE-MsgGUID: JAg7FqXwQYW4hzXI43L8pw==
IronPort-SDR: 6af5b077_fj8yUZXzlMvezZgnj8XFRNCMjdeHnj1DzRxCB8Uyw3HRZ6/
 souLw/TlIhqCJ9BFKZacdtgdhK3jv5CM82UBv2w==
X-ThreatScanner-Verdict: Negative
X-IPAS-Result: =?us-ascii?q?A0HeAgCRr/VqgQQqG9RaglmBblOBBVQUMgcIhSGIeoh9h?=
 =?us-ascii?q?FuZR4F+DwEDAQ1PAgQBAQGFBAKOHwIfBwQFLAgOAQIEAwIDAQEBAQEBAQEBA?=
 =?us-ascii?q?QELAQEBBAEBAQIBAQIEAwEBAQECEAEBOwcOO4ZcjBoBhAABAQEDIw8BBUEQB?=
 =?us-ascii?q?AcJDwICJgICKysGG4VvBAMBAbsngTKBAYRm2WOBH1WBHy6FdIJuAYp2Jw4Ng?=
 =?us-ascii?q?UhFhBAxPogfgmoEgiKBDJdmBwceJh1bHANZLAEPRhMXCwcFYEVDA4EGI0sFL?=
 =?us-ascii?q?R03bCEdFxEeWBsGBRIgKkBDW4ESgQVdgSsoXQEBAR9GLQoLgXUCglGBI10CA?=
 =?us-ascii?q?UlBDgdFUwklQxJHJCIIEgkBExosCoEaNTwJJj8VDFsMCAMaBRomAh8IAgsCD?=
 =?us-ascii?q?HQoERATHR4kLwUaJj4bCn4HZj03CQwZBAIBOghCHRIClncTySM8hCqBdIIQn?=
 =?us-ascii?q?WISHBeDcQGnAJkIqUWBagM1gVx9CIIUgQ9PAxkP4F9EcQIHAgcBDAEDC4VGj?=
 =?us-ascii?q?FaBTAEB?=
IronPort-PHdr: A9a23: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
 rrarA4jhryERthkOh8n
IronPort-Data: A9a23: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
IronPort-HdrOrdr: A9a23:EoO4264Yqr3AycEYlAPXwO/XdLJyesId70hD6qm+c20xTiX+rb
 HQoB17726JtN9/YhEdcLy7Scq9qDbnhOdICOoqXItLgGTdyQ2VxeNZnPDfKu3balDDH4dmvM
 8KGcZD4Z/LfCBHZKDBkW6F+r0bsb26Gc6T9IXjJycEd3ARV0h51WpE4xygfnGeWjMoOaYE
X-Talos-CUID: 9a23:sQnu3WHw30UId+VgqmJW/RNOMe97W0TnxS7oAn2lV0RCFeOKHAo=
X-Talos-MUID: =?us-ascii?q?9a23=3A9WLwqA4Dkhuq4McGBZ0qhOl8xoxKyqvxJlk9jqw?=
 =?us-ascii?q?3hJWEJxxRZ2y53CyoF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.27,209,1787004000"; 
   d="scan'208";a="162458920"
X-IronPort-Outbreak-Status: No, level 0, Unknown - Unknown
X-MGA-submission: =?us-ascii?q?MDFwJt23u9V84ubD4HPXf+mlIzX6NXIoO0fGJC?=
 =?us-ascii?q?uCFH16sr+w9RXGhtewB9zbLJ37EdLWGqEB46hdYkGx9CgFeRJWO+doLq?=
 =?us-ascii?q?jhCUUyEoJE49ES7ZpRidcXEELWP8tPPkqbgW2H9zr1nRGDoh/DyQ0fCZ?=
 =?us-ascii?q?bEskrCqHpdfa1LojN3q6eIhA=3D=3D?=
Received: from smtp4-g21.free.fr ([212.27.42.4])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2026 13:26:31 +0100
Received: from lettres.chocolatnoir.net (unknown [83.159.1.88])
	by smtp4-g21.free.fr (Postfix) with ESMTPS id 4D12C19F756;
	Thu, 12 Nov 2026 13:26:28 +0100 (CET)
Received: by lettres.chocolatnoir.net (Postfix, from userid 126)
	id D5EEFCE8E20; Thu, 12 Nov 2026 13:26:27 +0100 (CET)
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Spam-Level: 
Received: from lettres.chocolatnoir.net (localhost [IPv6:::1])
	by lettres.chocolatnoir.net (Postfix) with ESMTPA id 556ECCE8E1D;
	Thu, 12 Nov 2026 13:26:27 +0100 (CET)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Thu, 12 Nov 2026 13:26:27 +0100
From: picca <picca@debian.org>
To: Victor Gambier <victor.gambier@inria.fr>
Cc: Julia Lawall <julia.lawall@inria.fr>, cocci@inria.fr
Reply-To: picca@debian.org
Mail-Reply-To: picca@debian.org
In-Reply-To: <0faa3236-0ab2-45d3-953e-6168ce6c8d76@inria.fr>
References: <d4be4d6fe184ccc6147abbe3da5cacc1@debian.org>
 <b225b777-9216-635a-76b8-fc46f6d6a3@inria.fr>
 <45e0468b84f19a5d75ea99fb434113c0@debian.org>
 <0faa3236-0ab2-45d3-953e-6168ce6c8d76@inria.fr>
Message-ID: <0e99b58f1f63d6ff89889c6f132d4e2e@debian.org>
X-Sender: picca@debian.org
Organization: Miaouh
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [cocci] Bug dans la parseur de coccinelle ?
X-Loop: cocci@inria.fr
X-Sequence: 3794
Precedence: list
Precedence: bulk
Sender: cocci-request@inria.fr
X-no-archive: yes
List-Id: <cocci.inria.fr>
List-Help: <https://sympa.inria.fr/sympa/help>, <mailto:sympa_inria@inria.fr?subject=HELP>
List-Subscribe: <https://sympa.inria.fr/sympa/subscribe/cocci>, <mailto:sympa_inria@inria.fr?subject=SUB%20cocci>
List-Post: <mailto:cocci@inria.fr>
List-Owner: <mailto:cocci-request@inria.fr>
List-Archive: <https://sympa.inria.fr/sympa/arc/cocci>
Archived-At: <https://sympa.inria.fr/sympa/msg/cocci/2026-11/ynOGlvsjQSZ2dW6TN5SL7w>
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1

Le 2026-11-12 13:12, Victor Gambier a écrit :
> Thanks. What command are you running to get this error?
> 
> Victor
> 
> On 11/12/26 11:47, picca wrote:
>> here it is
>> 
>> Fred
>> 


spatch --in-place --sp-file reffactoring.cocci ana_read.c
