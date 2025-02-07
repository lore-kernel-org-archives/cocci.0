Return-Path: <cocci-owner@inria.fr>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE702C02196
	for <cocci@archiver.kernel.org>; Fri,  7 Feb 2025 09:00:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=message-id:from:to:date:in-reply-to:references:
   content-transfer-encoding:mime-version:subject:reply-to:
   sender:list-id:list-help:list-subscribe:list-unsubscribe:
   list-post:list-owner:list-archive;
  bh=bJy9wSyVs2NeHc2sySd6y7+u7eYrgdQF8MWynfH7fUo=;
  b=pXS1caUqZPJIoyFncqKwyKfhuzTzXyHbM+gyWsKmaClXAdNbyXxjSVuF
   78TMs917cITiIyXODav86T8XcjCAPfLJR+QqrpV3N/wHCPwF0fkLORZg/
   BWup4sJcpIfze1T8VdW5nepwLAe16aK1lcRMfhiZZCetuJPWxp1Nu6Z4N
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
Authentication-Results: mail2-relais-roc.national.inria.fr; spf=Pass smtp.mailfrom=cocci-owner@inria.fr; spf=None smtp.helo=postmaster@sympa.inria.fr; dkim=hardfail (signature did not verify [final]) header.i=@sipsolutions.net
X-IronPort-AV: E=Sophos;i="6.13,266,1732575600"; 
   d="scan'208";a="207111375"
Received: from prod-listesu18.inria.fr (HELO sympa.inria.fr) ([128.93.162.160])
  by mail2-relais-roc.national.inria.fr with ESMTP; 07 Feb 2025 10:00:01 +0100
Received: by sympa.inria.fr (Postfix, from userid 20132)
	id 20742E0D1E; Fri,  7 Feb 2025 10:00:01 +0100 (CET)
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
	by sympa.inria.fr (Postfix) with ESMTPS id 9A096E0260
	for <cocci@sympa.inria.fr>; Fri,  7 Feb 2025 09:59:57 +0100 (CET)
IronPort-SDR: 67a5cb8d_vJXBQaHF/DstXsdAURfaTvlxTV+lRYnPHYzEK8RQzEvw+Jw
 Dclp29uaE/PPW9MdVEJmXOxjBlRRWapsmeT4iLw==
X-IPAS-Result: =?us-ascii?q?A0H+AQAbyqVnhRAmd6hagQmEF4FWNAcISIRWiHyId5w+g?=
 =?us-ascii?q?1QPAQMBDUEBAgQBAQMBA4IMgnQCiwMgBgEENBMBAgQBAQEBAwIDAQEBAQEBE?=
 =?us-ascii?q?AEBBQEBAQIBAQIEBgECEAEBAQFASYV7DYJiATOCFiwIYwEfAQEBAyMdAQE4D?=
 =?us-ascii?q?wsYAgImAgJWBgGDFIJlA7BfgTKBAYIMAQEGgmnZN4FlCYEaLoVsgmMBgWyEO?=
 =?us-ascii?q?oQ8QoINhD8+iB6CaYIzgW+DLxGGS5xyCUl7HANZLAFVExcLBwWBKRA4Ayo2M?=
 =?us-ascii?q?SOBIwU1QTqCDWlJOgINAjWCHiRYgiuCIII5hEOETYJDUYJEghJ0bAMDFhABg?=
 =?us-ascii?q?jFweByECR1AAwttPTcGDhufVc5dhCWBY6AwgUuCJQGmYSyYUCKpDIF+I4FcM?=
 =?us-ascii?q?xoIJgqDIk8DGQ+OOog5wjpFMjwCBwsBAQMJhUQBimKBSwEB?=
IronPort-PHdr: A9a23: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
IronPort-Data: A9a23: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
 Z86q6VhLoxWNrEuVXMVhu8U
IronPort-HdrOrdr: A9a23:FwsXWagCtJsigfTdmJtiR4gh7nBQXukji2hC6mlwRA09TyX+rb
 HKoB17726XtN91YhodcL+7WZVoLUmyyXcx2+ks1NSZLW7bUQmTQb2KhLGKq1fd8m/Fh41gPM
 xbH5SWZuefMbE3t7ef3CCIV9IpxceO66ztju/Mx393JDsaDZ1d0w==
X-Talos-CUID: 9a23:1HPLH2H8nUNLSe4oqmI55FdFKOM/LESHxSrwDVbiAHZOUq2sHAo=
X-Talos-MUID: 9a23:vjrNSAVgTR62vNTq/DPS1TN8Msgr2rSJAQcDjZYpi5SrEzMlbg==
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,266,1732575600"; 
   d="scan'208";a="207111353"
X-MGA-submission: =?us-ascii?q?MDFs6DkjggTCptAGMbvKYosD1EzFYahQ5ITVs7?=
 =?us-ascii?q?1gUgzPuD0r+F2t9SNId+ofpbXc3DP6b31g9PxWB/N+tApVPFChZzPFvq?=
 =?us-ascii?q?tXUIR1ACD96M4Fmm/L07xLw1CL9tHFA/gXilH9n/3HLNNMcdWsPKFqjJ?=
 =?us-ascii?q?ITnjYZ4zCfSz5MAWofEVr/Eg=3D=3D?=
Received: from s3.sipsolutions.net (HELO sipsolutions.net) ([168.119.38.16])
  by mail2-smtp-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2025 09:59:57 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=bJy9wSyVs2NeHc2sySd6y7+u7eYrgdQF8MWynfH7fUo=;
	t=1738918797; x=1740128397; b=C1BaRo9gEPWBPWtlNs27cgN1s9Ge3eRwtR4V028qoWWkuKQ
	QsZHK5O06P0Brl+r+9Kf832gq9+bt/0SurbpKa+FkQ1uN91EJAaIDjTPztBhuaC+F359YuPsQy5WN
	pVfwP8PKCL1C2e7E1FM0lcIs5gMEv43x0TLN2We0CauHdE4DSEFBkwaKJCeq1/D10LFShAcmvnfPL
	t+7t+tm3G4wcf9mQHFkG5nMr6MoIglMjLEexDQsBJOLrLXIq+GOqV2494l8a2nbiJDIQ8QOLkdkCq
	+VDLPihqFeWWMR35DCmadkDwI+S1B7VLGlHG0X/xWdLgwXrvFGZBHrq3wdDD/+YA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tgKDJ-000000068n5-1BWe;
	Fri, 07 Feb 2025 09:59:53 +0100
Message-ID: <bf59a6a58a28828d3648d6e14416d4679c585f0b.camel@sipsolutions.net>
From: Johannes Berg <johannes@sipsolutions.net>
To: Markus Elfring <Markus.Elfring@web.de>, Julia Lawall
 <julia.lawall@inria.fr>, 	cocci@inria.fr
Date: Fri, 07 Feb 2025 09:59:52 +0100
In-Reply-To: <f67b5b79-09fe-433b-bd2a-6f50a00e4763@web.de>
References: 
	<381b5a9cb89cc068ca13546f69636291874010b3.camel@sipsolutions.net>
	 <061f1b6b50d305671c02742382a3df0ff95f9c6b.camel@sipsolutions.net>
	 <ca7c1a14-522a-9c2c-4f85-2fda289b83e8@inria.fr>
	 <9bfe9c42-ef0c-44ae-a71b-26207e9083ad@web.de>
	 <be231f53-bc7e-6aae-497d-ec83859957b@inria.fr>
	 <f67b5b79-09fe-433b-bd2a-6f50a00e4763@web.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
Subject: Re: [cocci] Checking software run time characteristics
Reply-To: Johannes Berg <johannes@sipsolutions.net>
X-Loop: cocci@inria.fr
X-Sequence: 2369
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
Archived-At: <https://sympa.inria.fr/sympa/arcsearch_id/cocci/2025-02/bf59a6a58a28828d3648d6e14416d4679c585f0b.camel%40sipsolutions.net>

On Fri, 2025-02-07 at 09:15 +0100, Markus Elfring wrote:
> >=20
>=20
> Can our discussion trigger any further software improvements?

You're kidding, right? Discussions with you specifically only ever waste
everyone's time.

johannes
