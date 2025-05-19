Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AAD5C3ABD8
	for <cocci@archiver.kernel.org>; Mon, 19 May 2025 15:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=9HMc0DzIN5ocrXZLGX5hiW5AlfZP52hbSKBuKVVgxw8=;
  b=FzfYMENDHOuymqHJ9ewhXXEJGQAlNLtr9NrSxhdca5PAt2V3x5RR3ToB
   ny2owTYQgqfRlhhoXy8R7sLKuemuUNa+umkJKUSuGIbiHuvrI/yzBDl6K
   L1ejTFhTKSO0IhjtxmVU14Kk4K/PzCs7VpIaBVb005JLLsTWVnG7PtKoJ
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.15,301,1739833200"; 
   d="scan'208";a="222816467"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 19 May 2025 17:40:01 +0200
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 31B5BE0157; Mon, 19 May 2025 17:40:01 +0200 (CEST)
Received: from mail3-relais-sop.national.inria.fr (mail3-relais-sop.national.inria.fr [192.134.164.104])
	by sympa.inria.fr (Postfix) with ESMTPS id 6D96FE0131
	for <cocci@sympa.inria.fr>; Mon, 19 May 2025 17:39:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=9HMc0DzIN5ocrXZLGX5hiW5AlfZP52hbSKBuKVVgxw8=;
  b=BiEOr8lh1wbmqmPbg972i+TnuDfMlW9JpMOq4PXcQ00yckg/fDp/evN6
   TXLX0ltcbAsPdK/AvMslBPE98gezKlPvAAn38pHMJ8h5Roa+VDDC1nD+K
   WenDR9H3KIIeDXGfFefWZUTHbtRM9ZVPCq9Z9K9SJ9xzSjm0enLCaf/MB
   U=;
X-IronPort-AV: E=Sophos;i="6.15,301,1739833200"; 
   d="scan'208";a="116972886"
Received: from unknown (HELO hadrien) ([194.182.8.86])
  by mail3-relais-sop.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:39:53 +0200
Date: Mon, 19 May 2025 17:39:52 +0200 (CEST)
From: Julia Lawall <julia.lawall@inria.fr>
To: Luo Jie <quic_luoj@quicinc.com>
cc: Markus Elfring <Markus.Elfring@web.de>, cocci@inria.fr, 
    linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, 
    Catalin Marinas <catalin.marinas@arm.com>, Joey Gouly <joey.gouly@arm.com>, 
    Julia Lawall <Julia.Lawall@inria.fr>, Marc Zyngier <maz@kernel.org>, 
    Nicolas Palix <nicolas.palix@imag.fr>, 
    Oliver Upton <oliver.upton@linux.dev>, 
    Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
    Suzuki Poulouse <suzuki.poulose@arm.com>, Will Deacon <will@kernel.org>, 
    Yury Norov <yury.norov@gmail.com>, Zenghui Yu <yuzenghui@huawei.com>, 
    LKML <linux-kernel@vger.kernel.org>, Andrew Lunn <andrew@lunn.ch>, 
    "Kiran Kumar C.S.K" <quic_kkumarcs@quicinc.com>, 
    Lei Wei <quic_leiwei@quicinc.com>, Pavithra R <quic_pavir@quicinc.com>, 
    Suruchi Agarwal <quic_suruchia@quicinc.com>, quic_linchen@quicinc.com
In-Reply-To: <1e3ba498-2bfb-4cab-ba13-5ab2c5b03ef9@quicinc.com>
Message-ID: <6fe2aed9-f29e-4a77-5f47-855cfefe1973@inria.fr>
References: <20250417-field_modify-v3-0-6f7992aafcb7@quicinc.com> <20250417-field_modify-v3-2-6f7992aafcb7@quicinc.com> <a1be0efc-a4c9-461d-a01a-8fb830b2c68d@web.de> <0ee48e2f-58db-49b0-b651-dcc0e517465e@quicinc.com> <43712874-6f1d-435c-98b2-30ac44d25309@web.de>
 <1e3ba498-2bfb-4cab-ba13-5ab2c5b03ef9@quicinc.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-477211006-1747669194=:4212"
Subject: Re: [cocci] [PATCH v3 2/6] coccinelle: misc: Add field_modify
 script
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 2740
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-05/6fe2aed9-f29e-4a77-5f47-855cfefe1973%40inria.fr>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-477211006-1747669194=:4212
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT



On Mon, 19 May 2025, Luo Jie wrote:

>
>
> On 4/24/2025 12:35 AM, Markus Elfring wrote:
> > …
> > > > -reg &= ~mask;
> > > > -reg |= FIELD_PREP
> > > > +       FIELD_MODIFY
> > > >                     (mask,
> > > > +                  &reg,
> > > >                      val
> > > >                     );
> > …
> > > With this code variant, there is no space prior to &reg, here is the
> > > example code changes generated by the SmPL code as below, is this
> > > expected?
> > …
> > > +++ b/drivers/phy/starfive/phy-jh7110-dphy-tx.c
> > > @@ -244,8 +244,7 @@ static int stf_dphy_configure(struct phy
> > >          i = stf_dphy_get_config_index(bitrate);
> > >
> > >          tmp = readl(dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(100));
> > > -       tmp &= ~STF_DPHY_REFCLK_IN_SEL;
> > > -       tmp |= FIELD_PREP(STF_DPHY_REFCLK_IN_SEL, STF_DPHY_REFCLK_12M);
> > > +       FIELD_MODIFY(STF_DPHY_REFCLK_IN_SEL,&tmp, STF_DPHY_REFCLK_12M);
> > >          writel(tmp, dphy->topsys + STF_DPHY_APBIFSAIF_SYSCFG(100));
> >
> > The Coccinelle software is still evolving somehow.
> > Thus your test result can trigger further development considerations.
> > I hope that clarifications and corresponding improvements can be achieved
> > also according to such source code layout concerns.
> >
> > Regards,
> > Markus
>
> OK, understand. I will keep the original patch as below for now, as we
> need to ensure the script generates code with the expected style.
> +- reg &= ~mask;
> +- reg |= FIELD_PREP(mask, val);
> ++ FIELD_MODIFY(mask, &reg, val);
>
> In addition, below case is filed to request this improvement on the
> coccinelle project.
> https://github.com/coccinelle/coccinelle/issues/397

Thanks for the report.

julia


>
> Thanks.
>
--8323329-477211006-1747669194=:4212--
