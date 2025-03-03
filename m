Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AAA1C282EC
	for <cocci@archiver.kernel.org>; Tue,  4 Mar 2025 09:59:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:message-id:references:mime-version:
   in-reply-to:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=YKqqIyx+LvtkYRdOlEQ7AImwUDeztG0/r/38CZ0Vg4Q=;
  b=WhDGQNu9j2NzVaN5+ZyxnNS7bGUazmUMyckYXB8mVkwuBRbrB1SEOohI
   yZ2TfOWxpvIglz6Sg4jPE40HvPhcW0K7Vy7zMTBjE4EwzHkx/6XHtuXev
   PjGlnYe/BYqkR0rvwbo6jkgdGXMC1va8EnLuPfhHQaSmGvZRAM19NGoyX
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@linaro.org
X-IronPort-AV: E=Sophos;i="6.13,331,1732575600"; 
   d="scan'208";a="211069370"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 04 Mar 2025 10:58:56 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 946F5E0E5A; Tue,  4 Mar 2025 10:58:43 +0100 (CET)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id C686CE0260
	for <cocci@sympa.inria.fr>; Mon,  3 Mar 2025 08:40:27 +0100 (CET)
IronPort-SDR: 67c55cea_XtGgaglNNthMnEN1/3m1bCEElayATlEzUTdDP8dN3vIB22K
 SnhUDW+Js+Gu35A3OkZMXVhvtU378A13EdaajGA==
X-IPAS-Result: =?us-ascii?q?A0HCAACQW8VnfDbQVdE9HR0BAQEBCQESAQUFAUCBQAcBC?=
 =?us-ascii?q?wGCQ4FXMwRTkjOBcoF0LQOBE50BgX4PAQMBCwEBQgIEAQEDBIFLAYM0AosVA?=
 =?us-ascii?q?h4HAQQxCA4BAgQBAQEBAwIDAQEBAQEBEAEBBQEBAQIBAQIEBgECEAEBIhkHD?=
 =?us-ascii?q?hIphXsNgmIBgSSBJgEBAQEBAQEBAQEBAR0CDX4BAQEDEhUTBgEBNwEPCxguM?=
 =?us-ascii?q?wEFARwGNYFhf4JlAQIHoX2BBUKLPIEBM4EBggwBAQbcIIFlCQkBCoE0AYVrg?=
 =?us-ascii?q?mMBhVKEFnonD4FVRIEVJwuCQAcxPosHgjOBaYM+mgWOU1J7HANZLAFVExcLB?=
 =?us-ascii?q?wVhSEgDgQ8jD4EUBTRBOoILaUk6Ag0CNYIefIIragQFgSSCN4Q9hECFUoIRg?=
 =?us-ascii?q?V0DAxYPAYMfdxyEfIRqHUACAQttPTcJCxuia4RCgVk0REaBHJYQjnqgWDQHh?=
 =?us-ascii?q?B6BXQYMn14GEy+XRQyTBZh9qQcCCgcGESOBRgE3gVxNMIMqTwMZD44hDBYWi?=
 =?us-ascii?q?FXDS0A1PAIHCwEBAwmFQyYTiiCBSwEB?=
IronPort-PHdr: A9a23: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
 xJvzwUjPaIi8zDj51pxLV3P9nNYrQ==
IronPort-Data: A9a23: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
 k8bi4dAD656F5DTVWYUVwoVvJJJ
IronPort-HdrOrdr: A9a23:BAa1o6xg62M+aM0yooOEKrPw6b1zdoMgy1knxilNoNJuA6qlfu
 SV7YgmPH7P+UsssRQb8+xoV5PwJE80maQFhbX5eI3SIzUO21HYVr2Kj7GSuwEIcheWnoUtt5
 uIMZIOc+EYZWIK7voSizPIaurIruP3l5yAtKPwyWxyRRpmZ6wlwwByERaDD0F6LTMrObMJUL
 SZouRIzgDPRZ3VVKuG77s+MtQra+erqHsuW347OyI=
X-Talos-CUID: =?us-ascii?q?9a23=3Am1cu0WqsSBGYTEld5JUi9KbmUesXdm/s73jKGX2?=
 =?us-ascii?q?1OHxjF5+qFmSbxbwxxg=3D=3D?=
X-Talos-MUID: 9a23:xADwZAvl+p7+rRXQy82nr3J+MoBp84CUMGsGlq8BtJaaaiF9NGLI
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,329,1732575600"; 
   d="scan'208";a="110456210"
X-MGA-submission: =?us-ascii?q?MDGIbjTE1BCdD/dteCnMbOF8ZzUzWnqwSHCjZF?=
 =?us-ascii?q?gszZAn6Jl8AmRuISHAhTUNeSFW9UppqjRtc7wIrAxGM+N9jrabE4gmUx?=
 =?us-ascii?q?7TcO8SI28VgKSZO/YS4hLnG1koF3G9xAGyfEfRj1ks12ugAOfwJOEVWp?=
 =?us-ascii?q?e4L95aCkSVkqsDZBszRmWcSA=3D=3D?=
Received: from mail-ed1-f54.google.com ([209.85.208.54])
  by mail3-smtp-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2025 08:40:26 +0100
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-5e51e3274f1so3105038a12.0
        for <cocci@inria.fr>; Sun, 02 Mar 2025 23:40:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1740987626; x=1741592426; darn=inria.fr;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=YKqqIyx+LvtkYRdOlEQ7AImwUDeztG0/r/38CZ0Vg4Q=;
        b=AYwWNfK8+t3DPqIS6oNdz8QTHbFT6FR2xbzk4uN9ca8v7uhh7hweO+xrwuavBtPtaH
         XLtetZpotuvOZZbuAvD8AC4qFx/HJ1qih0xGuaa0CdyY+5fRd4ptU2jI3BZpourec/Tx
         bQIo0+ZdkizSmtVtMA0MsoD2feeuFg5Q19CU2WecyaRMncxrhPHFIoyB4vI2fcAYiPXL
         P7MIP6U6teHe9LCgRm7NHkUIhB5Nl+PxFpL2x/LLC2Pxeoc2AcJCDd3ASK6r1FqO6Uqq
         isk1DMQEpxmszgD9axkP5n28i3a5izas8KLbZNfm3SJE0UaXtolx/6o9RqFkQPDwzWZI
         mGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740987626; x=1741592426;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKqqIyx+LvtkYRdOlEQ7AImwUDeztG0/r/38CZ0Vg4Q=;
        b=avkYKl7xjQopJtW/FeaWowmiBD03Xo6a2gxv/Bs05UmOUGw/0MqfNpVRzW0PimypcO
         oFFn2We8OV7DNK4fcJ7ECbSHLMZInEyY/RyUqRg1RpHLXO35zlplpCp5mMUrCDSYbXQ6
         +wfTsq6XabGBkOiavkz60wN6R6jl22odQDeUDycEAMyE3HmZS8kZXB+V+XL28xO3Ty9A
         pomst0XGVqTit4yb1lmh0z3QU3dLSXCf+Ip5DA1KLdB/wlPlsmShhuTBj0OyGnzWJ9oc
         NhCBIKDLEeyG1MuKj4qLxBC9HDeEpz7kYgHGud9KBv486mpTsJfFYjteSOdwuEI/zHji
         tm7Q==
X-Forwarded-Encrypted: i=1; AJvYcCXeGBYp0msj6zDJ7o+ZTYDzDwcXoWbOPHy6LoqqJ4d83JD4dSGoe2Qc3NOW/8lV6jrnCPenjg==@inria.fr
X-Gm-Message-State: AOJu0Yzq8eX0207Nme7LCazIzYd/NBQ4e7tYlzUdzLO9R/093pYTcUdu
	pgbfHFynFIW/dhemsu9Jpdm82Yce5Tg4nz3s7Ey1gVlLY2awBE0duGdVhxIAfuc=
X-Gm-Gg: ASbGncvvz56fpb8CG9FeVJXW/UgDYmy3FwOc6Q33XT+lvRsOtuxXhnHI1rMw/EHyk1L
	ic3lAahqjtne7tCRrtiUz1tOhvQGjt30cKCSuRipHwTtC4NpQf1djCsf0dj5Mh44I2EzWHU1isc
	/mS9TEqW/0phySo9PGbqHeDn8sQ0uoSfEsEw4V6WAUH4OSLKwNA1u8LDMfD/JoY7VaXuj5wDSDd
	l+uqOXWnh1GY7fioRRmgIJMqsxCFsmgBlsYR30Y44An5xJcYiJStnYY4246hSQ72/wxEjZOUwt/
	o4TqolcwbGnhm2bHMdNGbWW3ujHbRD0N9oNas6MQNyXOq+Jngg==
X-Google-Smtp-Source: AGHT+IENHB++EW6cxUTVldIAQkOiV9MmVqFnw5XQy2hy0OzVOdph9rtPPbQGZ/IPOrVxn3HuLojH1Q==
X-Received: by 2002:a17:907:7f27:b0:abf:7406:d375 with SMTP id a640c23a62f3a-abf7406d6aamr378845466b.0.1740987626156;
        Sun, 02 Mar 2025 23:40:26 -0800 (PST)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id a640c23a62f3a-abf0c75bfe2sm758421366b.151.2025.03.02.23.40.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Mar 2025 23:40:25 -0800 (PST)
Date: Mon, 3 Mar 2025 10:40:22 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Cc: Markus Elfring <Markus.Elfring@web.de>, kernel-janitors@vger.kernel.org,
	netdev@vger.kernel.org, Andrew Lunn <andrew+netdev@lunn.ch>,
	Ariel Elior <aelior@marvell.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Manish Chopra <manishc@marvell.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Ram Amrani <Ram.Amrani@caviumnetworks.com>,
	Yuval Mintz <Yuval.Mintz@caviumnetworks.com>, cocci@inria.fr,
	LKML <linux-kernel@vger.kernel.org>
Message-ID: <325e67fc-48df-4571-a87e-5660a3d3968f@stanley.mountain>
References: <40c60719-4bfe-b1a4-ead7-724b84637f55@web.de>
 <1a11455f-ab57-dce0-1677-6beb8492a257@web.de>
 <f7967bee-f3f1-54c4-7352-40c39dd7fead@web.de>
 <6958583a-77c0-41ca-8f80-7ff647b385bb@web.de>
 <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z8VKaGm1YqkxK4GM@mev-dev.igk.intel.com>
X-Validation-by: victor.gambier@inria.fr
Subject: Re: [cocci] [PATCH RESEND] qed: Move a variable assignment behind a
 null pointer check in two functions
Reply-To: Dan Carpenter <dan.carpenter@linaro.org>
X-Loop: cocci@inria.fr
X-Sequence: 2504
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-03/325e67fc-48df-4571-a87e-5660a3d3968f%40stanley.mountain>

On Mon, Mar 03, 2025 at 07:21:28AM +0100, Michal Swiatkowski wrote:
> > @@ -523,7 +524,7 @@ qed_ll2_rxq_handle_completion(struct qed_hwfn *p_hwfn,
> >  static int qed_ll2_rxq_completion(struct qed_hwfn *p_hwfn, void *cookie)
> >  {
> >  	struct qed_ll2_info *p_ll2_conn = (struct qed_ll2_info *)cookie;
> > -	struct qed_ll2_rx_queue *p_rx = &p_ll2_conn->rx_queue;
> > +	struct qed_ll2_rx_queue *p_rx;
> >  	union core_rx_cqe_union *cqe = NULL;
> >  	u16 cq_new_idx = 0, cq_old_idx = 0;
> >  	unsigned long flags = 0;
> > @@ -532,6 +533,7 @@ static int qed_ll2_rxq_completion(struct qed_hwfn *p_hwfn, void *cookie)
> >  	if (!p_ll2_conn)
> >  		return rc;
> > 
> > +	p_rx = &p_ll2_conn->rx_queue;
> >  	spin_lock_irqsave(&p_rx->lock, flags);
> > 
> >  	if (!QED_LL2_RX_REGISTERED(p_ll2_conn)) {
> 
> For future submission plase specify the target kernel
> [PATCH net] for fixes, [PATCH net-next] for other.
> 
> Looking at the code callback is always set together with cookie (which
> is pointing to p_ll2_conn. I am not sure if this is fixing real issue,
> but maybe there are a cases when callback is still connected and cookie
> is NULL.

The assignment:

	p_rx = &p_ll2_conn->rx_queue;

does not dereference "p_ll2_conn".  It just does pointer math.  So the
original code works fine.

The question is, did the original author write it that way intentionally?
I've had this conversation with people before and they eventually are
convinced that "Okay, the code works, but only by sheer chance."  In my
experiences, most of the time, the authors of this type of code are so
used to weirdnesses of C that they write code like this without even
thinking about it.  It never even occurs to them how it could be
confusing.

This commit message is misleading and there should not be a Fixes tag.

regards,
dan carpenter


