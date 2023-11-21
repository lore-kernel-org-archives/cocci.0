Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22287C61D85
	for <cocci@archiver.kernel.org>; Tue, 21 Nov 2023 20:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:in-reply-to:message-id:references:
   mime-version:subject:reply-to:sender:list-id:list-help:
   list-subscribe:list-unsubscribe:list-post:list-owner:
   list-archive;
  bh=HunlOfREBQrZ9PQ3K1nKJu6BzOiP+odw9p9/3RPgwVY=;
  b=UxXsUyJbMNfvdY5kpUbGOAacaadb7vegImHxXyO1J3itMlQtA8s/WKZN
   eSMmuZhYl5XOgoLxvb2jNwMxBi9svUf1of7C2B+l4PaMetb3GKoXyl/Cj
   NxXcw04wfjBAdrz/+4cnoZN5mfnSfcAsnxi28Cc+piH2sONNNrJrfw+1i
   0=;
Received-SPF: Pass (mail2-relais-roc.national.inria.fr: domain of
  cocci-owner@inria.fr designates 128.93.162.160 as permitted
  sender) identity=mailfrom; client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="cocci-owner@inria.fr"; x-conformance=spf_only;
  x-record-type="v=spf1"; x-record-text="v=spf1
  ip4:128.93.142.0/24 ip4:192.134.164.0/24 ip4:128.93.162.160
  ip4:89.107.174.7 mx ~all"
Received-SPF: None (mail2-relais-roc.national.inria.fr: no sender
  authenticity information available from domain of
  postmaster@sympa.inria.fr) identity=helo;
  client-ip=128.93.162.160;
  receiver=mail2-relais-roc.national.inria.fr;
  envelope-from="cocci-owner@inria.fr";
  x-sender="postmaster@sympa.inria.fr"; x-conformance=spf_only
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=pass (signature verified) header.i=@inria.fr
X-IronPort-AV: E=Sophos;i="6.04,216,1695679200"; 
   d="scan'208";a="137705194"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 21 Nov 2023 21:58:32 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 539DFE0CCC; Tue, 21 Nov 2023 21:58:32 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 1DC58E004E
	for <cocci@sympa.inria.fr>; Tue, 21 Nov 2023 21:58:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=HunlOfREBQrZ9PQ3K1nKJu6BzOiP+odw9p9/3RPgwVY=;
  b=TpXrlSGSIPjGuJtWBenneVzocNdcwVWWHS535Sh2wVs4M2kLyk7dadR8
   9mUCiJusHHbthAFK/DvSQnj1FXdOjE+OmsdBi7VWeq18znP9FunpwI9XJ
   3Y+rIcYa5BMHCinLmhvCJpsF/MQ0ivN0VViibsahoCLmm7BRnDPt8/0Oo
   4=;
X-IronPort-AV: E=Sophos;i="6.04,216,1695679200"; 
   d="scan'208";a="137705193"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 21:58:29 +0100
Date: Tue, 21 Nov 2023 21:58:28 +0100 (CET)
From: Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To: Jesse Brandeburg <jesse.brandeburg@intel.com>
cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>, cocci@inria.fr, 
    Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <e7263df7-be7d-47a4-b708-e04393f7887a@intel.com>
Message-ID: <alpine.DEB.2.22.394.2311212156410.3253@hadrien>
References: <20231109161846.148524-1-przemyslaw.kitszel@intel.com> <e7263df7-be7d-47a4-b708-e04393f7887a@intel.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [cocci] [BUG] exponentially slow spatch
Reply-To: Julia Lawall <julia.lawall@inria.fr>
X-Loop: cocci@inria.fr
X-Sequence: 1302
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2023-11/alpine.DEB.2.22.394.2311212156410.3253%40hadrien>



On Tue, 21 Nov 2023, Jesse Brandeburg wrote:

> On 11/9/2023 8:18 AM, Przemek Kitszel wrote:
> > Hi Julia,
> >
> > we were bothered by, what we have called a "flaky spatch" issues
> > in our CI servers, which have manifested as spatch "just exiting",
> > without any proper exit codes.
> > Jake & Jesse found out that processing large files (like 100kloc
> > amalgamate builds...) or parallel processing makes it more common,
> > so we have disabled those.
> > Now I see that those builds were likely killed (or spatch "crashes"?).
> >
> > The issue hit me again, so I dig deeper, and the case is that processing
> > time grows exponentially for seemingly easy case, attached.
> >
> > I'm on github provided sources, as of commit d235ef51f6be ("in modern versions
> > of Linux, PAGE_ALIGNED looks like an ordinary macro call"), running
> > Rhel 9.3 Beta.
> >
> > Przemek
>
> Adding the cocci list since it's been a couple of weeks, if you want me
> to bounce the original mail with the patches to the list please let me know.

Sorry, I think I missed the original email.

I see nothing very alarming about this code

>
> > ---
> >  small.cocci |  8 ++++++++
> >  y.c         | 53 +++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 61 insertions(+)
> >  create mode 100644 small.cocci
> >  create mode 100644 y.c
> >
> > diff --git a/small.cocci b/small.cocci
> > new file mode 100644
> > index 000000000000..6a6cee97e21f
> > --- /dev/null
> > +++ b/small.cocci
> > @@ -0,0 +1,8 @@
> > +@@
> > +expression list E;
> > +expression hw;
> > +@@
> > +(
> > +- ice_info(hw,E);
> > ++ dev_info(ice_hw_to_dev(hw),E);
> > +)

The outer parentheses are not needed.  I don't think they should cause bad
behavior, but still no need to have them.

I'll see how this runs on my side.

julia

> > diff --git a/y.c b/y.c
> > new file mode 100644
> > index 000000000000..560ddc26430b
> > --- /dev/null
> > +++ b/y.c
> > @@ -0,0 +1,53 @@
> > +/**
> > + * ice_dump_common_caps - print struct ice_hw_common_caps fields
> > + * @hw: pointer to the ice_hw instance
> > + * @caps: pointer to common caps instance
> > + * @prefix: string to prefix when printing
> > + */
> > +static void
> > +ice_dump_common_caps(struct ice_hw *hw, struct ice_hw_common_caps *caps,
> > +		     char const *prefix)
> > +{
> > +	ice_info(hw, "%s: switching_mode = %d\n", prefix, caps->switching_mode);
> > +	ice_info(hw, "%s: mgmt_mode = %d\n", prefix, caps->mgmt_mode);
> > +	ice_info(hw, "%s: mgmt_protocols_mctp = %d\n", prefix,
> > +		 caps->mgmt_protocols_mctp);
> > +	ice_info(hw, "%s: os2bmc = %d\n", prefix, caps->os2bmc);
> > +	ice_info(hw, "%s: valid_functions (bitmap) = %d\n", prefix,
> > +		 caps->valid_functions);
> > +	ice_info(hw, "%s: sr_iov_1_1 = %d\n", prefix, caps->sr_iov_1_1);
> > +	ice_info(hw, "%s: vmdq = %d\n", prefix, caps->vmdq);
> > +	ice_info(hw, "%s: evb_802_1_qbg = %d\n", prefix, caps->evb_802_1_qbg);
> > +	ice_info(hw, "%s: evb_802_1_qbh = %d\n", prefix, caps->evb_802_1_qbh);
> > +	ice_info(hw, "%s: dcb = %d\n", prefix, caps->dcb);
> > +	ice_info(hw, "%s: active_tc_bitmap = %d\n", prefix,
> > +		 caps->active_tc_bitmap);
> > +	ice_info(hw, "%s: maxtc = %d\n", prefix, caps->maxtc);
> > +	ice_info(hw, "%s: iscsi = %d\n", prefix, caps->iscsi);
> > +	ice_info(hw, "%s: rss_table_size = %d\n", prefix, caps->rss_table_size);
> > +	ice_info(hw, "%s: rss_table_entry_width = %d\n", prefix,
> > +		 caps->rss_table_entry_width);
> > +	ice_info(hw, "%s: num_rxq = %d\n", prefix, caps->num_rxq);
> > +	ice_info(hw, "%s: rxq_first_id = %d\n", prefix, caps->rxq_first_id);
> > +	ice_info(hw, "%s: num_txq = %d\n", prefix, caps->num_txq);
> > +	ice_info(hw, "%s: txq_first_id = %d\n", prefix, caps->txq_first_id);
> > +	ice_info(hw, "%s: num_msix_vectors = %d\n", prefix,
> > +		 caps->num_msix_vectors);
> > +	ice_info(hw, "%s: msix_vector_first_id = %d\n", prefix,
> > +		 caps->msix_vector_first_id);
> > +	ice_info(hw, "%s: ieee_1588 = %d\n", prefix, caps->ieee_1588);
> > +	ice_info(hw, "%s: mgmt_cem = %d\n", prefix, caps->mgmt_cem);
> > +	ice_info(hw, "%s: iwarp = %d\n", prefix, caps->iwarp);
> > +	ice_info(hw, "%s: roce_lag = %d\n", prefix, caps->roce_lag);
> > +} /* This takes 27 seconds as of now, doubles with each ice_info() call added
> > +
> > +	ice_info(hw, "%s: wr_csr_prot = 0x%llX\n", prefix,
> > +		 (unsigned long long)caps->wr_csr_prot);
> > +	ice_info(hw, "%s: num_wol_proxy_fltr = %d\n", prefix,
> > +		 caps->num_wol_proxy_fltr);
> > +	ice_info(hw, "%s: wol_proxy_vsi_seid = %d\n", prefix,
> > +		 caps->wol_proxy_vsi_seid);
> > +	ice_info(hw, "%s: max_mtu = %d\n", prefix, caps->max_mtu);
> > +	ice_print_led_caps(hw, caps, prefix, false);
> > +	ice_print_sdp_caps(hw, caps, prefix, false);
> > +*/
>
>
