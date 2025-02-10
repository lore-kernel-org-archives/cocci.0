Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3389FC0219B
	for <cocci@archiver.kernel.org>; Mon, 10 Feb 2025 17:53:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=from:to:cc:in-reply-to:references:date:message-id:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9YNp4mbohM/7lWf7uXTJa3pcrFvbaYJczil0eE5s/Tc=;
  b=TxzWOaSbkQjKJQqPWLeeZB6pSYEf5KPuPLTdh1P7eCrvtxqEq7QZwtEN
   uNAmbstWYn39YgYSgpgxWdro/c9Q+h4z1cNe6RVpEsy0SBMVQe8ybg4gH
   +eHfoEMvYtbtCOj6yTKAO2cePp53avDBPPKT2xiMnoep8DI1ocXAMD3FD
   E=;
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@messagingengine.com
X-IronPort-AV: E=Sophos;i="6.13,275,1732575600"; 
   d="scan'208";a="207556820"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 10 Feb 2025 18:53:47 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id D98A8E0D1E; Mon, 10 Feb 2025 18:53:46 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id C34E4E0260
	for <cocci@sympa.inria.fr>; Mon, 10 Feb 2025 18:53:45 +0100 (CET)
IronPort-SDR: 67aa3d29_tsAOam3dwKPkCQxthO+zBkO5/nxuWZNIQ6KcHG5tJEXijGn
 S4VNwpkj4eEsS1y9cvsqmgw5rI9cDx4xB6UC7OQ==
X-IPAS-Result: =?us-ascii?q?A0FxAQAAPapnj5p8DMpaHgEBCxIMhFeBVjQHCEiNUqkJD?=
 =?us-ascii?q?wEDAQ1EBAEBAwEDhQACiwQCHwYBBDQTAQIEAQEBAQMCAwEBAQEBARABAQUBA?=
 =?us-ascii?q?QECAQECBAYBAhABAQEBAQE5BQ47hXsNgmIBM3GBJQEBAQEBAQEBAQEBAQEdA?=
 =?us-ascii?q?ghjAR8CAQNAAQE3AQ8LISUPAUYGE4MCgmUCskyBAYIMAQEG3gUJgUiITwGFa?=
 =?us-ascii?q?xuEXCcbPwGBTYQ/Pog3glCCM0qCeoFqpARSexwDWSwBVRMXCwcFgSlIA4ERI?=
 =?us-ascii?q?w+BFAU0Cjc6gg1pSToCDQI1gh58giuCIII7hEOES4VYghKBYAMDFhIBgyF4H?=
 =?us-ascii?q?IRPHUADC209NxQbnz88hSoBgSZqlySOfqEEhCWiE5dBkxGYfKkugX4jgVwzG?=
 =?us-ascii?q?ggbFYMiTwMZD44hGYNhxFwlMjwCBwsBAQMJkC0sCIFLAQE?=
IronPort-PHdr: A9a23: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
 5sIR/lQU1lnT5sn
IronPort-Data: A9a23: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
 tVh3pTmOHm4FQ==
IronPort-HdrOrdr: A9a23:Cfohr6EqX8K0M4TypLqE38eALOsnbusQ8zAXPhhKOHhom7+j5q
 eTdZUgpGTJYVkqOE3I9ersBEDEewK4yXcX2/hqAV7BZniEhILAFugLhuHfKn/bak/DH4Vmup
 uIBpIeNDSGNzZHZKjBjDVQWOxQpuVvuJrY/Ns24U0dNT1XVw==
X-Talos-CUID: 9a23:utuF9GHHHOgoDF+3qmJ/6WFLR9IubkbXzVXNegi3EGg1VryaHAo=
X-Talos-MUID: 9a23:wNl6KQkyfQhYGHLlRjdodnp7NPdH/5v/EHsUy5ErgMuAJW8hBhOk2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,275,1732575600"; 
   d="scan'208";a="207556817"
X-MGA-submission: =?us-ascii?q?MDG2n/Z48lgPOyb2qXCh5m39ywGnCSmj188ChM?=
 =?us-ascii?q?59CqGTCJGehH2YCLWae3AvEkbEJlKtSMX94CFyu6sYdAiUh4Bel+Iz/7?=
 =?us-ascii?q?y/NKVfVKg1StMQhYPQFO5EdTkmPGJAhhBGIEoaxaZyGyBBUcv4DHsrJP?=
 =?us-ascii?q?Iq/drzWObdJsMGYYmFzG1vmg=3D=3D?=
Received: from fhigh-b3-smtp.messagingengine.com ([202.12.124.154])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2025 18:53:45 +0100
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 83DD72540135;
	Mon, 10 Feb 2025 12:53:43 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-09.internal (MEProxy); Mon, 10 Feb 2025 12:53:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=davidreaver.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm1; t=1739210023; x=
	1739296423; bh=9YNp4mbohM/7lWf7uXTJa3pcrFvbaYJczil0eE5s/Tc=; b=m
	X7KiW8eJ7fsz9er8oiEGA9j2sthF2lsHF4fw5aoI4VXRGIskHsAboyuX4Ya3aX6z
	O32CcGTn625nzZ1dMroVnJ6D+yrcadUws74AXu3snihjbTwr6Fy27C5fdEV2WMR5
	8pDYeZHHLMKpZbUWzzmhnI743b4Ke6Ly9FKGAdh4QY/UrtgufpySQQxzMUy5eU7K
	u5gK2Yljp0LbY8wBuIRfQcVtY31x2c6uSBdD+1YeLIAVIbnlpjCd6feZF1zTPWEJ
	4ZWlP196DIeg+h3VTRN5sEzBoG7QVtnRvNvo2G+SxtmP0svKOJZ7h0lXwT59VZiF
	EG4tYS0fEDrQDYq5+yxiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739210023; x=1739296423; bh=9YNp4mbohM/7lWf7uXTJa3pcrFvbaYJczil
	0eE5s/Tc=; b=nADWn/nf34RFQ9hy1ns2O4bHDiVhrzes1ytP9wbOur331SzhB4G
	Og/M5rML1fKw5H9cyXtQaRvIUNSsb+ol2IEcOrhVSJaPdrZ6IJripYlQ4iHh2Bg+
	rOTO8zo4yLoluvfdR8mSaGMTNRLL91kU8DL9mL/p6SsynwuNYSu8v4NwL47e7mLH
	aOtF/C9j4otTDXLO7fHcUKPrY0LsG0qDqj2xhPQAAX/qSD2h0NkYslg577TWUR87
	Q0qNB7TWsZ/B//IPqOTdFVfr1tdL7wLLYrLPzSfaB0JZ+l+5md0kosDGsbx3UoGg
	kF3l8NNXCgFhEpejrxZwSXckywTpiO3AvpQ==
X-ME-Sender: <xms:Jj2qZ1X5QKiMIF0WMtUUADbP5bcq1w5C5zKLehz8QAURUcdKRToDcA>
    <xme:Jj2qZ1mj_ts1e6D9lU1YmLYC1A2BCwDT_45Ej62PDFsWr-yc37q-fKm-q9Pp1hUjf
    vEoZfDig-FZJs3N8NQ>
X-ME-Received: <xmr:Jj2qZxbbmS21-RUUGPaxp7K8MZnyQ-iGdlx8p7Og7aVp2Mh21V-VGh61WdMRfqqAxz1erae_eERKeOTgM5FyRqsIc3Jy1w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefkeejfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhgffffkgggtsehttdertddtredt
    necuhfhrohhmpeffrghvihguucftvggrvhgvrhcuoehmvgesuggrvhhiughrvggrvhgvrh
    drtghomheqnecuggftrfgrthhtvghrnhepudetjefhvdeujefhkefhteelffelheevtddu
    ueelkeeludevteekteekjeevvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepmhgvsegurghvihgurhgvrghvvghrrdgtohhmpdhnsggprhgt
    phhtthhopeelpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehlihhnuhigqdhkvg
    hrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegtohgttghisehi
    nhhrihgrrdhfrhdprhgtphhtthhopehlihhnuhigqdhfshguvghvvghlsehvghgvrhdrkh
    gvrhhnvghlrdhorhhgpdhrtghpthhtohepvhhirhhoseiivghnihhvrdhlihhnuhigrdho
    rhhgrdhukhdprhgtphhtthhopegsrhgruhhnvghrsehkvghrnhgvlhdrohhrghdprhgtph
    htthhopegurghkrheskhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprhgrfhgrvghlsehk
    vghrnhgvlhdrohhrghdprhgtphhtthhopehgrhgvghhkhheslhhinhhugihfohhunhgurg
    htihhonhdrohhrghdprhgtphhtthhopehrohhsthgvughtsehgohhoughmihhsrdhorhhg
X-ME-Proxy: <xmx:Jj2qZ4V4g_a7bgpbXcYypZhG0TuLqtlIA1S8isTJzLz5FcgS5JUEOQ>
    <xmx:Jj2qZ_mSIcEpsNEmdPdxMqccuGjkJHDIs3LQzOtfBm7yYaYdXPuBlA>
    <xmx:Jj2qZ1fmyVFc6QOSJgLFG_rKewDiC4ib-orj-s1YhZ0qUhhYGZSnQg>
    <xmx:Jj2qZ5HOunSPNAw0Ife39dI5YEfkaSSSTdy9WVxumpzJ6JRT08Fwhw>
    <xmx:Jz2qZ4jEqzdgQ8PgV_S73J_t6e9k_R9_PZpCp0lL3IR-qMLFKd6eo8LW>
Feedback-ID: i67e946c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Feb 2025 12:53:41 -0500 (EST)
From: David Reaver <me@davidreaver.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,  "Rafael J . Wysocki"
 <rafael@kernel.org>,  Danilo Krummrich <dakr@kernel.org>,  Christian
 Brauner <brauner@kernel.org>,  Alexander Viro <viro@zeniv.linux.org.uk>,
  linux-fsdevel@vger.kernel.org,  cocci@inria.fr,
  linux-kernel@vger.kernel.org
In-Reply-To: <20250210114531.20ea15cf@gandalf.local.home> (Steven Rostedt's
	message of "Mon, 10 Feb 2025 11:45:31 -0500")
References: <20250210052039.144513-1-me@davidreaver.com>
	<20250210052039.144513-6-me@davidreaver.com>
	<20250210114531.20ea15cf@gandalf.local.home>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Mon, 10 Feb 2025 09:53:40 -0800
Message-ID: <86cyfp3cuz.fsf@davidreaver.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [cocci] [RFC PATCH 5/6] debugfs: Manual fixes for incomplete
 Coccinelle conversions
Reply-To: David Reaver <me@davidreaver.com>
X-Loop: cocci@inria.fr
X-Sequence: 2404
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/86cyfp3cuz.fsf%40davidreaver.com>

Steven Rostedt <rostedt@goodmis.org> writes:
>
> Why are you adding these defines?
>
> All files should be just including <linux/debugfs.h>
>
> so that they can use either "dentry" or "debugfs_node" while you do he
> conversion.
>
> Then the last patch should just modify debugfs and debugfs.h and no other
> file should be touched.
>
> I'll comment on the last patch to explain what I was expecting to be done
> that should satisfy Al.
>
> -- Steve

Hey Steve, there are two reasons for the temporary defines:

1. There are a few files touched in this series where replacing the
   define or later forward declaration with an include <linux/debugfs.h>
   caused errors related to circular includes.

2. The heuristic of adding a define or forward declaration wherever a
   struct dentry declaration existed was far easier to automate than
   conditionally adding an #include <linux/debugfs.h>. It is harder for
   Coccinelle figure out where to put the #include if there multiple
   #include blocks, no #includes in the file, etc.

However, I'm having trouble reproducing point 1. I'd be happy to use
#include <linux/debugfs.h> instead of forward declarations. I'll see if
I can find a way to mostly automate that. There are "only" 56 additions
of struct dentry forward declarations so far in this patch series, so
even if I have to eyeball these #includes by hand that might be okay.

Thanks,
David Reaver
